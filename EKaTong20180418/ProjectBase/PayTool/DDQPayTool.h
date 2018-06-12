//
//  DDQPayTool.h
//  WeiDuoShiGuang20171106
//
//  Created by 我叫咚咚枪 on 2017/12/30.
//  Copyright © 2017年 我叫咚咚枪. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <WXApi.h>

NS_ASSUME_NONNULL_BEGIN
/**
 第三方支付工具 - 支付宝、微信
 */
@interface DDQPayTool : NSObject

@end

typedef NSString *DDQALPayAwakeParamKey;
typedef NSString *DDQALPayInitializeParamKey;
typedef NS_ENUM(NSUInteger, DDQALPayErrorCode) {
    
    DDQALPayErrorSignFailure,
};
/**
 支付宝支付工具
 */
@interface DDQALPay : DDQPayTool

/**
 初始化支付宝支付类
 
 @param param 初始化所需参数
 @return 一个工具类
 */
- (instancetype)initALPayToolWithParam:(NSDictionary<DDQALPayInitializeParamKey, NSString *> *)param;

/**
 唤起支付宝
 
 @param param 唤起时所需参数
 @param handler 结果回调
 */
- (void)al_awakeALWithParam:(NSDictionary<DDQALPayAwakeParamKey, NSString *> *)param Handler:(void(^)(NSError *_Nullable alError))handler;

@end
//在初始化数据时，新版支付宝SDKAppID为必填选项，seller可以为空
FOUNDATION_EXTERN DDQALPayInitializeParamKey const DDQALPayInitPartnerKey;      //支付宝商户id
FOUNDATION_EXTERN DDQALPayInitializeParamKey const DDQALPayInitSellerKey;       //支付宝卖家
FOUNDATION_EXTERN DDQALPayInitializeParamKey const DDQALPayInitPrivateKey;      //支付宝私钥
FOUNDATION_EXTERN DDQALPayInitializeParamKey const DDQALPayInitAppIDKey;        //支付宝的AppID

FOUNDATION_EXTERN DDQALPayAwakeParamKey const DDQALPayAwakeNotifyUrlKey;        //支付宝回调地址
FOUNDATION_EXTERN DDQALPayAwakeParamKey const DDQALPayAwakeOrderIDKey;          //订单号
FOUNDATION_EXTERN DDQALPayAwakeParamKey const DDQALPayAwakeProductNameKey;      //商品名
FOUNDATION_EXTERN DDQALPayAwakeParamKey const DDQALPayAwakeProductPriceKey;     //商品价
FOUNDATION_EXTERN DDQALPayAwakeParamKey const DDQALPayAwakeUrlScheme;           //App调转

typedef NS_ENUM(NSUInteger, DDQWXPayErrorCode) {
    
    DDQWXPayErrorNotExist,
    DDQWXPayErrorNotSupport,
    DDQWXPayErrorSignFailure,
    DDQWXPayErrorRequestFailure,
};
typedef NSString *DDQWXAwakePayParamKey;
typedef void(^_Nullable DDQWXHandleCompleted)(NSError *_Nullable error);

/**
 微信支付工具
 */
@interface DDQWXPay : DDQPayTool<WXApiDelegate>

/** 微信支付单例 */
+ (instancetype)defaultWXPay;

/**
 微信支付所需参数
 @param appID 微信id
 @param partner 微信商户号
 @param key 商户Key
 */
- (void)wx_payInitialzeParamWithAppID:(NSString *)appID partner:(NSString *)partner key:(NSString *)key;

/**
 手机上是否安装微信
 */
+ (BOOL)wx_WXEixstInPhone;

/**
 唤起微信
 
 @param param 唤起微信所需参数
 @param handler 微信响应结果
 */
- (void)wx_awakeWXWithParam:(NSDictionary<DDQWXAwakePayParamKey, NSString *> *)param Handler:(DDQWXHandleCompleted)handler;

@end

FOUNDATION_EXTERN DDQWXAwakePayParamKey const DDQWXAwakePayParamTradeNo;                 //订单号
FOUNDATION_EXTERN DDQWXAwakePayParamKey const DDQWXAwakePayParamPrice;                   //订单价格
FOUNDATION_EXTERN DDQWXAwakePayParamKey const DDQWXAwakePayParamNotifyURL;               //订单回调地址
FOUNDATION_EXTERN DDQWXAwakePayParamKey const DDQWXAwakePayParamTitle;                   //订单标题

/**
 微信参数签名
 */
@interface DDQWXPay (DDQWXPaySigner)

/**
 微信支付参数签名
 
 @param param 参数
 @return md5的签名
 */
- (NSString *)wx_createMD5WithParam:(NSDictionary *)param;

@end

NS_ASSUME_NONNULL_END
