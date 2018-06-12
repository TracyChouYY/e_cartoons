//
//  DDQLoginView.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/18.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQLoginView.h"

#import "DDQUserOperationModel.h"

#import "DDQUserOperationInputView.h"
#import "DDQUserOperationHeaderView.h"
#import "DDQUserOperationThirdLoginView.h"

@interface DDQLoginView () <DDQUserOperationThirdLoginViewDelegate>

@property (nonatomic, strong) DDQUserOperationHeaderView *login_headerView;
@property (nonatomic, strong) DDQUserOperationInputView *login_phoneView;
@property (nonatomic, strong) DDQUserOperationInputView *login_passwordView;
@property (nonatomic, strong) UIButton *login_loginButton;
@property (nonatomic, strong) UIButton *login_forgetButton;
@property (nonatomic, strong) DDQUserOperationThirdLoginView *login_thirdView;
@property (nonatomic, strong) UIButton *login_toRegisterButton;
@property (nonatomic, strong) UIButton *login_otherLoginButton;
@property (nonatomic, strong) DDQButton *login_protocolButton;
@property (nonatomic, assign) DDQLoginViewType login_type;

@end

@implementation DDQLoginView

- (instancetype)initLoginViewWithType:(DDQLoginViewType)type {
    
    self.login_type = type;
    
    self = [super initViewWithFrame:CGRectZero];
        
    return self;
    
}

- (instancetype)initViewWithFrame:(CGRect)frame {
    
    return [self initLoginViewWithType:DDQLoginViewTypePersonal];
    
}

- (void)view_subviewsConfig {
    
    [super view_subviewsConfig];
    
    self.login_headerView = [[DDQUserOperationHeaderView alloc] initHeaderViewWithStyle:DDQUserOperationHeaderViewStyleLogin];
    
    self.login_phoneView = [[DDQUserOperationInputView alloc] initInputViewWithStyle:DDQUserOperationInputViewStylePhone placeholder:@"手机号码"];
    
    self.login_passwordView = [[DDQUserOperationInputView alloc] initInputViewWithStyle:DDQUserOperationInputViewStylePassword placeholder:@"密码"];
    
    self.login_forgetButton = [UIButton buttonChangeFont:DDQFont(13.0) titleColor:kSetColor(136.0, 136.0, 136.0, 1.0) image:nil backgroundImage:nil title:@"忘记密码？" attributeTitle:nil target:self sel:@selector(login_didSelectForgetPassword)];
    
    self.login_loginButton = [UIButton buttonChangeFont:DDQFont(14.0) titleColor:[UIColor whiteColor] image:nil backgroundImage:nil title:@"登录" attributeTitle:nil target:self sel:@selector(login_didSelectLogin)];
    self.login_loginButton.backgroundColor = self.defaultBlueColor;
    self.login_loginButton.layer.cornerRadius = 3.0;
    
    NSMutableAttributedString *registerAttrString = [[NSMutableAttributedString alloc] initWithString:@"还没有账号，去注册" attributes:@{NSFontAttributeName:DDQFont(14.0), NSForegroundColorAttributeName:kSetColor(117.0, 117.0, 117.0, 1.0)}];
    [registerAttrString addAttribute:NSForegroundColorAttributeName value:self.defaultBlueColor range:NSMakeRange(6, registerAttrString.string.length - 6)];
    self.login_toRegisterButton = [UIButton buttonChangeFont:DDQFont(14.0) titleColor:nil image:nil backgroundImage:nil title:nil attributeTitle:registerAttrString target:self sel:@selector(login_didSelectToRegister)];
    
    NSString *title = @"";
    if (self.login_viewType == DDQLoginViewTypeBase) {
        
        title = @" / 管理员登录";
        
    } else if (self.login_type == DDQLoginViewTypePersonal) {
        
        title = @" / 基地登录";
        
    }
    
    NSAttributedString *otherAttr = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:DDQFont(14.0), NSForegroundColorAttributeName:self.defaultBlueColor}];
    self.login_otherLoginButton = [UIButton buttonChangeFont:nil titleColor:self.defaultBlueColor image:nil backgroundImage:nil title:nil attributeTitle:otherAttr target:self sel:@selector(login_didSelectOtherLogin)];
    
    NSMutableArray *subviews = [NSMutableArray arrayWithArray:@[self.login_headerView, self.login_phoneView, self.login_passwordView, self.login_forgetButton, self.login_loginButton, self.login_toRegisterButton, self.login_otherLoginButton]];

    if (self.login_type == DDQLoginViewTypePersonal) {//个人登录页
        
        self.login_thirdView = [[DDQUserOperationThirdLoginView alloc] initViewWithFrame:CGRectZero];
        [subviews addObject:self.login_thirdView];
        self.login_thirdView.delegate = self;
        
    } else if (self.login_viewType == DDQLoginViewTypeManager) {//管理员登录页
        
        [subviews removeObject:self.login_toRegisterButton];
        [subviews removeObject:self.login_forgetButton];
        [subviews removeObject:self.login_otherLoginButton];
        
    } else if (self.login_viewType == DDQLoginViewTypeBase) {//基地登录页
        
        NSMutableAttributedString *protocolAttr = [[NSMutableAttributedString alloc] initWithString:self.view_protocolText attributes:@{NSFontAttributeName:DDQFont(13.0), NSForegroundColorAttributeName:kSetColor(204.0, 204.0, 204.0, 1.0)}];
        [protocolAttr addAttributes:@{NSForegroundColorAttributeName:self.defaultBlueColor} range:NSMakeRange(7, protocolAttr.string.length - 7)];
        self.login_protocolButton = [DDQButton ddq_customButtonWithStyle:DDQButtonStyleLeftImageView fontSize:13.0 title:self.view_protocolText image:kSetImage(@"disagree") titleColor:nil target:self selector:@selector(login_didSelectProtocolWithButton:)];
        self.login_protocolButton.control_space = 5.0;
        //这里有点问题，就是我必须先设置button的text，因为只有这样buttonTitleLabel才能计算正确的宽度
        [self.login_protocolButton setAttributedTitle:protocolAttr forState:UIControlStateNormal];
        [self login_didSelectProtocolWithButton:self.login_protocolButton];
        
        [subviews addObject:self.login_protocolButton];
        
    }
    
    [self view_configSubviews:subviews.copy];
    
}

- (void)view_updateContentSubviewsFrame {
    
    [super view_updateContentSubviewsFrame];

    DDQViewVHMargin margin = DDQViewVHMarginMaker(15.0 * self.view_widthRate, 20.0 * self.view_widthRate);
    autoLayout(self.login_headerView).ddq_leading(self.leading, margin.horMargin).ddq_top(self.top, margin.verMargin).ddq_fitSize();
    
    autoLayout(self.login_phoneView).ddq_leading(self.login_headerView.leading, 0.0).ddq_top(self.login_headerView.bottom, 20.0 * self.view_widthRate).ddq_size(CGSizeMake(self.width - self.login_headerView.x * 2.0, self.login_phoneView.input_estimateHeight));
    
    autoLayout(self.login_passwordView).ddq_leading(self.login_phoneView.leading, 0.0).ddq_top(self.login_phoneView.bottom, 8.0).ddq_size(CGSizeMake(self.login_phoneView.frameMaxX - self.login_passwordView.x, self.login_passwordView.input_estimateHeight));
    
    autoLayout(self.login_loginButton).ddq_leading(self.login_passwordView.leading, 0.0).ddq_top(self.login_passwordView.bottom, 50.0 * self.view_widthRate).ddq_size(CGSizeMake(self.login_passwordView.width, 45.0 * self.view_widthRate));
    
    if (self.login_viewType != DDQLoginViewTypeManager) {//当前是管理员登录界面就不用显示去注册和忘记密码
        
        [self.login_otherLoginButton sizeToFit];
        autoLayout(self.login_toRegisterButton).ddq_centerX(self.centerX, -self.login_otherLoginButton.width * 0.5).ddq_top(self.login_loginButton.bottom, 50.0 * self.view_widthRate).ddq_fitSize();
        autoLayout(self.login_otherLoginButton).ddq_leading(self.login_toRegisterButton.trailing, 0.0).ddq_centerY(self.login_toRegisterButton.centerY, 0.0).ddq_fitSize();
        autoLayout(self.login_forgetButton).ddq_trailing(self.login_passwordView.trailing, 0.0).ddq_top(self.login_passwordView.bottom, 15.0 * self.view_widthRate).ddq_fitSize();
        
    }
    
    if (self.login_type == DDQLoginViewTypePersonal) {//只有个人登录时，才会有第三方登录功能
        
        autoLayout(self.login_thirdView).ddq_centerX(self.centerX, 5.0).ddq_bottom(self.bottom, 20.0 * self.view_widthRate).ddq_fitSize();

    } else if (self.login_viewType == DDQLoginViewTypeBase) {//基地登录还需要显示使用协议
        
        autoLayout(self.login_protocolButton).ddq_centerX(self.centerX, 0.0).ddq_bottom(self.bottom, 20.0 * self.view_widthRate).ddq_fitSize();
        
    }
}

/**
 点击“忘记密码”
 */
- (void)login_didSelectForgetPassword {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(login_didSelectForgetPassword)]) {
        
        [self.delegate login_didSelectForgetPassword];
        
    }
}

/**
 点击“登录”
 */
- (void)login_didSelectLogin {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(login_didSelectLoginWithModel:)]) {
        
        DDQUserOperationModel *model = [DDQUserOperationModel mj_objectWithKeyValues:@{}];
        model.login_phone = self.login_phoneView.input_field.text;
        model.login_password = self.login_passwordView.input_field.text;
        model.login_respectProtocol = (self.login_type == DDQLoginViewTypeBase) ? self.login_protocolButton.isSelected : self.login_thirdView.login_respectProtocol;
        [self.delegate login_didSelectLoginWithModel:model];
        
    }
}

/**
 点击“使用协议”
 */
- (void)login_didSelectProtocolWithButton:(UIButton *)button {
    
    if (!button.isSelected) {
        
        [button setImage:kSetImage(@"agree") forState:UIControlStateNormal];
        [button setSelected:YES];
        
    } else {
        
        [button setImage:kSetImage(@"disagree") forState:UIControlStateNormal];
        [button setSelected:NO];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(login_base_didSelectUserProtocol)]) {
            
            [self.delegate login_base_didSelectUserProtocol];
            
        }
    }
}

/**
 点击页面上的其他登录按钮
 */
- (void)login_didSelectOtherLogin {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(login_didSelectDifferentViewType:loginView:)]) {
        
        [self.delegate login_didSelectDifferentViewType:self.login_viewType loginView:self];
        
    }
}

/**
 点击去注册
 */
- (void)login_didSelectToRegister {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(login_didSelectToRegister)]) {
        
        [self.delegate login_didSelectToRegister];
        
    }
}

- (DDQLoginViewType)login_viewType {
    
    return self.login_type;
    
}

- (void)setLogin_installWX:(BOOL)login_installWX {
    
    _login_installWX = login_installWX;
    
    self.login_thirdView.login_installWechat = _login_installWX;
    
}

#pragma mark - Custom Method
- (void)third_didSelectUserProtocol {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(login_didSelectUserProtocol)]) {
        
        [self.delegate login_didSelectUserProtocol];
        
    }
}

- (void)third_didSelectThirdLoginWithType:(DDQUserOperationThirdLoginType)type {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(login_didSelectDifferentThirdLoginType:)]) {
        
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
        
        [self.delegate login_didSelectDifferentThirdLoginType:thirdType];
    }
}

@end
