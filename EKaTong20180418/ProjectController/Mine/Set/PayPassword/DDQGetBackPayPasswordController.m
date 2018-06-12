//
//  DDQGetBackPayPasswordController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/13.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQGetBackPayPasswordController.h"

@interface DDQGetBackPayPasswordController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *get_phoneField;
@property (weak, nonatomic) IBOutlet UITextField *get_messageCodeField;
@property (weak, nonatomic) IBOutlet UIButton *get_messageCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *get_newPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *get_surePasswordField;
@property (weak, nonatomic) IBOutlet UIButton *get_surePasswordButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *content_top;

@end

@implementation DDQGetBackPayPasswordController

- (void)viewDidLoad {
    
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor whiteColor];

}

- (NSString *)base_navigationTitle {
    
    return @"找回支付密码";
    
}

- (void)updateViewConstraints {
    
    [super updateViewConstraints];
    
    self.content_top.constant = 60.0 * self.base_widthRate + self.base_safeTopInset;
    
}

/**
 点击确认按钮
 */
- (IBAction)get_didSelectSure {
    
    NSError *error = nil;
    [self base_handleInputContentType:DDQBaseHandleInputContentTypeAccount text:self.get_phoneField.text showHud:YES error:&error];
    if (error) return;
    
    [self base_handleInputContentType:DDQBaseHandleInputContentTypeMessageCode text:self.get_messageCodeField.text showHud:YES error:&error];
    if (error) return;

    [self base_handleInputContentType:DDQBaseHandleInputContentTypePayPassword text:self.get_newPasswordField.text showHud:YES error:&error];
    if (error) return;

    [self base_handleInputContentType:DDQBaseHandleInputContentTypeSurePayPassword text:self.get_surePasswordField.text showHud:YES error:&error];
    if (error) return;
    
    if (![self.get_newPasswordField.text isEqualToString:self.get_surePasswordField.text]) {
        
        [self alertHUDWithText:@"两次密码输入不一致！" Delegate:nil];return;
        
    }

    NSString *requestUrl = [self.base_url stringByAppendingString:@"UserApi/forgzfpwd"];
    NSDictionary *requestParam = @{@"uid":self.base_userID, @"phone":self.get_phoneField.text, @"code":self.get_messageCodeField.text, @"zfpwd":self.get_newPasswordField.text, @"zfpwd1":self.get_surePasswordField.text};
    DDQWeakObject(self);
    [self foundation_processNetPOSTRequestWithUrl:requestUrl Param:requestParam WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
        
        return YES;
        
    } AfterAlert:^(int code) {
        
        if (code == 1) {
            
            [weakObjc base_handlePopController];
            
        }
    }];
}

/**
 点击发送验证码
 */
- (IBAction)get_didSelectSendMessageCodeWithButton:(UIButton *)sender {
 
    NSError *error = nil;
    [self base_handleInputContentType:DDQBaseHandleInputContentTypeAccount text:self.get_phoneField.text showHud:YES error:&error];
    if (error) return;
    
    [self base_handleSendMessageCodeToRegister:NO phone:self.get_phoneField.text completed:^(int code) {
        
        if (code == 1) {
            
            [sender button_countDownWithInterval:1.0 totalTime:60.0 comletion:^(BOOL finished, NSDictionary * _Nullable beginSource) {
                
                if (finished) {
                    
                    [sender setTitle:beginSource[DDQButtonBeginTitle] forState:UIControlStateNormal];
                    
                }
            }];
        }
    }];
}

#pragma mark - TextField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    [self.get_surePasswordButton setEnabled:YES];
    [self.get_surePasswordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.get_surePasswordButton setBackgroundColor:self.view.defaultBlueColor];
    return YES;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (self.get_phoneField.text.length == 0 && self.get_newPasswordField.text.length == 0 && self.get_messageCodeField.text.length == 0 &&  self.get_surePasswordField.text.length == 0) {
        
        [self.get_surePasswordButton setEnabled:NO];
        [self.get_surePasswordButton setTitleColor:self.view.default_password_buttonTitleColor forState:UIControlStateNormal];
        [self.get_surePasswordButton setBackgroundColor:self.view.default_password_buttonBackgroundColor];
        
    }
}

@end
