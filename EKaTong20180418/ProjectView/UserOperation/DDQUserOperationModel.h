//
//  DDQUserOperationModel.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/19.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import <DDQProjectFoundation/DDQFoundationModel.h>

#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

/**
 用户操作 - 输入的内容
 */
@interface DDQUserOperationModel : DDQFoundationModel

#pragma mark - Login
@property (nonatomic, copy) NSString *login_phone;
@property (nonatomic, copy) NSString *login_password;
@property (nonatomic, assign) BOOL login_respectProtocol;

#pragma mark - Register
@property (nonatomic, copy) NSString *register_phone;
@property (nonatomic, copy) NSString *register_messageCode;
@property (nonatomic, copy) NSString *register_password;
@property (nonatomic, assign) BOOL register_respectProtocol;

#pragma mark - Base Register
@property (nonatomic, copy) NSString *register_base_phone;
@property (nonatomic, copy) NSString *register_base_messageCode;
@property (nonatomic, copy) NSString *register_base_password;
@property (nonatomic, copy) NSString *register_base_name;
@property (nonatomic, copy) NSString *register_base_company;
@property (nonatomic, copy) NSString *register_base_bankAccount;
@property (nonatomic, copy) NSString *register_base_bankName;
@property (nonatomic, copy) NSString *register_base_contact;
@property (nonatomic, copy) NSString *register_base_tel;
@property (nonatomic, copy) NSString *register_base_mobile;
@property (nonatomic, assign) BOOL register_base_respectProtocol;
//@property (nonatomic, copy) NSString *register_base_contractBase64;
//@property (nonatomic, copy) NSString *register_base_licenseBase64;

#pragma mark - Forget
@property (nonatomic, copy) NSString *forget_phone;
@property (nonatomic, copy) NSString *forget_messageCode;
@property (nonatomic, copy) NSString *forget_password;
@property (nonatomic, copy) NSString *forget_surePassword;

@end

NS_ASSUME_NONNULL_END
