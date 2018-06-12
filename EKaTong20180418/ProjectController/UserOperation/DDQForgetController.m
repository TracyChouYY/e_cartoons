//
//  DDQForgetController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/19.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQForgetController.h"

#import "DDQForgetView.h"

@interface DDQForgetController () <DDQUserOperationDelegate>

@property (nonatomic, strong) DDQForgetView *forget_view;

@end

@implementation DDQForgetController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //Subview
    self.forget_view = [[DDQForgetView alloc] initViewWithFrame:CGRectZero];
    [self.view addSubview:self.forget_view];
    self.forget_view.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];

}

- (DDQBaseNavigationBarStyle)base_navigationBarStyle {
    
    return DDQBaseNavigationBarStyleWhiteAndBackHiddenShadow;
    
}

#pragma mark - Custom View Delegate
- (void)forget_didSelectSureWithModel:(DDQUserOperationModel *)model {
    
    NSError *error = nil;
    [self base_handleInputContentType:DDQBaseHandleInputContentTypeAccount text:model.forget_phone showHud:YES error:&error];
    if (error) return;
    
    [self base_handleInputContentType:DDQBaseHandleInputContentTypeMessageCode text:model.forget_messageCode showHud:YES error:&error];
    if (error) return;
    
    [self base_handleInputContentType:DDQBaseHandleInputContentTypePassword text:model.forget_password showHud:YES error:&error];
    if (error) return;
    
    [self base_handleInputContentType:DDQBaseHandleInputContentTypeSurePassword text:model.forget_surePassword showHud:YES error:&error];
    if (error) return;
    
    NSString *requestUrl = [self.base_url stringByAppendingString:@"UserApi/forgpwd"];
    NSDictionary *requestParam = @{@"phone":model.forget_phone,
                                   @"code":model.forget_messageCode,
                                   @"pwd":model.forget_password,
                                   @"newpwd":model.forget_surePassword
                                   };
    DDQWeakObject(self);
    [self foundation_processNetPOSTRequestWithUrl:requestUrl Param:requestParam WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
        
        return YES;
        
    } AfterAlert:^(int code) {
        
        if (code == 1) {
            
            [weakObjc base_handlePopController];
            
        }
    }];
}

- (void)forget_didSelectSendMessageCode:(void (^)(BOOL))message phone:(NSString *)phone {
    
    NSError *error = nil;
    [self base_handleInputContentType:DDQBaseHandleInputContentTypeAccount text:phone showHud:YES error:&error];
    if (error) return;
    
    [self base_handleSendMessageCodeToRegister:NO phone:phone completed:^(int code) {
        
        message((code == 1) ? YES : NO);
        
    }];
}

@end
