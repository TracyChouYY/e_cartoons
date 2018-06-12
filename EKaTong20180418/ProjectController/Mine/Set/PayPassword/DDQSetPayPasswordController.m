//
//  DDQSetPayPasswordController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/13.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQSetPayPasswordController.h"

@interface DDQSetPayPasswordController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *set_passwordField;
@property (weak, nonatomic) IBOutlet UITextField *set_surePasswordField;
@property (weak, nonatomic) IBOutlet UIButton *set_sureButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *content_top;

@end

@implementation DDQSetPayPasswordController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

}

- (NSString *)base_navigationTitle {
    
    return @"设置支付密码";
    
}

- (void)updateViewConstraints {
    
    [super updateViewConstraints];
    
    self.content_top.constant = 60.0 * self.base_widthRate + self.base_safeTopInset;
    
}

/**
 点击确认按钮
 */
- (IBAction)set_didSelectSureWithButton:(UIButton *)sender {
        
    NSError *error = nil;
    [self base_handleInputContentType:DDQBaseHandleInputContentTypePassword text:self.set_passwordField.text showHud:YES error:&error];
    if (error) return;
    
    [self base_handleInputContentType:DDQBaseHandleInputContentTypeSurePassword text:self.set_surePasswordField.text showHud:YES error:&error];
    if (error) return;

    if (![self.set_passwordField.text isEqualToString:self.set_surePasswordField.text]) {
        
        [self alertHUDWithText:@"两次密码输入不一致" Delegate:nil];return;
        
    }

    DDQWeakObject(self);
    NSString *requestUrl = [self.base_url stringByAppendingString:@"UserApi/addzfpwd"];
    [self foundation_processNetPOSTRequestWithUrl:requestUrl Param:@{@"uid":self.base_userID, @"zfpwd":self.set_passwordField.text, @"zfpwd1":self.set_surePasswordField.text} WhenHUDHidden:^BOOL(id  _Nullable response, int code) {

        if (code == 1) {
            
            weakObjc.base_infomationManager.zfpwd = @"1";

        }
        return YES;

    } AfterAlert:^(int code) {

        if (code == 1) {

            [weakObjc base_handlePopController];

        }
    }];
}

#pragma mark - TextField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    [self.set_sureButton setEnabled:YES];
    [self.set_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.set_sureButton setBackgroundColor:self.view.defaultBlueColor];
    return YES;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (self.set_passwordField.text.length == 0 && self.set_surePasswordField.text.length == 0) {
        
        [self.set_sureButton setEnabled:NO];
        [self.set_sureButton setTitleColor:self.view.default_password_buttonTitleColor forState:UIControlStateNormal];
        [self.set_sureButton setBackgroundColor:self.view.default_password_buttonBackgroundColor];

    }
}

@end
