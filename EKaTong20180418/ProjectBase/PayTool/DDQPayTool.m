//
//  DDQPayTool.m
//  WeiDuoShiGuang20171106
//
//  Created by 我叫咚咚枪 on 2017/12/30.
//  Copyright © 2017年 我叫咚咚枪. All rights reserved.
//

#import "DDQPayTool.h"

@implementation DDQPayTool

@end

#import <AlipaySDK/AlipaySDK.h>
#import "DDQALPayProduct.h"
#import "RSADataSigner.h"

@interface DDQALPay () {
    
    NSString *_alPartner;
    NSString *_alSeller;
    NSString *_alPrivateKey;
    NSString *_alAppID;
}
@end

@implementation DDQALPay

DDQALPayInitializeParamKey const DDQALPayInitPartnerKey     = @"com.ddq.alPay.init.partner";
DDQALPayInitializeParamKey const DDQALPayInitSellerKey      = @"com.ddq.alPay.init.seller";
DDQALPayInitializeParamKey const DDQALPayInitPrivateKey     = @"com.ddq.alPay.init.privateKey";
DDQALPayInitializeParamKey const DDQALPayInitAppIDKey       = @"com.ddq.alPay.init.appID";

DDQALPayAwakeParamKey const DDQALPayAwakeNotifyUrlKey       = @"com.ddq.alPay.awake.notifyUrl";
DDQALPayAwakeParamKey const DDQALPayAwakeOrderIDKey         = @"com.ddq.alPay.awake.orderID";
DDQALPayAwakeParamKey const DDQALPayAwakeProductNameKey     = @"com.ddq.alPay.awake.productName";
DDQALPayAwakeParamKey const DDQALPayAwakeProductPriceKey    = @"com.ddq.alPay.awake.productPrice";
DDQALPayAwakeParamKey const DDQALPayAwakeUrlScheme          = @"com.ddq.alPay.awake.urlScheme";

- (instancetype)initALPayToolWithParam:(NSDictionary<DDQALPayInitializeParamKey,NSString *> *)param {
    
    if (![param isKindOfClass:[NSDictionary class]]) {
        NSException *paramEx = [NSException exceptionWithName:NSInvalidArgumentException reason:@"唤醒支付宝的参数必须是字典哦" userInfo:nil];
        [paramEx raise];
    }
    
    self = [super init];
    if (!self) return nil;
    
    _alPartner      = param[DDQALPayInitPartnerKey]?:@"";
    _alSeller       = param[DDQALPayInitSellerKey]?:@"";
    _alPrivateKey   = param[DDQALPayInitPrivateKey]?:@"";
    _alAppID        = param[DDQALPayInitAppIDKey]?:@"";
    return self;
}

- (void)al_awakeALWithParam:(NSDictionary<DDQALPayAwakeParamKey,NSString *> *)param Handler:(void (^)(NSError * _Nonnull))handler {
    
#warning 其实呢，这个签名本不该由前端做的￣へ￣，私钥也别保存在手机端里。
    //权限
    DDQALPayAuthority *authority = [[DDQALPayAuthority alloc] init];
    authority.al_appID = _alAppID;
    authority.al_method = @"alipay.trade.app.pay";
    authority.al_charset = @"utf-8";
    authority.al_version = @"1.0";
    authority.al_signType = @"RSA2";
    authority.al_notifyUrl = param[DDQALPayAwakeNotifyUrlKey]?:@"";
    //当前时间戳
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    authority.al_timestamp = [formatter stringFromDate:[NSDate date]];
    
    //商品数据
    DDQALPayProduct *product = [[DDQALPayProduct alloc] init];
    product.product_tradeNo = param[DDQALPayAwakeOrderIDKey]?:@"";
    product.product_sellerID = _alSeller;
    product.product_totalAmount = [NSString stringWithFormat:@"%.2f",[param[DDQALPayAwakeProductPriceKey] ? :@"" floatValue]];
    product.product_body = @"无";
    product.product_subject = param[DDQALPayAwakeProductNameKey]?:@"";
    product.product_timeout = @"30m";
    
    //Signer
    authority.al_product = product;
    NSString *orderSigner = [authority al_orderInfoEncode:NO];//encode
    RSADataSigner *dataSigner = [[RSADataSigner alloc] initWithPrivateKey:_alPrivateKey];
    NSString *signString = [dataSigner signString:orderSigner withRSA2:YES urlEncode:YES];
    
    __block NSError *error = nil;
    if (!signString) {
        error = [NSError errorWithDomain:@"支付宝签名失败" code:DDQALPayErrorSignFailure userInfo:nil];
        handler(error);return;
    }
    
    //Request
    NSString *appScheme = param[DDQALPayAwakeUrlScheme];
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@", orderSigner, signString];
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        
        NSError *resultError = nil;
        int status = [resultDic[@"resultStatus"] intValue];
        if (status == 4000) {
            resultError = [NSError errorWithDomain:@"支付系统异常" code:1 userInfo:nil];
        } else if (status == 6001) {
            resultError = [NSError errorWithDomain:@"您取消了支付" code:2 userInfo:nil];
        } else if (status == 6002) {
            resultError = [NSError errorWithDomain:@"网络连接出错" code:3 userInfo:nil];
        }
        
        if (handler) {
            handler(resultError);
        }
    }];
}
@end

#import "ApiXml.h"
#import <CommonCrypto/CommonDigest.h>

@interface DDQWXPay () {
    
    NSString *_wxAppID;
    NSString *_wxPartner;
    NSString *_wxKey;
    NSMutableString *_wxXMLInfo;
    id _wxObserver;
}
@property (nonatomic, copy) DDQWXHandleCompleted wx_completed;

@end

@implementation DDQWXPay

DDQWXAwakePayParamKey const DDQWXAwakePayParamTradeNo = @"WXTradeNO";
DDQWXAwakePayParamKey const DDQWXAwakePayParamPrice = @"WXPrice";
DDQWXAwakePayParamKey const DDQWXAwakePayParamNotifyURL = @"WXNotifyUrl";
DDQWXAwakePayParamKey const DDQWXAwakePayParamTitle = @"WXTitle";

NSNotificationName const DDQWXPayResultResponseNotification   = @"com.ddq.wxPay.wxResponseNotification";

+ (BOOL)wx_WXEixstInPhone {
    
    return [WXApi isWXAppInstalled];
}

+ (instancetype)defaultWXPay {
    
    static DDQWXPay *wxPay = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        wxPay = [[DDQWXPay alloc] init];
    });
    return wxPay;
}

- (void)wx_payInitialzeParamWithAppID:(NSString *)appID partner:(NSString *)partner key:(NSString *)key {
    
    _wxAppID = appID;
    _wxPartner = partner;
    _wxKey = key;
}

- (instancetype)init {
    
    self = [super init];
    
    _wxXMLInfo = [NSMutableString string];
    return self;
}

- (void)wx_awakeWXWithParam:(NSDictionary<DDQWXAwakePayParamKey,NSString *> *)param Handler:(DDQWXHandleCompleted)handler {
    
    //Authority
    NSError *error = nil;
    if (![WXApi isWXAppInstalled]) {
        
        error = [NSError errorWithDomain:@"设备未安装微信客户端" code:DDQWXPayErrorNotExist userInfo:nil];
        
    } else if (![WXApi isWXAppSupportApi]) {
        
        error = [NSError errorWithDomain:@"您的微信客户端版本过低" code:DDQWXPayErrorNotSupport userInfo:nil];
    
    }
    
    if (error) {//微信不支持或不存在'
        
        handler(error);return;
    
    }
    
    //请求预付款订单ID
    NSString *prepayID = [self wx_handleRequestPerprayIDWithTitle:param[DDQWXAwakePayParamTitle] price:param[DDQWXAwakePayParamPrice] tradeNo:param[DDQWXAwakePayParamTradeNo] notifyUrl:param[DDQWXAwakePayParamNotifyURL]];
    
    //Request Config
    PayReq *payRequest = [[PayReq alloc] init];
    payRequest.partnerId    = _wxPartner;
    payRequest.openID       = _wxAppID;
    payRequest.prepayId     = prepayID;
    payRequest.package      = @"Sign=WXPay";

    NSString *randomNumStr  = @(arc4random()%1000000 + 1000).stringValue;
    payRequest.nonceStr     = randomNumStr;
    
    NSTimeInterval times    = [NSDate date].timeIntervalSince1970;
    payRequest.timeStamp    = (unsigned int)times;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:payRequest.openID forKey:@"appid"];
    [params setObject:payRequest.partnerId forKey:@"partnerid"];
    [params setObject:payRequest.prepayId ? : @"" forKey:@"prepayid"];
    [params setObject:@(payRequest.timeStamp).stringValue forKey:@"timestamp"];
    [params setObject:payRequest.nonceStr forKey:@"noncestr"];
    [params setObject:payRequest.package forKey:@"package"];
    payRequest.sign         = [self wx_createMD5WithParam:params.copy];
    
    if (!payRequest.sign) {
        
        error = [NSError errorWithDomain:@"微信签名失败" code:DDQWXPayErrorSignFailure userInfo:nil];
        handler(error);return;
        
    }
    
    //Send Request
    BOOL send = [WXApi sendReq:payRequest];
    if (!send) {
        
        error = [NSError errorWithDomain:@"微信唤起失败，请稍后重试" code:DDQWXPayErrorRequestFailure userInfo:nil];
        handler(error);return;
        
    } else {
        
        if (handler) {
            
            self.wx_completed = handler;
        }
    }
}

/**
 随机生成nonceStr
 */
- (NSString *)wx_creatSpecialString {
    
    NSString *string = @"!$&'()*+,;=";
    NSInteger randomCount = arc4random()%string.length;
    if (randomCount > string.length) {
        return @"";
    }
    return [string substringWithRange:NSMakeRange(randomCount, 1)];
}

/**
 模拟服务器端请求订单号
 不想多说了，自力更生
 */
- (NSString *)wx_handleRequestPerprayIDWithTitle:(NSString *)title price:(NSString *)price tradeNo:(NSString *)tradeNo notifyUrl:(NSString *)notifyUrl {
    
    //订单标题，展示给用户
    NSString *order_name    = title;
    //订单金额,单位
    NSString *order_price = price;
    
    //================================
    //预付单参数订单设置
    //================================
    srand( (unsigned)time(0) );
    NSString *noncestr  = [NSString stringWithFormat:@"%d", rand()];
    NSString *orderno   = tradeNo;
    NSMutableDictionary *packageParams = [NSMutableDictionary dictionary];
    
    [packageParams setObject: _wxAppID            forKey:@"appid"];             //开放平台appid
    [packageParams setObject: _wxPartner             forKey:@"mch_id"];         //商户号
    [packageParams setObject: @"APP-001"        forKey:@"device_info"];         //支付设备号或门店号
    [packageParams setObject: noncestr          forKey:@"nonce_str"];           //随机串
    [packageParams setObject: @"APP"            forKey:@"trade_type"];          //支付类型，固定为APP
    [packageParams setObject: order_name        forKey:@"body"];                //订单描述，展示给用户
    [packageParams setObject: notifyUrl        forKey:@"notify_url"];           //支付结果异步通知
    [packageParams setObject: orderno           forKey:@"out_trade_no"];        //商户订单号
    [packageParams setObject: @"8.8.8.8"    forKey:@"spbill_create_ip"];        //发器支付的机器ip
    [packageParams setObject: order_price       forKey:@"total_fee"];           //订单金额，单位为分

    NSString *prePayid;
    prePayid            = [self sendPrepay:packageParams];

    return prePayid;
}

//获取package带参数的签名包
-(NSString *)genPackage:(NSMutableDictionary*)packageParams {
    
    NSString *sign;
    NSMutableString *reqPars=[NSMutableString string];
    //生成签名
    sign        = [self wx_createMD5WithParam:packageParams];
    //生成xml的package
    NSArray *keys = [packageParams allKeys];
    [reqPars appendString:@"<xml>\n"];
    
    for (NSString *categoryId in keys) {
        
        [reqPars appendFormat:@"<%@>%@</%@>\n", categoryId, [packageParams objectForKey:categoryId], categoryId];
    }
    [reqPars appendFormat:@"<sign>%@</sign>\n</xml>", sign];
    
    return [NSString stringWithString:reqPars];
}

//提交预支付
-(NSString *)sendPrepay:(NSMutableDictionary *)prePayParams {
    
    NSString *requestUrl = @"https://api.mch.weixin.qq.com/pay/unifiedorder";
    NSString *prepayid = nil;
    
    //获取提交支付
    NSString *send      = [self genPackage:prePayParams];
    
    //输出Debug Info
    [_wxXMLInfo appendFormat:@"API链接:%@\n", requestUrl];
    [_wxXMLInfo appendFormat:@"发送的xml:%@\n", send];
    
    //发送请求post xml数据
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestUrl] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5];
    //设置提交方式
    [request setHTTPMethod:@"POST"];
    //设置数据类型
    [request addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    //设置编码
    [request setValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    //如果是POST
    [request setHTTPBody:[send dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    //输出Debug Info
    [_wxXMLInfo appendFormat:@"服务器返回：\n%@\n\n",[[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding]];
    
    XMLHelper *xml  = [[XMLHelper alloc]init];
    
    //开始解析
    [xml startParse:response];
    NSMutableDictionary *resParams = [xml getDict];
    
    //判断返回
    NSString *return_code   = [resParams objectForKey:@"return_code"];
    NSString *result_code   = [resParams objectForKey:@"result_code"];
    if ( [return_code isEqualToString:@"SUCCESS"] )
    {
        //生成返回数据的签名
        NSString *sign      = [self wx_createMD5WithParam:resParams];
        NSString *send_sign =[resParams objectForKey:@"sign"] ;
        
        //验证签名正确性
        if( [sign isEqualToString:send_sign]){
            if( [result_code isEqualToString:@"SUCCESS"]) {
                //验证业务处理状态
                prepayid    = [resParams objectForKey:@"prepay_id"];
                return_code = 0;
                
                [_wxXMLInfo appendFormat:@"获取预支付交易标示成功！\n"];
            }
        } else {
            
            [_wxXMLInfo appendFormat:@"gen_sign=%@\n   _sign=%@\n",sign,send_sign];
            [_wxXMLInfo appendFormat:@"服务器返回签名验证错误！！！\n"];
        }
    } else {

        [_wxXMLInfo appendFormat:@"接口返回错误！！！\n"];
    }
    
    return prepayid;
}

#pragma mark - WXApi Delegate
- (void)onResp:(BaseResp *)resp {
    
    NSError *error = nil;
    if (resp.errCode == 0) {
        
        if (self.wx_completed) self.wx_completed(error);return;
    }
    
    if (resp.errCode == -1) {
        
        error = [NSError errorWithDomain:@"微信支付失败" code:1 userInfo:nil];
        
    } else if (resp.errCode == -2) {
        
        error = [NSError errorWithDomain:@"您取消了支付" code:2 userInfo:nil];

    } else if (resp.errCode == -5) {
        
        error = [NSError errorWithDomain:@"微信暂不支持此功能" code:3 userInfo:nil];

    } else {
        
        error = [NSError errorWithDomain:@"微信支付失败" code:4 userInfo:nil];
        
    }
    
    if (self.wx_completed) {
        
        self.wx_completed(error);
        
    }
}

@end

@implementation DDQWXPay (DDQWXPaySigner)

- (NSString *)wx_createMD5WithParam:(NSDictionary *)param {
    
    NSMutableString *contentString = [NSMutableString string];
    NSArray *keys = [param allKeys];
    
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        
        if (   ![[param objectForKey:categoryId] isEqualToString:@""]
            && ![categoryId isEqualToString:@"sign"]
            && ![categoryId isEqualToString:@"key"]
            ) {
            [contentString appendFormat:@"%@=%@&", categoryId, [param objectForKey:categoryId]];
        }
        
    }
    //添加key字段
    [contentString appendFormat:@"key=%@", _wxKey];
    
    //得到MD5 sign签名
    NSString *md5Sign = [self wx_md5Encode:contentString];
    
    return md5Sign;
}

- (NSString *)wx_md5Encode:(NSString *)str {
    
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (unsigned int)strlen(cStr), digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02X", digest[i]];
    
    return output;
}

@end
