//
//  DDQBaseRegisterView.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/20.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBaseRegisterView.h"

#import "DDQUserOperationInputView.h"
#import "DDQUserOperationHeaderView.h"

@interface DDQBaseRegisterView () <DDQRegisterPickerImageViewDelegate, DDQUserOperationInputViewDelegate>

@property (nonatomic, strong) UIScrollView *register_contentScroll;

@property (nonatomic, strong) DDQUserOperationHeaderView *register_headerView;
@property (nonatomic, strong) DDQUserOperationInputView *register_accountView;
@property (nonatomic, strong) DDQUserOperationInputView *register_messageView;
@property (nonatomic, strong) DDQUserOperationInputView *register_passwordView;
@property (nonatomic, strong) DDQUserOperationInputView *register_baseView;
@property (nonatomic, strong) DDQUserOperationInputView *register_companyView;
@property (nonatomic, strong) DDQUserOperationInputView *register_bankNumberView;
@property (nonatomic, strong) DDQUserOperationInputView *register_bankView;
@property (nonatomic, strong) DDQRegisterPickerImageView *register_contractView;
@property (nonatomic, strong) DDQRegisterPickerImageView *register_licenceView;
@property (nonatomic, strong) DDQUserOperationInputView *register_contactView;
@property (nonatomic, strong) DDQUserOperationInputView *register_telephoneView;
@property (nonatomic, strong) DDQUserOperationInputView *register_phoneView;

@property (nonatomic, strong) UIButton *register_registerButton;
@property (nonatomic, strong) DDQButton *register_protocolButton;

@end

@implementation DDQBaseRegisterView

- (void)view_subviewsConfig {
    
    [super view_subviewsConfig];
    
    self.register_contentScroll = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.register_contentScroll];

    self.register_headerView = [[DDQUserOperationHeaderView alloc] initHeaderViewWithStyle:DDQUserOperationHeaderViewStyleRegister];
    
    self.register_accountView = [[DDQUserOperationInputView alloc] initInputViewWithStyle:DDQUserOperationInputViewStylePhone placeholder:@"手机号"];
    
    self.register_messageView = [[DDQUserOperationInputView alloc] initInputViewWithStyle:DDQUserOperationInputViewStyleMessageCode placeholder:@"验证码"];
    self.register_messageView.delegate = self;
    
    self.register_passwordView = [[DDQUserOperationInputView alloc] initInputViewWithStyle:DDQUserOperationInputViewStylePassword placeholder:@"密码"];
    
    self.register_baseView = [[DDQUserOperationInputView alloc] initInputViewWithStyle:DDQUserOperationInputViewStyleNormal placeholder:@"基地名称"];
    
    self.register_companyView = [[DDQUserOperationInputView alloc] initInputViewWithStyle:DDQUserOperationInputViewStyleNormal placeholder:@"单位名称"];
    
    self.register_bankNumberView = [[DDQUserOperationInputView alloc] initInputViewWithStyle:DDQUserOperationInputViewStyleNormal placeholder:@"银行账号"];
    
    self.register_bankView = [[DDQUserOperationInputView alloc] initInputViewWithStyle:DDQUserOperationInputViewStyleNormal placeholder:@"开户行"];
    
    self.register_contractView = [[DDQRegisterPickerImageView alloc] initPickerImageViewWithStyle:DDQRegisterPickerImageViewStyleContract];
    self.register_contractView.delegate = self;
    
    self.register_licenceView = [[DDQRegisterPickerImageView alloc] initPickerImageViewWithStyle:DDQRegisterPickerImageViewStyleLicence];
    self.register_licenceView.delegate = self;

    self.register_contactView = [[DDQUserOperationInputView alloc] initInputViewWithStyle:DDQUserOperationInputViewStyleNormal placeholder:@"联系人"];
    
    self.register_telephoneView = [[DDQUserOperationInputView alloc] initInputViewWithStyle:DDQUserOperationInputViewStyleNormal placeholder:@"电话"];
    
    self.register_phoneView = [[DDQUserOperationInputView alloc] initInputViewWithStyle:DDQUserOperationInputViewStyleNormal placeholder:@"手机"];
    
    self.register_registerButton = [UIButton buttonChangeFont:DDQFont(14.0) titleColor:[UIColor whiteColor] image:nil backgroundImage:nil title:@"注册账号" attributeTitle:nil target:self sel:@selector(register_didSelectRegister)];
    self.register_registerButton.backgroundColor = self.defaultBlueColor;
    self.register_registerButton.layer.cornerRadius = 3.0;
 
    NSMutableAttributedString *protocolAttr = [[NSMutableAttributedString alloc] initWithString:self.view_protocolText attributes:@{NSFontAttributeName:DDQFont(13.0), NSForegroundColorAttributeName:kSetColor(204.0, 204.0, 204.0, 1.0)}];
    [protocolAttr addAttributes:@{NSForegroundColorAttributeName:self.defaultBlueColor} range:NSMakeRange(7, protocolAttr.string.length - 7)];
    self.register_protocolButton = [DDQButton ddq_customButtonWithStyle:DDQButtonStyleLeftImageView fontSize:13.0 title:self.view_protocolText image:kSetImage(@"disagree") titleColor:nil target:self selector:@selector(register_didSelectProtocolWithButton:)];
    self.register_protocolButton.control_space = 5.0;
    [self.register_protocolButton setAttributedTitle:protocolAttr forState:UIControlStateNormal];
    [self register_didSelectProtocolWithButton:self.register_protocolButton];
    
    [self.register_contentScroll view_configSubviews:@[self.register_headerView, self.register_accountView, self.register_messageView, self.register_passwordView, self.register_baseView, self.register_companyView, self.register_bankNumberView, self.register_bankView, self.register_contactView, self.register_telephoneView, self.register_phoneView, self.register_registerButton, self.register_protocolButton, self.register_licenceView, self.register_contractView]];
    
}

- (void)view_updateContentSubviewsFrame {
    
    [super view_updateContentSubviewsFrame];

    self.register_contentScroll.frame = self.bounds;
    autoLayout(self.register_headerView).ddq_leading(self.register_contentScroll.leading, 20.0 * self.view_widthRate).ddq_top(self.register_contentScroll.top, 50.0 * self.view_widthRate).ddq_fitSize();
    
    autoLayout(self.register_accountView).ddq_leading(self.register_headerView.leading, 0.0).ddq_top(self.register_headerView.bottom, 44.0 * self.view_widthRate).ddq_size(CGSizeMake(self.register_contentScroll.width - self.register_headerView.x * 2.0, self.register_accountView.input_estimateHeight));
    
    CGFloat controlSpace = 10.0 * self.view_widthRate;
    autoLayout(self.register_messageView).ddq_leading(self.register_accountView.leading, 0.0).ddq_top(self.register_accountView.bottom, controlSpace).ddq_size(CGSizeMake(self.register_accountView.width, self.register_messageView.input_estimateHeight));

    autoLayout(self.register_passwordView).ddq_leading(self.register_messageView.leading, 0.0).ddq_top(self.register_messageView.bottom, controlSpace).ddq_size(CGSizeMake(self.register_messageView.width, self.register_passwordView.input_estimateHeight));

    autoLayout(self.register_baseView).ddq_leading(self.register_passwordView.leading, 0.0).ddq_top(self.register_passwordView.bottom, controlSpace).ddq_size(CGSizeMake(self.register_passwordView.width, self.register_baseView.input_estimateHeight));

    autoLayout(self.register_companyView).ddq_leading(self.register_baseView.leading, 0.0).ddq_top(self.register_baseView.bottom, controlSpace).ddq_size(CGSizeMake(self.register_baseView.width, self.register_companyView.input_estimateHeight));

    autoLayout(self.register_bankNumberView).ddq_leading(self.register_companyView.leading, 0.0).ddq_top(self.register_companyView.bottom, controlSpace).ddq_size(CGSizeMake(self.register_companyView.width, self.register_bankNumberView.input_estimateHeight));

    autoLayout(self.register_bankView).ddq_leading(self.register_bankNumberView.leading, 0.0).ddq_top(self.register_bankNumberView.bottom, controlSpace).ddq_size(CGSizeMake(self.register_bankNumberView.width, self.register_bankView.input_estimateHeight));
    
    autoLayout(self.register_contractView).ddq_leading(self.register_bankNumberView.leading, 0.0).ddq_top(self.register_bankView.bottom, controlSpace + 5.0).ddq_size(CGSizeMake(self.register_bankView.width, self.register_contractView.picker_estimateHeight));
    
    autoLayout(self.register_licenceView).ddq_leading(self.register_contractView.leading, 0.0).ddq_top(self.register_contractView.bottom, controlSpace + 5.0).ddq_size(CGSizeMake(self.register_contractView.width, self.register_licenceView.picker_estimateHeight));

    autoLayout(self.register_contactView).ddq_leading(self.register_licenceView.leading, 0.0).ddq_top(self.register_licenceView.bottom, controlSpace).ddq_size(CGSizeMake(self.register_licenceView.width, self.register_contactView.input_estimateHeight));

    autoLayout(self.register_telephoneView).ddq_leading(self.register_contactView.leading, 0.0).ddq_top(self.register_contactView.bottom, controlSpace).ddq_size(CGSizeMake(self.register_contactView.width, self.register_telephoneView.input_estimateHeight));

    autoLayout(self.register_phoneView).ddq_leading(self.register_telephoneView.leading, 0.0).ddq_top(self.register_telephoneView.bottom, controlSpace).ddq_size(CGSizeMake(self.register_telephoneView.width, self.register_phoneView.input_estimateHeight));
    
    autoLayout(self.register_registerButton).ddq_centerX(self.register_contentScroll.centerX, 0.0).ddq_top(self.register_phoneView.bottom, 44.0 * self.view_widthRate).ddq_size(CGSizeMake(self.register_phoneView.width, 44.0));
    
    autoLayout(self.register_protocolButton).ddq_centerX(self.register_contentScroll.centerX, 0.0).ddq_top(self.register_registerButton.bottom, 20.0 * self.view_widthRate).ddq_fitSize();

    self.register_contentScroll.contentSize = CGSizeMake(self.width, self.register_protocolButton.frameMaxY + 20.0 * self.view_widthRate);
    
}

/**
 点击“注册账号”
 */
- (void)register_didSelectRegister {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(register_base_didSelectRegisterWithModel:)]) {
        
        DDQUserOperationModel *model = [DDQUserOperationModel mj_objectWithKeyValues:@{}];
        model.register_base_phone = self.register_accountView.input_field.text;
        model.register_base_messageCode = self.register_messageView.input_field.text;
        model.register_base_password = self.register_passwordView.input_field.text;
        model.register_base_name = self.register_baseView.input_field.text;
        model.register_base_company = self.register_companyView.input_field.text;
        model.register_base_bankAccount = self.register_bankNumberView.input_field.text;
        model.register_base_bankName = self.register_bankView.input_field.text;
        model.register_base_contact = self.register_contactView.input_field.text;
        model.register_base_tel = self.register_telephoneView.input_field.text;
        model.register_base_mobile = self.register_phoneView.input_field.text;
        model.register_base_respectProtocol = self.register_protocolButton.selected;
        [self.delegate register_base_didSelectRegisterWithModel:model];
        
    }
}

/**
 点击使用协议
 */
- (void)register_didSelectProtocolWithButton:(UIButton *)button {
    
    if (!button.isSelected) {
        
        [button setImage:kSetImage(@"agree") forState:UIControlStateNormal];
        [button setSelected:YES];
        
    } else {
        
        [button setImage:kSetImage(@"disagree") forState:UIControlStateNormal];
        [button setSelected:NO];
        
    }
}

#pragma mark - Custom Delegate
- (void)picker_didSelectPickerImage:(void (^)(UIImage * _Nonnull))picker view:(DDQRegisterPickerImageView *)view {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(register_base_didSelectPickerImage:type:)]) {
        
        [self.delegate register_base_didSelectPickerImage:^(UIImage * _Nonnull image) {
            
            view.picker_image = image;
            
        } type:(view == self.register_contractView) ? DDQRegister_Base_PickerType_Contract : DDQRegister_Base_PickerType_License];
    }
}

- (void)input_didSelectSendMessageCode:(DDQInputViewSendMessageCodeBlock)block {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(register_base_didSelectSendMessageCode:phone:)]) {
        
        [self.delegate register_base_didSelectSendMessageCode:^(BOOL send) {
            
            block(send);
            
        } phone:self.register_accountView.input_field.text];
    }
}

@end

@interface DDQRegisterPickerImageView ()

@property (nonatomic, strong) UIButton *picker_imageButton;
@property (nonatomic, strong) UILabel *picker_titleLabel;
@property (nonatomic, strong) UIView *picker_line;
@property (nonatomic, assign) DDQRegisterPickerImageViewStyle picker_style;

@end

@implementation DDQRegisterPickerImageView

- (instancetype)initPickerImageViewWithStyle:(DDQRegisterPickerImageViewStyle)style {
    
    self.picker_style = style;
    self = [super initViewWithFrame:CGRectZero];
    
    return self;
    
}

- (instancetype)initViewWithFrame:(CGRect)frame {
    
    return [self initPickerImageViewWithStyle:DDQRegisterPickerImageViewStyleContract];
    
}

- (void)view_subviewsConfig {
    
    [super view_subviewsConfig];
    
    self.picker_imageButton = [UIButton buttonChangeFont:nil titleColor:nil image:kSetImage(@"picker_placeholder") backgroundImage:nil title:nil attributeTitle:nil target:self sel:@selector(picker_didSelectPickerImage)];
    self.picker_imageButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    NSString *title = @"合同协议（上传图片请加盖公章）";
    if (self.picker_style == DDQRegisterPickerImageViewStyleLicence) {
        
        title = @"营业执照(请上传)";
        
    }
    self.picker_titleLabel = [UILabel labelChangeText:title font:DDQFont(15.0) textColor:kSetColor(199.0, 199.0, 205.0, 1.0)];
    
    self.picker_line = [UIView viewChangeBackgroundColor:kSetColor(194.0, 194.0, 194.0, 1.0)];
    
    [self view_configSubviews:@[self.picker_imageButton, self.picker_titleLabel, self.picker_line]];
    
}

- (void)view_updateContentSubviewsFrame {
    
    autoLayout(self.picker_titleLabel).ddq_leading(self.leading, 0.0).ddq_top(self.top, 3.0).ddq_fitSize();
    
    autoLayout(self.picker_imageButton).ddq_leading(self.picker_titleLabel.leading, 0.0).ddq_top(self.picker_titleLabel.bottom, 15.0 * self.view_widthRate).ddq_fitSize();

    autoLayout(self.picker_line).ddq_leading(self.leading, 0.0).ddq_top(self.picker_imageButton.bottom, 15.0 * self.view_widthRate).ddq_size(CGSizeMake(self.width, 1.0));
    
    self.picker_estimateHeight = self.picker_line.frameMaxY;
    
    [super view_updateContentSubviewsFrame];
    
}

/**
 点击选择图片
 */
- (void)picker_didSelectPickerImage {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(picker_didSelectPickerImage:view:)]) {
        
        DDQWeakObject(self);
        [self.delegate picker_didSelectPickerImage:^(UIImage * _Nonnull image) {
            
            weakObjc.picker_image = image;
            
        } view:self];
    }
}

- (void)setPicker_image:(UIImage *)picker_image {
    
    _picker_image = picker_image;
    
    [self.picker_imageButton setImage:_picker_image forState:UIControlStateNormal];

}

@end
