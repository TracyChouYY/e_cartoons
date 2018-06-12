//
//  DDQUserInfomationManager.h
//
//  Copyright © 2018年 WICEP. All rights reserved.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class DDQUserInformationManager;
typedef void(^DDQInformationPropertyObserver)(DDQUserInformationManager *information);
/**
 用户信息的单例管理者
 */
@interface DDQUserInformationManager : NSObject

+ (instancetype)defaultManager;

#pragma mark - 公用字段
@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *state;

@property (nonatomic, copy) NSString *uname;

/**
 支付密码
 1、表示已设置支付密码，2、表示未设置支付密码
 */
@property (nonatomic, copy) NSString *zfpwd;

/**
 用户等级
 0、不是会员， 1、银牌，2、金牌，3、钻石
 */
@property (nonatomic, copy) NSString *yhdj;

/**
 是否发布过基地
 0表示未提交，1表示已提交
 */
@property (nonatomic, copy) NSString *base;

@property (nonatomic, copy) NSString *age;

/**
 是否进行过实名认证
 1、已认证。2、未认证
 */
@property (nonatomic, copy) NSString *rz;

/**
 性别
 1、是女，2、是男
 */
@property (nonatomic, copy) NSString *sex;

/**
 职业
 */
@property (nonatomic, copy) NSString *zy;

/**
 是否绑定手机号
 1未绑定，2已绑定
 */
@property (nonatomic, copy) NSString *bd;

#pragma mark - Base
@property (nonatomic, copy) NSString *jrxs;
@property (nonatomic, copy) NSString *ljxs;
@property (nonatomic, copy) NSString *wdcf;
@property (nonatomic, copy) NSString *bid;

#pragma mark - API
/**
 所有的key值
 */
@property (nonatomic, readonly) NSArray *information_allKeys;

/**
 值发生过改变过的属性名称集合。
 */
@property (nonatomic, readonly) NSArray<NSString *> *information_changeKeys;

/**
 Information的属性值发生改变

 @param observer 改变后的回调
 */
- (void)information_registerPropertyObserverChange:(DDQInformationPropertyObserver)observer;

/**
 取消对属性的观察
 */
- (void)information_invaildPropertyObserver;

/**
 清除保存的用户信息
 */
- (void)information_clearSaveInformationCompleted:(void(^)(void))completed;

@end

NS_ASSUME_NONNULL_END

