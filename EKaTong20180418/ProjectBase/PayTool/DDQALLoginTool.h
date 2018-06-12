//
//  DDQALLoginTool.h
//  WeiDuoShiGuang20171106
//
//  Created by 我叫咚咚枪 on 2018/1/3.
//  Copyright © 2018年 我叫咚咚枪. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSString *DDQALLoginInitializeParamKey;
typedef NS_ENUM(NSUInteger, DDQALLoginErrorCode) {
    
    DDQALLoginErrorCodeSignFailure = 2000,       //签名失败
    DDQALLoginErrorCodeUserCancel,               //用户取消
    DDQALLoginErrorCodeSystemUnusual,            //支付宝系统异常
    DDQALLoginErrorCodeRequestFailure,           //支付宝请求失败
};
typedef NSString *DDQALLoginUserDataKey;
typedef void(^_Nonnull DDQALLoginCompleted)(NSError *_Nullable alError, NSDictionary<DDQALLoginUserDataKey, NSString *> *_Nullable alUserInfo);
/**
 支付宝第三方登录
 */
@interface DDQALLoginTool : NSObject

/** 初始化数据 */
- (instancetype)initALLoginWithParam:(NSDictionary<DDQALLoginInitializeParamKey, NSString *> *)param;

/**
 跳转支付宝，并获得请求后的用户信息
 */
- (void)al_awakeALAuth2Completed:(DDQALLoginCompleted)completed;

@end

FOUNDATION_EXTERN DDQALLoginInitializeParamKey const DDQALLoginInitializePartnerID;    //商户ID
FOUNDATION_EXTERN DDQALLoginInitializeParamKey const DDQALLoginInitializeAppID;        //应用ID
FOUNDATION_EXTERN DDQALLoginInitializeParamKey const DDQALLoginInitializePrivateKey;   //私钥

FOUNDATION_EXTERN DDQALLoginUserDataKey const DDQALLoginUserDataAvatar;     //用户头像地址
FOUNDATION_EXTERN DDQALLoginUserDataKey const DDQALLoginUserDataNickname;   //用户昵称
FOUNDATION_EXTERN DDQALLoginUserDataKey const DDQALLoginUserDataUserID;     //用户ID
FOUNDATION_EXTERN DDQALLoginUserDataKey const DDQALLoginUserDataSex;        //用户性别

NS_ASSUME_NONNULL_END
