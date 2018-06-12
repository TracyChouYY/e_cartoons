//
//  DDQBindPhoneController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/6.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBindPhoneController.h"

@interface DDQBindPhoneController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *bind_phoneField;
@property (weak, nonatomic) IBOutlet UITextField *bind_codeField;
@property (weak, nonatomic) IBOutlet UITextField *bind_passwordField;
@property (weak, nonatomic) IBOutlet UIButton *bind_submitButton;
@property (weak, nonatomic) IBOutlet UIButton *bind_messageButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bind_submitButtonTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bind_contentTop;

@end

@implementation DDQBindPhoneController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    //Subview Config
    self.bind_submitButton.layer.cornerRadius = 5.0;
    self.bind_messageButton.layer.cornerRadius = 5.0;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (NSString *)base_navigationTitle {
    
    return @"绑定手机号";
}

- (void)updateViewConstraints {
    
    [super updateViewConstraints];
    
    self.bind_submitButtonTop.constant = 50.0 * self.base_widthRate;
    self.bind_contentTop.constant = self.base_safeTopInset + 50.0 * self.base_widthRate;
    
}

/**
 点击“获取验证码”按钮
 */
- (IBAction)bind_didSelectSendMessageCode:(UIButton *)sender {
    
    NSError * error = nil;
    [self base_handleInputContentType:DDQBaseHandleInputContentTypeAccount text:self.bind_phoneField.text showHud:YES error:&error];
    if (error) return;
    
    NSString *otherKey = @"wx";
    if ([self.bind_type isEqualToString:@"2"]) {
        
        otherKey = @"zfb";
        
    } else if ([self.bind_type isEqualToString:@"3"]) {
        
        otherKey = @"qq";
        
    }
    [self base_handleSendMessageCodeToRegister:NO otherParam:@{otherKey:@"1"} phone:self.bind_phoneField.text completed:^(int code) {
    
        if (code == 1) {
            
            [sender button_countDownWithInterval:1.0 totalTime:60.0 comletion:^(BOOL finished, NSDictionary * _Nullable beginSource) {
                
                if (finished) {
                    
                    [sender setTitle:beginSource[DDQButtonBeginTitle] forState:UIControlStateNormal];
                    
                }
            }];
        }
    }];
}

/**
 点击“提交”按钮
 */
- (IBAction)bind_didSelectSubmit:(UIButton *)sender {
    
    NSError *error = nil;
    [self base_handleInputContentType:DDQBaseHandleInputContentTypeAccount text:self.bind_phoneField.text showHud:YES error:&error];
    if (error) return;
    
    [self base_handleInputContentType:DDQBaseHandleInputContentTypeMessageCode text:self.bind_codeField.text showHud:YES error:&error];
    if (error) return;

    [self base_handleInputContentType:DDQBaseHandleInputContentTypePassword text:self.bind_passwordField.text showHud:YES error:&error];
    if (error) return;

    DDQWeakObject(self);
    NSString *requestUrl = [self.base_url stringByAppendingString:@"UserApi/tjphopwd"];
    NSDictionary *requestParam = @{@"uid":self.bind_uid?:@"", @"phone":self.bind_phoneField.text, @"yzm":self.bind_codeField.text, @"pwd":self.bind_passwordField.text, @"types":self.bind_type?:@""};
    [self foundation_processNetPOSTRequestWithUrl:requestUrl Param:requestParam WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
        
        if (code == 1) {
            
            [weakObjc base_handleUserInfomationWithData:response];

        }
        return YES;
        
    } AfterAlert:^(int code) {
        
        if (code == 1) {
            
            [DDQNotificationCenter postNotificationName:DDQLoginSuccessNotification object:nil];
            
        }
    }];
}

#pragma mark - Field Delegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    //就是只要有一个输入框里有内容
    if (self.bind_codeField.text.length == 0 && self.bind_phoneField.text.length == 0 && self.bind_passwordField.text.length == 0) {
        
        [self.bind_submitButton setTitleColor:self.view.default_password_buttonTitleColor forState:UIControlStateNormal];
        [self.bind_submitButton setBackgroundColor:self.view.default_password_buttonBackgroundColor];
        
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    [self.bind_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.bind_submitButton setBackgroundColor:self.view.defaultBlueColor];
    
    return YES;
    
}


@end
