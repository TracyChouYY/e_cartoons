//
//  DDQEditPasswordController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/25.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQEditPasswordController.h"

@interface DDQEditPasswordController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *edit_contentViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *edit_contentViewLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *edit_contentViewRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *edit_buttonTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *edit_contentViewHeight;

@property (weak, nonatomic) IBOutlet UITextField *edit_passwordField;
@property (weak, nonatomic) IBOutlet UITextField *edit_newPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *edit_surePasswordField;
@property (weak, nonatomic) IBOutlet UIButton *edit_sureButton;

@end

@implementation DDQEditPasswordController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)updateViewConstraints {
    
    [super updateViewConstraints];
    
    self.edit_buttonTop.constant = 50.0 * self.base_widthRate;
    self.edit_contentViewTop.constant = 60.0 * self.base_widthRate + self.base_safeTopInset;
    self.edit_contentViewLeft.constant = 50.0 * self.base_widthRate;
    self.edit_contentViewRight.constant = 50.0 * self.base_widthRate;
    
}

- (NSString *)base_navigationTitle {
    
    return @"修改密码";
    
}

/**
 点击确认修改
 */
- (IBAction)edit_didSelectSure:(UIButton *)sender {
    
    if (self.edit_passwordField.text.length == 0) {
        
        [self alertHUDWithText:@"请输入原始密码" Delegate:nil];return;
        
    }
    
    if (self.edit_newPasswordField.text.length == 0) {
        
        [self alertHUDWithText:@"请输入新密码" Delegate:nil];return;
        
    }
    
    if (self.edit_surePasswordField.text.length == 0) {
        
        [self alertHUDWithText:@"请再次确认新密码" Delegate:nil];return;
        
    }
    
    if (![self.edit_newPasswordField.text isEqualToString:self.edit_surePasswordField.text]) {
        
        [self alertHUDWithText:@"两次密码输入不一致" Delegate:nil];return;

    }

    DDQWeakObject(self);
    NSString *requestUrl = [self.base_url stringByAppendingString:@"UserApi/uppwd"];
    [self foundation_processNetPOSTRequestWithUrl:requestUrl Param:@{@"uid":self.base_userID, @"pwd":self.edit_passwordField.text, @"pwd1":self.edit_newPasswordField.text, @"pwd2":self.edit_surePasswordField.text} WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
        
        return YES;
        
    } AfterAlert:^(int code) {
        
        if (code == 1) {
            
            [weakObjc base_handlePopController];
            
        }
    }];
}

#pragma mark - TextField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    [self.edit_sureButton setEnabled:YES];
    [self.edit_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.edit_sureButton setBackgroundColor:self.view.defaultBlueColor];
    return YES;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (self.edit_passwordField.text.length == 0 && self.edit_surePasswordField.text.length == 0 && self.edit_newPasswordField.text.length == 0) {
        
        [self.edit_sureButton setEnabled:NO];
        [self.edit_sureButton setTitleColor:self.view.default_password_buttonTitleColor forState:UIControlStateNormal];
        [self.edit_sureButton setBackgroundColor:self.view.default_password_buttonBackgroundColor];
        
    }
}

@end
