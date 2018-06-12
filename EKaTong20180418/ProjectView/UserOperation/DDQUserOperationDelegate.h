//
//  DDQUserOperationDelegate.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/19.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DDQUserOperationModel.h"

NS_ASSUME_NONNULL_BEGIN

@class DDQLoginView;

typedef NS_ENUM(NSUInteger, DDQLoginViewType) {
    
    DDQLoginViewTypePersonal,
    DDQLoginViewTypeBase,
    DDQLoginViewTypeManager,
    
};

typedef NS_ENUM(NSUInteger, DDQRegister_Base_PickerType) {
    
    DDQRegister_Base_PickerType_Contract,       //点击选择合同照
    DDQRegister_Base_PickerType_License,        //点击选择营业执照
    
};

typedef NS_ENUM(NSUInteger, DDQLoginThirdType) {
    
    DDQLoginThirdTypeWX,
    DDQLoginThirdTypeQQ,
    DDQLoginThirdTypeAL,
    
};

@protocol DDQUserOperationDelegate <NSObject>

@optional
#pragma mark - Login Delegate Method
- (void)login_didSelectLoginWithModel:(DDQUserOperationModel *)model;
- (void)login_didSelectDifferentViewType:(DDQLoginViewType)type loginView:(DDQLoginView *)view;
- (void)login_didSelectDifferentThirdLoginType:(DDQLoginThirdType)type;
- (void)login_didSelectForgetPassword;
- (void)login_didSelectToRegister;
- (void)login_didSelectUserProtocol;

- (void)login_base_didSelectUserProtocol;

#pragma mark - Register Delegate Method
- (void)register_didSelectSendMessageCode:(void(^)(BOOL send))message phone:(NSString *)phone;
- (void)register_didSelectRegisterWithModel:(DDQUserOperationModel *)model;
- (void)register_didSelectDifferentThirdLoginType:(DDQLoginThirdType)type;
- (void)register_didSelectUserProtocol;

#pragma mark - Register Delegate
/**
 基地注册

 @param model 页面输入的数据
 */
- (void)register_base_didSelectRegisterWithModel:(DDQUserOperationModel *)model;

/**
 基地注册发送验证码

 @param message 是否发送
 @param phone 发送的手机号
 */
- (void)register_base_didSelectSendMessageCode:(void(^)(BOOL send))message phone:(NSString *)phone;
- (void)register_base_didSelectPickerImage:(void(^)(UIImage *image))picker type:(DDQRegister_Base_PickerType)type;

#pragma mark - Forget Delegate Method
- (void)forget_didSelectSureWithModel:(DDQUserOperationModel *)model;
- (void)forget_didSelectSendMessageCode:(void(^)(BOOL send))message phone:(NSString *)phone;

@end

NS_ASSUME_NONNULL_END

