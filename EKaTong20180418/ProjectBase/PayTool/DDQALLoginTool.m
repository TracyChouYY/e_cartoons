//
//  DDQALLoginTool.m
//  WeiDuoShiGuang20171106
//
//  Created by 我叫咚咚枪 on 2018/1/3.
//  Copyright © 2018年 我叫咚咚枪. All rights reserved.
//

#import "DDQALLoginTool.h"

#import "DDQALLoginInfo.h"

#import "RSADataSigner.h"

#import <AlipaySDK/AlipaySDK.h>
#import <AFNetworking/AFNetworking.h>

#import "DDQProjectSet.h"

@interface DDQALLoginTool () {
    
    NSString *_partnerID;
    NSString *_appID;
    NSString *_privateKey;
    NSString *_signString;
}

@end

@implementation DDQALLoginTool

DDQALLoginInitializeParamKey const DDQALLoginInitializePartnerID = @"Initialize.PartnerID";
DDQALLoginInitializeParamKey const DDQALLoginInitializeAppID = @"Initialize.AppID";
DDQALLoginInitializeParamKey const DDQALLoginInitializePrivateKey = @"Initialize.PrivateKey";

DDQALLoginUserDataKey const DDQALLoginUserDataAvatar = @"LoginAvatar";
DDQALLoginUserDataKey const DDQALLoginUserDataNickname = @"LoginNickName";
DDQALLoginUserDataKey const DDQALLoginUserDataUserID = @"LoginUserID";
DDQALLoginUserDataKey const DDQALLoginUserDataSex = @"LoginSex";

- (instancetype)initALLoginWithParam:(NSDictionary<DDQALLoginInitializeParamKey,NSString *> *)param {
    
    self = [super init];
    
    NSArray<DDQALLoginInitializeParamKey> *needKeys = @[DDQALLoginInitializeAppID, DDQALLoginInitializePartnerID, DDQALLoginInitializePrivateKey];
    NSAssert(![param.allKeys isEqualToArray:needKeys], @"支付宝登录初始化，缺少对应参数哦！");
    
    _partnerID = param[DDQALLoginInitializePartnerID];
    _appID = param[DDQALLoginInitializeAppID];
    _privateKey = param[DDQALLoginInitializePrivateKey];
    return self;
}

- (void)dealloc {
    
#if DEBUG
    NSLog(@"%@", self);
#endif
    
}

- (void)al_awakeALAuth2Completed:(DDQALLoginCompleted)completed {
    
    NSString *appScehme = DDQALSchemes;
    
    //登录信息签名参数
    DDQALLoginInfo *loginInfo = [[DDQALLoginInfo alloc] init];
    loginInfo.appID = _appID;
    loginInfo.pid = _partnerID;
    NSString *infoDescription = [loginInfo description];
    
    //默认都是使用的RSA2签名
    RSADataSigner *signer = [[RSADataSigner alloc] initWithPrivateKey:_privateKey];
    NSString *signString = [signer signString:infoDescription withRSA2:YES urlEncode:YES];
    __block NSError *error = nil;
    if (signString.length == 0) {
        
        error = [NSError errorWithDomain:@"授权登录签名失败" code:DDQALLoginErrorCodeSignFailure userInfo:nil];
        if (completed) completed(error, nil);return;
    }

    infoDescription = [NSString stringWithFormat:@"%@&sign=%@&sign_type=%@", infoDescription, signString, @"RSA2"];
    [[AlipaySDK defaultService] auth_V2WithInfo:infoDescription fromScheme:appScehme callback:^(NSDictionary *resultDic) {
        
        int status = [resultDic[@"resultStatus"] intValue];
        //Code详情参见
        //https://docs.open.alipay.com/204/105301/
        if (status == 9000) {
            
            NSString *result = [resultDic valueForKey:@"result"];
            NSArray *components = [result componentsSeparatedByString:@"&"];
            NSString *authCode = nil;
            for (NSString *component in components) {
                
                NSArray *values = [component componentsSeparatedByString:@"="];
                if ([values.firstObject isEqualToString:@"auth_code"]) {
                    
                    authCode = values.lastObject;break;
                }
            }
            
            [self al_loginGetAuthTokenWithAuthCode:authCode signer:signer completed:completed];
            return;
            
        } else if (status == 6001) {
            
            error = [NSError errorWithDomain:@"您取消了登录" code:DDQALLoginErrorCodeUserCancel userInfo:nil];
            
        } else if (status == 6002) {
            
            error = [NSError errorWithDomain:@"当前网络异常" code:DDQALLoginErrorCodeRequestFailure userInfo:nil];
            
        } else if (status == 4000) {
            
            error = [NSError errorWithDomain:@"支付宝系统异常" code:DDQALLoginErrorCodeSystemUnusual userInfo:nil];
        }
        completed(error, nil);
    }];
}

/**
 获取支付宝登录AuthToken
 */
- (void)al_loginGetAuthTokenWithAuthCode:(NSString *)code signer:(RSADataSigner *)signer completed:(DDQALLoginCompleted)completed {
    
    NSString *dateString = [self al_getCurrentDateString];
    NSDictionary *tokenStaticParams = @{
                                        @"app_id":DDQALAppID,
                                        @"method":@"alipay.system.oauth.token",
                                        @"charset":@"utf-8",
                                        @"sign_type":@"RSA2",
                                        @"timestamp":dateString,
                                        @"version":@"1.0",
                                        @"grant_type":@"authorization_code",
                                        @"code":code,
                                        };
    NSMutableDictionary *tokenParams = [NSMutableDictionary dictionaryWithDictionary:tokenStaticParams];
    
    NSString *signString = [self al_getSignWithParams:tokenStaticParams];
    NSString *RSA2Sign = [signer signString:signString withRSA2:YES urlEncode:NO];
    [tokenParams setObject:RSA2Sign forKey:@"sign"];
    
    [[self al_netWorkingManager] GET:@"https://openapi.alipay.com/gateway.do" parameters:tokenParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSError *jsonError = nil;
        NSDictionary *tokenData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&jsonError];
        if (jsonError) {
            
            completed(jsonError, nil);
            
        } else {
            
            [self al_loginGetUserInfoWithAuthToken:tokenData[@"alipay_system_oauth_token_response"][@"access_token"] signer:signer completed:completed];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        completed(error, nil);
    }];
}

/**
 用authoToken换UserInfo
 */
- (void)al_loginGetUserInfoWithAuthToken:(NSString *)token signer:(RSADataSigner *)signer completed:(DDQALLoginCompleted)completed {
    
    NSString *dateString = [self al_getCurrentDateString];
    NSDictionary *infoStaticParam = @{
                                     @"app_id":DDQALAppID,
                                     @"method":@"alipay.user.info.share",
                                     @"charset":@"utf-8",
                                     @"sign_type":@"RSA2",
                                     @"timestamp":dateString,
                                     @"version":@"1.0",
                                     @"auth_token":token,
                                     };
    NSMutableDictionary *infoParams = [NSMutableDictionary dictionaryWithDictionary:infoStaticParam];

    NSString *signString = [self al_getSignWithParams:infoStaticParam];
    NSString *RSA2Sign = [signer signString:signString withRSA2:YES urlEncode:NO];
    [infoParams setObject:RSA2Sign forKey:@"sign"];
 
    [[self al_netWorkingManager] GET:@"https://openapi.alipay.com/gateway.do" parameters:infoParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *responseInfo = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *shareInfo = responseInfo[@"alipay_user_info_share_response"];
        NSDictionary *userInfo = @{DDQALLoginUserDataAvatar:shareInfo[@"avatar"]?:@"", DDQALLoginUserDataUserID:shareInfo[@"user_id"]?:@"", DDQALLoginUserDataNickname:shareInfo[@"nick_name"]?:@"", DDQALLoginUserDataSex:shareInfo[@"gender"]?:@""};
        completed(nil, userInfo);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        completed(error, nil);
    }];
}

/**
 获取许所需的当前时间参数
 */
- (NSString *)al_getCurrentDateString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:[NSDate date]];
}

/**
 获得签名所需参数串
 PS:一定要记得排序啊，啊，啊。
 */
- (NSString *)al_getSignWithParams:(NSDictionary *)params {
    
    NSMutableArray *keyValues = [NSMutableArray arrayWithCapacity:params.allKeys.count];
    NSArray *sortedKeys = [params.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        return [obj1 compare:obj2];
    }];
    
    for (NSString *key in sortedKeys) {
        
        [keyValues addObject:[NSString stringWithFormat:@"%@=%@", key, params[key]]];
    }
    
    return [keyValues componentsJoinedByString:@"&"];
}

/**
 SessionManager
 */
- (AFHTTPSessionManager *)al_netWorkingManager {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    AFJSONRequestSerializer *jsonRequest = [AFJSONRequestSerializer serializer];
    sessionManager.requestSerializer = jsonRequest;
    
    AFHTTPResponseSerializer *responseSer = [AFHTTPResponseSerializer serializer];
    NSMutableSet *acceptSet = responseSer.acceptableContentTypes.mutableCopy;
    [acceptSet addObject:@"html/text"];
    sessionManager.responseSerializer.acceptableContentTypes = acceptSet.copy;
    sessionManager.responseSerializer = responseSer;
    return sessionManager;
}

@end
