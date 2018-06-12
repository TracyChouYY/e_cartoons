//
//  DDQUserOperationThirdLoginView.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/18.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQUserOperationThirdLoginView.h"

@interface DDQUserOperationThirdLoginView ()

@property (nonatomic, strong) UILabel *login_titleLabel;
@property (nonatomic, strong) UIButton *login_wxButton;
@property (nonatomic, strong) UIButton *login_qqButton;
@property (nonatomic, strong) UIButton *login_alButton;
@property (nonatomic, strong) DDQButton *login_protocolButton;

@end

@implementation DDQUserOperationThirdLoginView

- (void)sizeToFit {
    
    [super sizeToFit];
    
    CGRect frame = self.frame;
    CGFloat maxW = (self.login_alButton.frameMaxX > self.login_protocolButton.width) ? self.login_alButton.frameMaxX : self.login_protocolButton.width;
    frame.size = CGSizeMake(maxW, self.login_protocolButton.frameMaxY);
    self.frame = frame;
    
}

- (void)view_subviewsConfig {
    
    [super view_subviewsConfig];
    
    NSMutableAttributedString *protocolAttr = [[NSMutableAttributedString alloc] initWithString:self.view_protocolText attributes:@{NSFontAttributeName:DDQFont(13.0), NSForegroundColorAttributeName:kSetColor(204.0, 204.0, 204.0, 1.0)}];
    [protocolAttr addAttributes:@{NSForegroundColorAttributeName:self.defaultBlueColor} range:NSMakeRange(7, protocolAttr.string.length - 7)];
    self.login_protocolButton = [DDQButton ddq_customButtonWithStyle:DDQButtonStyleLeftImageView fontSize:13.0 title:self.view_protocolText image:kSetImage(@"disagree") titleColor:nil target:self selector:@selector(login_didSelectProtocolWithButton:)];
    self.login_protocolButton.control_space = 5.0;
    [self.login_protocolButton setAttributedTitle:protocolAttr forState:UIControlStateNormal];
    [self login_didSelectProtocolWithButton:self.login_protocolButton];

    self.login_titleLabel = [UILabel labelChangeText:@"第三方快速登录" font:DDQFont(14.0) textColor:self.defaultBlueColor];
    
    self.login_wxButton = [UIButton buttonChangeFont:nil titleColor:nil image:nil backgroundImage:kSetImage(@"login_wx") title:nil attributeTitle:nil target:self sel:@selector(login_didSelectThirdLoginWithButton:)];
    self.login_wxButton.tag = 1;
    
    self.login_qqButton = [UIButton buttonChangeFont:nil titleColor:nil image:nil backgroundImage:kSetImage(@"login_qq") title:nil attributeTitle:nil target:self sel:@selector(login_didSelectThirdLoginWithButton:)];
    self.login_qqButton.tag = 2;

    self.login_alButton = [UIButton buttonChangeFont:nil titleColor:nil image:nil backgroundImage:kSetImage(@"login_al") title:nil attributeTitle:nil target:self sel:@selector(login_didSelectThirdLoginWithButton:)];
    self.login_alButton.tag = 3;

    [self view_configSubviews:@[self.login_titleLabel, self.login_wxButton, self.login_qqButton, self.login_alButton, self.login_protocolButton]];
    
    self.login_installWechat = NO;

}

- (void)view_updateContentSubviewsFrame {
    
    [super view_updateContentSubviewsFrame];

    autoLayout(self.login_titleLabel).ddq_leading(self.leading, 0.0).ddq_top(self.top, 0.0).ddq_fitSize();
    
    if (self.login_installWechat) {
        
        autoLayout(self.login_wxButton).ddq_leading(self.login_titleLabel.trailing, 60.0 * self.view_widthRate).ddq_centerY(self.login_titleLabel.centerY, 0.0).ddq_fitSize();
        
        autoLayout(self.login_qqButton).ddq_centerY(self.login_wxButton.centerY, 0.0).ddq_leading(self.login_wxButton.trailing, 50.0 * self.view_widthRate).ddq_fitSize();
        
        autoLayout(self.login_alButton).ddq_leading(self.login_qqButton.trailing, 50.0 * self.view_widthRate).ddq_centerY(self.login_qqButton.centerY, 0.0).ddq_fitSize();

    } else {
        
        autoLayout(self.login_qqButton).ddq_centerY(self.login_titleLabel.centerY, 0.0).ddq_leading(self.login_titleLabel.trailing, 60.0 * self.view_widthRate).ddq_fitSize();
        
        autoLayout(self.login_alButton).ddq_leading(self.login_qqButton.trailing, 50.0 * self.view_widthRate).ddq_centerY(self.login_qqButton.centerY, 0.0).ddq_fitSize();

    }
    
    autoLayout(self.login_protocolButton).ddq_centerX(self.centerX, 0.0).ddq_top(self.login_alButton.bottom, 20.0 * self.view_widthRate).ddq_fitSize();
    
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
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(third_didSelectUserProtocol)]) {
            
            [self.delegate third_didSelectUserProtocol];
            
        }
    }
}

/**
 点击QQ，WX，AL登录
 */
- (void)login_didSelectThirdLoginWithButton:(UIButton *)button {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(third_didSelectThirdLoginWithType:)]) {
        
        DDQUserOperationThirdLoginType type = DDQUserOperationThirdLoginTypeAL;
        switch (button.tag) {
                
            case 1:
                type = DDQUserOperationThirdLoginTypeWX;
                break;
                
            case 2:
                type = DDQUserOperationThirdLoginTypeQQ;
                break;

            case 3:
                type = DDQUserOperationThirdLoginTypeAL;
                break;

            default:
                break;
        }
        
        [self.delegate third_didSelectThirdLoginWithType:type];
    }
}

- (BOOL)login_respectProtocol {
    
    return self.login_protocolButton.isSelected;
    
}

- (void)setLogin_installWechat:(BOOL)login_installWechat {
    
    _login_installWechat = login_installWechat;
    
    self.login_wxButton.hidden = !_login_installWechat;
    [self view_updateContentSubviewsFrame];
    
}
@end
