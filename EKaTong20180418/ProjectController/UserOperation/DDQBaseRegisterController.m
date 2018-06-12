//
//  DDQBaseRegisterController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/20.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBaseRegisterController.h"

#import "DDQBaseRegisterView.h"

typedef void(^DDQRegisterPikcer)(UIImage *image);
@interface DDQBaseRegisterController () <DDQUserOperationDelegate>

@property (nonatomic, assign) DDQRegister_Base_PickerType register_picekType;
@property (nonatomic, strong) DDQBaseRegisterView *registerView;
@property (nonatomic, copy) DDQRegisterPikcer picker;
@property (nonatomic, strong) NSMutableDictionary *register_images;

@end

@implementation DDQBaseRegisterController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.register_images = [NSMutableDictionary dictionaryWithCapacity:2];
    
    //Subview
    self.registerView = [[DDQBaseRegisterView alloc] initViewWithFrame:CGRectZero];
    [self.view addSubview:self.registerView];
    self.registerView.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];

}

- (DDQBaseNavigationBarStyle)base_navigationBarStyle {
    
    return DDQBaseNavigationBarStyleWhiteAndBackHiddenShadow;
    
}

#pragma mark - Custom Delegate
- (void)register_base_didSelectPickerImage:(void (^)(UIImage * _Nonnull))picker type:(DDQRegister_Base_PickerType)type {
    
    self.picker = picker;
    self.register_picekType = type;
    [self base_presentImagePickerAlertControllerWithDelegate:self];
    
}

- (void)register_base_didSelectSendMessageCode:(void (^)(BOOL))message phone:(NSString *)phone {
    
    NSError *error = nil;
    [self base_handleInputContentType:DDQBaseHandleInputContentTypeAccount text:phone showHud:YES error:&error];
    if (error) return;

    [self base_handleSendMessageCodeToRegister:YES phone:phone completed:^(int code) {
        
        message((code == 1) ? YES : NO);
        
    }];
}

- (void)register_base_didSelectRegisterWithModel:(DDQUserOperationModel *)model {
    
    NSError *error = nil;
    [self base_handleInputContentType:DDQBaseHandleInputContentTypeAccount text:model.register_base_phone showHud:YES error:&error];
    if (error) return;
    
    [self base_handleInputContentType:DDQBaseHandleInputContentTypeMessageCode text:model.register_base_messageCode showHud:YES error:&error];
    if (error) return;

    [self base_handleInputContentType:DDQBaseHandleInputContentTypePassword text:model.register_base_password showHud:YES error:&error];
    if (error) return;

    if (model.register_base_name.length == 0) {
        
        [self alertHUDWithText:@"请输入基地名称！" Delegate:nil];return;
        
    }
    
    if (model.register_base_company.length == 0) {
        
        [self alertHUDWithText:@"请输入单位名称！" Delegate:nil];return;
        
    }
    
    if (model.register_base_bankAccount.length == 0) {
        
        [self alertHUDWithText:@"请输入银行账号！" Delegate:nil];return;
        
    }
    
    if (model.register_base_bankName.length == 0) {//15733287311
        
        [self alertHUDWithText:@"请输入开户行！" Delegate:nil];return;
        
    }
    
    //图片选择
    if (![self.register_images.allKeys containsObject:@"agreement"]) {
        
        [self alertHUDWithText:@"请上传合同协议！" Delegate:nil];return;
        
    }
    
    if (![self.register_images.allKeys containsObject:@"license"]) {
        
        [self alertHUDWithText:@"请上传营业执照！" Delegate:nil];return;
        
    }

    if (model.register_base_contact.length == 0) {
        
        [self alertHUDWithText:@"请输入联系人！" Delegate:nil];return;
        
    }
    
    if (model.register_base_tel.length == 0) {
        
        [self alertHUDWithText:@"请输入电话！" Delegate:nil];return;
        
    }
    
    if (model.register_base_mobile.length == 0) {
        
        [self alertHUDWithText:@"请输入手机！" Delegate:nil];return;
        
    } else {
        
        if (![self foundation_checkPhone:model.register_base_mobile]) {
            
            [self alertHUDWithText:@"输入的手机号有误！" Delegate:nil];return;

        }
    }
    
    //是否阅读协议
    if (!model.register_base_respectProtocol) {
        
        [self alertHUDWithText:@"请先阅读用户协议！" Delegate:nil];return;

    }
    
    NSString *requestUrl = [self.base_url stringByAppendingString:@"UserApi/basereg"];
    NSDictionary *requestParam = @{@"phone":model.register_base_phone,
                                   @"password":model.register_base_password,
                                   @"yzm":model.register_base_messageCode,
                                   @"bname":model.register_base_name,
                                   @"uname":model.register_base_company,
                                   @"bnum":model.register_base_bankAccount,
                                   @"bank":model.register_base_bankName,
                                   @"agreement":self.register_images[@"agreement"],
                                   @"license":self.register_images[@"license"],
                                   @"user":model.register_base_contact,
                                   @"call":model.register_base_tel,
                                   @"uphone":model.register_base_mobile};
    DDQWeakObject(self);
    [self foundation_processNetPOSTRequestWithUrl:requestUrl Param:requestParam WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
        
        return YES;
        
    } AfterAlert:^(int code) {
        
        if (code == 1) {
            
            [weakObjc base_handlePopController];
            
        }
    }];
}

#pragma mark - Alert Delegate
- (void)alert_didSelectItem:(DDQAlertItem *)item {
    
    DDQFoundationAuthorityType type = (item.tag == 1) ? DDQFoundationAuthorityPhotoLibary : DDQFoundationAuthorityCamera;
    
    DDQWeakObject(self);
    [self base_handleImagePickControllerCompleted:^(UIImage * _Nullable scaleImage, NSString * _Nonnull extension) {
        
        weakObjc.picker(scaleImage);
        NSString *imageString = [weakObjc base_changeBase64StringWithImage:scaleImage];
        NSString *keyName = (weakObjc.register_picekType == DDQRegister_Base_PickerType_Contract) ? @"agreement" : @"license";
        [weakObjc.register_images setObject:imageString forKey:keyName];
        
    } scale:0.5 authorityType:type editing:NO];
}

@end
