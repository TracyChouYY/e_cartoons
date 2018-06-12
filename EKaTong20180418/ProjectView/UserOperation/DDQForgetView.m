//
//  DDQForgetView.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/19.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQForgetView.h"

#import "DDQUserOperationModel.h"

#import "DDQUserOperationInputView.h"
#import "DDQUserOperationHeaderView.h"

@interface DDQForgetView () <DDQUserOperationInputViewDelegate>

@property (nonatomic, strong) DDQUserOperationHeaderView *forget_headerView;
@property (nonatomic, strong) DDQUserOperationInputView *forget_phoneView;
@property (nonatomic, strong) DDQUserOperationInputView *forget_messageView;
@property (nonatomic, strong) DDQUserOperationInputView *forget_passwordView;
@property (nonatomic, strong) DDQUserOperationInputView *forget_surePasswordView;
@property (nonatomic, strong) UIButton *forget_sureButton;

@end

@implementation DDQForgetView

- (void)view_subviewsConfig {
    
    [super view_subviewsConfig];
    
    self.forget_headerView = [[DDQUserOperationHeaderView alloc] initHeaderViewWithStyle:DDQUserOperationHeaderViewStyleForget];
    
    self.forget_phoneView = [[DDQUserOperationInputView alloc] initInputViewWithStyle:DDQUserOperationInputViewStylePhone placeholder:@"手机号"];
    
    self.forget_messageView = [[DDQUserOperationInputView alloc] initInputViewWithStyle:DDQUserOperationInputViewStyleMessageCode placeholder:@"验证码"];
    self.forget_messageView.delegate = self;

    self.forget_passwordView = [[DDQUserOperationInputView alloc] initInputViewWithStyle:DDQUserOperationInputViewStylePassword placeholder:@"新密码"];

    self.forget_surePasswordView = [[DDQUserOperationInputView alloc] initInputViewWithStyle:DDQUserOperationInputViewStylePassword placeholder:@"确认密码"];

    self.forget_sureButton = [UIButton buttonChangeFont:DDQFont(14.0) titleColor:[UIColor whiteColor] image:nil backgroundImage:nil title:@"确认" attributeTitle:nil target:self sel:@selector(forget_didSelectSure)];
    self.forget_sureButton.backgroundColor = self.defaultBlueColor;
    self.forget_sureButton.layer.cornerRadius = 3.0;
    
    [self view_configSubviews:@[self.forget_headerView, self.forget_phoneView, self.forget_messageView, self.forget_passwordView, self.forget_surePasswordView, self.forget_sureButton]];
    
}

- (void)view_updateContentSubviewsFrame {
    
    [super view_updateContentSubviewsFrame];

    autoLayout(self.forget_headerView).ddq_leading(self.leading, 20.0 * self.view_widthRate).ddq_top(self.top, 25.0 * self.view_widthRate).ddq_fitSize();
    
    autoLayout(self.forget_phoneView).ddq_leading(self.forget_headerView.leading, 0.0).ddq_top(self.forget_headerView.bottom, 44.0 * self.view_widthRate).ddq_size(CGSizeMake(self.width - self.forget_phoneView.x * 2.0, self.forget_phoneView.input_estimateHeight));
    
    CGFloat controlVerSpace = 10.0 * self.view_widthRate;
    autoLayout(self.forget_messageView).ddq_leading(self.forget_phoneView.leading, 0.0).ddq_top(self.forget_phoneView.bottom, controlVerSpace).ddq_size(CGSizeMake(self.forget_phoneView.width, self.forget_phoneView.input_estimateHeight));
    
    autoLayout(self.forget_passwordView).ddq_leading(self.forget_messageView.leading, 0.0).ddq_top(self.forget_messageView.bottom, controlVerSpace).ddq_size(CGSizeMake(self.forget_messageView.width, self.forget_passwordView.input_estimateHeight));
    
    autoLayout(self.forget_surePasswordView).ddq_leading(self.forget_passwordView.leading, 0.0).ddq_top(self.forget_passwordView.bottom, controlVerSpace).ddq_size(CGSizeMake(self.forget_passwordView.width, self.forget_surePasswordView.input_estimateHeight));
    
    autoLayout(self.forget_sureButton).ddq_top(self.forget_surePasswordView.bottom, 45.0 * self.view_widthRate).ddq_leading(self.forget_surePasswordView.leading, 0.0).ddq_size(CGSizeMake(self.forget_surePasswordView.width, 45.0 * self.view_widthRate));
    
}

/**
 点击“确认”按钮
 */
- (void)forget_didSelectSure {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(forget_didSelectSureWithModel:)]) {
        
        DDQUserOperationModel *model = [DDQUserOperationModel mj_objectWithKeyValues:@{}];
        model.forget_phone = self.forget_phoneView.input_field.text;
        model.forget_messageCode = self.forget_messageView.input_field.text;
        model.forget_password = self.forget_passwordView.input_field.text;
        model.forget_surePassword = self.forget_surePasswordView.input_field.text;
        [self.delegate forget_didSelectSureWithModel:model];
        
    }
}

#pragma mark - Custom Delegate
- (void)input_didSelectSendMessageCode:(DDQInputViewSendMessageCodeBlock)block {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(forget_didSelectSendMessageCode:phone:)]) {
        
        [self.delegate forget_didSelectSendMessageCode:^(BOOL send) {
            
            block(send);
            
        } phone:self.forget_phoneView.input_field.text];
    }
}

@end
