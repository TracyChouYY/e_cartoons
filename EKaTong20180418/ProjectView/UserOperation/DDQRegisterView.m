//
//  DDQRegisterView.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/18.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQRegisterView.h"

#import "DDQUserOperationInputView.h"
#import "DDQUserOperationHeaderView.h"
#import "DDQUserOperationThirdLoginView.h"

@interface DDQRegisterView () <DDQUserOperationInputViewDelegate, DDQUserOperationThirdLoginViewDelegate>

@property (nonatomic, strong) DDQUserOperationHeaderView *register_headerView;
@property (nonatomic, strong) DDQUserOperationInputView *register_phoneView;
@property (nonatomic, strong) DDQUserOperationInputView *register_messageView;
@property (nonatomic, strong) DDQUserOperationInputView *register_passwordView;
@property (nonatomic, strong) UIButton *register_registerButton;
@property (nonatomic, strong) DDQUserOperationThirdLoginView *register_loginView;

@end

@implementation DDQRegisterView

- (void)view_subviewsConfig {
    
    [super view_subviewsConfig];
    
    self.register_headerView = [[DDQUserOperationHeaderView alloc] initHeaderViewWithStyle:DDQUserOperationHeaderViewStyleRegister];
    
    self.register_phoneView = [[DDQUserOperationInputView alloc] initInputViewWithStyle:DDQUserOperationInputViewStylePhone placeholder:@"手机号码"];
    
    self.register_messageView = [[DDQUserOperationInputView alloc] initInputViewWithStyle:DDQUserOperationInputViewStyleMessageCode placeholder:@"验证码"];
    self.register_messageView.delegate = self;

    self.register_passwordView = [[DDQUserOperationInputView alloc] initInputViewWithStyle:DDQUserOperationInputViewStylePassword placeholder:@"密码"];

    self.register_registerButton = [UIButton buttonChangeFont:DDQFont(14.0) titleColor:[UIColor whiteColor] image:nil backgroundImage:nil title:@"注册账号" attributeTitle:nil target:self sel:@selector(register_didSelectRegister)];
    self.register_registerButton.layer.cornerRadius = 3.0;
    self.register_registerButton.backgroundColor = self.defaultBlueColor;
    
    self.register_loginView = [[DDQUserOperationThirdLoginView alloc] initViewWithFrame:CGRectZero];
    self.register_loginView.delegate = self;
    
    [self view_configSubviews:@[self.register_headerView, self.register_phoneView, self.register_messageView, self.register_passwordView, self.register_registerButton, self.register_loginView]];
    
}

- (void)view_updateContentSubviewsFrame {
    
    [super view_updateContentSubviewsFrame];

    DDQViewVHMargin margin = DDQViewVHMarginMaker(15.0 * self.view_widthRate, 20.0 * self.view_widthRate);
    autoLayout(self.register_headerView).ddq_leading(self.leading, margin.horMargin).ddq_top(self.top, margin.verMargin).ddq_fitSize();
    
    autoLayout(self.register_phoneView).ddq_leading(self.register_headerView.leading, 0.0).ddq_top(self.register_headerView.bottom, 20.0 * self.view_widthRate).ddq_size(CGSizeMake(self.width - self.register_headerView.x * 2.0, self.register_phoneView.input_estimateHeight));
    
    autoLayout(self.register_messageView).ddq_leading(self.register_phoneView.leading, 0.0).ddq_top(self.register_phoneView.bottom, 10.0 * self.view_widthRate).ddq_size(CGSizeMake(self.width - self.register_messageView.x * 2.0, self.register_messageView.input_estimateHeight));
    
    autoLayout(self.register_passwordView).ddq_leading(self.register_messageView.leading, 0.0).ddq_top(self.register_messageView.bottom, 10.0 * self.view_widthRate).ddq_size(CGSizeMake(self.register_messageView.width, self.register_passwordView.input_estimateHeight));
    
    autoLayout(self.register_registerButton).ddq_leading(self.register_passwordView.leading, 0.0).ddq_top(self.register_passwordView.bottom, 45.0 * self.view_widthRate).ddq_size(CGSizeMake(self.register_passwordView.width, 45.0));

    autoLayout(self.register_loginView).ddq_centerX(self.centerX, 0.0).ddq_bottom(self.bottom, 20.0 * self.view_widthRate).ddq_fitSize();
    
}

/**
 点击“注册账号”
 */
- (void)register_didSelectRegister {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(register_didSelectRegisterWithModel:)]) {
        
        DDQUserOperationModel *model = [DDQUserOperationModel mj_objectWithKeyValues:@{}];
        model.register_phone = self.register_phoneView.input_field.text;
        model.register_password = self.register_passwordView.input_field.text;
        model.register_messageCode = self.register_messageView.input_field.text;
        model.register_respectProtocol = self.register_loginView.login_respectProtocol;
        [self.delegate register_didSelectRegisterWithModel:model];
        
    }
}

- (void)setRegister_installWX:(BOOL)register_installWX {
    
    _register_installWX = register_installWX;
    
    self.register_loginView.login_installWechat = _register_installWX;
    
}

#pragma mark - Custom View Delegate
- (void)input_didSelectSendMessageCode:(DDQInputViewSendMessageCodeBlock)block {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(register_didSelectSendMessageCode:phone:)]) {
        
        [self.delegate register_didSelectSendMessageCode:^(BOOL send) {
            
            block(send);
            
        } phone:self.register_phoneView.input_field.text];
    }
}

- (void)third_didSelectUserProtocol {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(register_didSelectUserProtocol)]) {
        
        [self.delegate register_didSelectUserProtocol];
        
    }
}

- (void)third_didSelectThirdLoginWithType:(DDQUserOperationThirdLoginType)type {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(register_didSelectDifferentThirdLoginType:)]) {
        
        DDQLoginThirdType thirdType = DDQLoginThirdTypeAL;
        switch (type) {
                
            case DDQUserOperationThirdLoginTypeAL:
                thirdType = DDQLoginThirdTypeAL;
                break;
                
            case DDQUserOperationThirdLoginTypeQQ:
                thirdType = DDQLoginThirdTypeQQ;
                break;
                
            case DDQUserOperationThirdLoginTypeWX:
                thirdType = DDQLoginThirdTypeWX;
                break;
                
            default:
                break;
        }
        
        [self.delegate register_didSelectDifferentThirdLoginType:thirdType];
        
    }
}

@end
