//
//  DDQEditPayPasswordController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/13.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQEditPayPasswordController.h"

@interface DDQEditPayPasswordController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *edit_passwordField;
@property (weak, nonatomic) IBOutlet UITextField *edit_newPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *edit_surePasswordField;
@property (weak, nonatomic) IBOutlet UIButton *edit_sureButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *content_top;

@end

@implementation DDQEditPayPasswordController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (NSString *)base_navigationTitle {
    
    return @"修改支付密码";
    
}

- (void)updateViewConstraints {
    
    [super updateViewConstraints];
    
    self.content_top.constant = 60.0 * self.base_widthRate + self.base_safeTopInset;
    
}

/**
 点击确认按钮
 */
- (IBAction)edit_didSelectSure {
    
    NSError *error = nil;
    [self base_handleInputContentType:DDQBaseHandleInputContentTypePassword text:self.edit_passwordField.text showHud:YES error:&error];
    if (error) return;
    
    [self base_handleInputContentType:DDQBaseHandleInputContentTypePassword text:self.edit_newPasswordField.text showHud:YES error:&error];
    if (error) return;

    [self base_handleInputContentType:DDQBaseHandleInputContentTypeSurePayPassword text:self.edit_surePasswordField.text showHud:YES error:&error];
    if (error) return;
    
    if (![self.edit_newPasswordField.text isEqualToString:self.edit_surePasswordField.text]) {
        
        [self alertHUDWithText:@"两次密码输入不一致！" Delegate:nil];return;
        
    }
    
    DDQWeakObject(self);
    NSString *requestUrl = [self.base_url stringByAppendingString:@"UserApi/upzfpwd"];
    NSDictionary *requestParam = @{@"uid":self.base_userID, @"zfpwd":self.edit_passwordField.text, @"zfpwd1":self.edit_newPasswordField.text, @"zfpwd2":self.edit_surePasswordField.text};
    [self foundation_processNetPOSTRequestWithUrl:requestUrl Param:requestParam WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
        
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
    
    if (self.edit_passwordField.text.length == 0 && self.edit_newPasswordField.text.length == 0 && self.edit_surePasswordField.text.length == 0) {
        
        [self.edit_sureButton setEnabled:NO];
        [self.edit_sureButton setTitleColor:self.view.default_password_buttonTitleColor forState:UIControlStateNormal];
        [self.edit_sureButton setBackgroundColor:self.view.default_password_buttonBackgroundColor];
        
    }
}

@end
