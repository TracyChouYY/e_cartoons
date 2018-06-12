//
//  DDQWalletSecondSectionCell.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/26.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQWalletSecondSectionCell.h"

@interface DDQWalletSecondSectionCell () <DDQWalletPackageViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UILabel *wallet_titleLabel;
@property (nonatomic, strong) DDQWalletPackageView *wallet_sliverView;
@property (nonatomic, strong) DDQWalletPackageView *wallet_goldView;
@property (nonatomic, strong) DDQWalletPackageView *wallet_daimondView;
@property (nonatomic, strong) UIView *wallet_otherView;
@property (nonatomic, strong) UITextField *wallet_inputField;
@property (nonatomic, strong) UILabel *wallet_priceLabel;
@property (nonatomic, strong) DDQButton *wallet_memberButton;
@property (nonatomic, strong) UILabel *wallet_payLabel;

@property (nonatomic, strong) DDQWalletPackageView *wallet_tempView;

@end

@implementation DDQWalletSecondSectionCell

- (void)cell_contentViewSubviewsConfig {
    
    [super cell_contentViewSubviewsConfig];
    
    self.wallet_titleLabel = [UILabel labelChangeText:@"储值套餐" font:DDQFont(16.0) textColor:self.defaultBlackColor];
    
    self.wallet_sliverView = [[DDQWalletPackageView alloc] initPackageViewWithStyle:DDQWalletPackageViewStyleSilver];
    [self.wallet_sliverView view_hanlderLayerWithRadius:3.0 borderWidth:1.0 borderColor:kSetColor(238.0, 238.0, 238.0, 1.0)];
    self.wallet_sliverView.delegate = self;
    
    self.wallet_goldView = [[DDQWalletPackageView alloc] initPackageViewWithStyle:DDQWalletPackageViewStyleGold];
    [self.wallet_goldView view_hanlderLayerWithRadius:3.0 borderWidth:1.0 borderColor:kSetColor(238.0, 238.0, 238.0, 1.0)];
    self.wallet_goldView.delegate = self;

    self.wallet_daimondView = [[DDQWalletPackageView alloc] initPackageViewWithStyle:DDQWalletPackageViewStyleDiamond];
    [self.wallet_daimondView view_hanlderLayerWithRadius:3.0 borderWidth:1.0 borderColor:kSetColor(238.0, 238.0, 238.0, 1.0)];
    self.wallet_daimondView.delegate = self;

    self.wallet_otherView = [UIView viewChangeBackgroundColor:[UIColor whiteColor]];
    [self.wallet_otherView view_hanlderLayerWithRadius:3.0 borderWidth:1.0 borderColor:kSetColor(238.0, 238.0, 238.0, 1.0)];

    NSAttributedString *placeholder = [[NSAttributedString alloc] initWithString:@"输入可充值余额" attributes:@{NSFontAttributeName:DDQFont(16.0), NSForegroundColorAttributeName:self.defaultBlackColor}];
    self.wallet_inputField = [UITextField fieldChangeFont:DDQFont(16.0) textColor:self.defaultBlackColor placeholder:nil attributePlaceholder:placeholder];
    self.wallet_inputField.delegate = self;
    self.wallet_inputField.keyboardType = UIKeyboardTypeNumberPad;
    self.wallet_inputField.clearButtonMode = UITextFieldViewModeNever;
    
    self.wallet_priceLabel = [UILabel labelChangeText:@"￥ 0" font:DDQFont(16.0) textColor:self.defaultBlackColor];
    
    self.wallet_memberButton = [DDQButton ddq_customButtonWithStyle:DDQButtonStyleRightImageView fontSize:14.0 title:@"会员说明" image:kSetImage(@"wallet_detail") titleColor:kSetColor(150.0, 150.0, 150.0, 1.0) target:self selector:@selector(wallet_didSelectMemberDescr)];
    self.wallet_memberButton.control_space = 5.0;
    
    self.wallet_payLabel = [UILabel labelChangeText:@"需支付：0元" font:DDQFont(16.0) textColor:self.defaultBlackColor];
    
    [self.contentView view_configSubviews:@[self.wallet_titleLabel, self.wallet_sliverView, self.wallet_goldView, self.wallet_daimondView, self.wallet_otherView, self.wallet_memberButton, self.wallet_payLabel]];
    [self.wallet_otherView view_configSubviews:@[self.wallet_inputField, self.wallet_priceLabel]];
    
}

- (void)cell_updateContentSubviewsFrame {
    
    autoLayout(self.wallet_titleLabel).ddq_leading(self.contentView.leading, self.cell_defaultLeftMargin).ddq_top(self.contentView.top, 25.0 * self.cell_widthRate).ddq_fitSize();
    
    autoLayout(self.wallet_sliverView).ddq_leading(self.wallet_titleLabel.leading, 0.0).ddq_top(self.wallet_titleLabel.bottom, 15.0 * self.cell_widthRate).ddq_size(CGSizeMake(self.contentView.width - self.wallet_sliverView.x * 2.0, 60.0 * self.cell_widthRate));
    
    CGFloat controlSpce = 10.0 * self.cell_widthRate;
    autoLayout(self.wallet_goldView).ddq_leading(self.wallet_sliverView.leading, 0.0).ddq_top(self.wallet_sliverView.bottom, controlSpce).ddq_size(self.wallet_sliverView.size);

    autoLayout(self.wallet_daimondView).ddq_leading(self.wallet_goldView.leading, 0.0).ddq_top(self.wallet_goldView.bottom, controlSpce).ddq_size(self.wallet_goldView.size);
    
    autoLayout(self.wallet_otherView).ddq_leading(self.wallet_daimondView.leading, 0.0).ddq_top(self.wallet_daimondView.bottom, controlSpce).ddq_size(self.wallet_daimondView.size);
    
    autoLayout(self.wallet_memberButton).ddq_trailing(self.wallet_otherView.trailing, 0.0).ddq_top(self.wallet_otherView.bottom, 25.0 * self.cell_widthRate).ddq_fitSize();
    
    autoLayout(self.wallet_payLabel).ddq_leading(self.wallet_otherView.leading, 0.0).ddq_top(self.wallet_memberButton.bottom, 20.0 * self.cell_widthRate).ddq_fitSize();
    
    //ContentSubview
    autoLayout(self.wallet_inputField).ddq_leading(self.wallet_otherView.leading, 10.0 * self.cell_widthRate).ddq_centerY(self.wallet_otherView.centerY, 0.0).ddq_size(CGSizeMake(self.wallet_otherView.width * 0.50, self.wallet_otherView.height));
    
    autoLayout(self.wallet_priceLabel).ddq_trailing(self.wallet_otherView.trailing, 10.0 * self.cell_widthRate).ddq_centerY(self.wallet_otherView.centerY, 0.0).ddq_estimateSize(CGSizeMake(self.wallet_otherView.width - self.wallet_inputField.frameMaxX - 5.0 - 10.0 * self.cell_widthRate, 22.0));

    [super cell_updateContentSubviewsFrame];
    
}

- (UIView *)cell_layoutBottomControl {
    
    return self.wallet_payLabel;
    
}

- (CGFloat)cell_bottomMargin {
    
    return 12.0 * self.cell_widthRate;
    
}

/**
 点击会员说明
 */
- (void)wallet_didSelectMemberDescr {
    
    
}

#pragma mark - TextFiel Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    self.wallet_tempView.view_selected = NO;
    self.wallet_tempView = nil;
    self.wallet_payLabel.text = @"需支付:0元";

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *text = nil;
    if ([string isEqualToString:@""]) {//这表示删除了
        
        text = [textField.text substringToIndex:range.location];
        
    } else {
        
        text = [textField.text stringByAppendingString:string];
        
    }
    
    if (text.length == 0) {
        
        text = @"0";
    
    }
    self.wallet_priceLabel.text = [@"￥" stringByAppendingString:text];
    self.wallet_payLabel.text = [NSString stringWithFormat:@"需要支付：%@元", text];
    
    autoLayout(self.wallet_priceLabel).ddq_trailing(self.wallet_otherView.trailing, 10.0 * self.cell_widthRate).ddq_centerY(self.wallet_otherView.centerY, 0.0).ddq_estimateSize(CGSizeMake(self.wallet_otherView.width - self.wallet_inputField.frameMaxX - 5.0 - 10.0 * self.cell_widthRate, 22.0));
    autoLayout(self.wallet_payLabel).ddq_leading(self.wallet_otherView.leading, 0.0).ddq_top(self.wallet_memberButton.bottom, 20.0 * self.cell_widthRate).ddq_estimateSize(CGSizeMake(self.wallet_otherView.width, 18.0));

    return YES;
    
}

#pragma mark - Custom Delegate
- (void)package_didSelectPackageView:(DDQWalletPackageView *)view {
    
    if (view == self.wallet_tempView) return;
    
    view.view_selected = YES;
    self.wallet_tempView.view_selected = NO;
    self.wallet_tempView = view;
    
    self.wallet_inputField.text = @"";
    self.wallet_priceLabel.text = @"￥0";
    [self.wallet_inputField endEditing:YES];
    self.wallet_payLabel.text = [NSString stringWithFormat:@"需支付:%.0f元", view.price];
    autoLayout(self.wallet_payLabel).ddq_leading(self.wallet_otherView.leading, 0.0).ddq_top(self.wallet_memberButton.bottom, 20.0 * self.cell_widthRate).ddq_estimateSize(CGSizeMake(self.wallet_otherView.width, 18.0));

}

@end

@interface DDQWalletPackageView ()

@property (nonatomic, assign) DDQWalletPackageViewStyle package_style;
@property (nonatomic, strong) UILabel *package_titleLabel;
@property (nonatomic, strong) UILabel *package_priceLabel;

@end

@implementation DDQWalletPackageView

- (instancetype)initPackageViewWithStyle:(DDQWalletPackageViewStyle)style {
    
    self.package_style = style;
    
    self = [super initViewWithFrame:CGRectZero];
    
    return self;
    
}

- (instancetype)initViewWithFrame:(CGRect)frame {
    
    return [self initPackageViewWithStyle:DDQWalletPackageViewStyleSilver];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(package_didSelectPackageView:)]) {
        
        [self.delegate package_didSelectPackageView:self];
        
    }
}

- (void)view_subviewsConfig {
    
    [super view_subviewsConfig];
    
    NSString *string = nil;
    NSString *price = @"";
    if (self.package_style == DDQWalletPackageViewStyleSilver) {
        
        string = @"充值100元升级为银牌会员";
        price = @"100";
        
    } else if (self.package_style == DDQWalletPackageViewStyleGold) {
        
        string = @"充值300元升级为金牌会员";
        price = @"300";

    } else {
        
        string = @"充值500元升级为钻石会员";
        price = @"500";

    }
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:DDQFont(14.0), NSForegroundColorAttributeName:self.defaultBlackColor}];
    NSRange range = [attribute.string rangeOfString:@"充值"];
    [attribute addAttribute:NSForegroundColorAttributeName value:self.defaultOrangeColor range:NSMakeRange(range.length + range.location, price.length)];
    
    self.package_titleLabel = [UILabel labelChangeText:@"" font:DDQFont(14.0) textColor:self.defaultBlackColor];
    self.package_titleLabel.attributedText = attribute;
    
    NSMutableAttributedString *priceAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥ %@", price] attributes:@{NSFontAttributeName:DDQFont(20.0), NSForegroundColorAttributeName:self.defaultOrangeColor}];
    [priceAttr addAttribute:NSFontAttributeName value:DDQFont(14.0) range:[priceAttr.string rangeOfString:@"￥"]];
    
    self.package_priceLabel = [UILabel labelChangeText:@"" font:DDQFont(20.0) textColor:self.defaultOrangeColor];
    self.package_priceLabel.attributedText = priceAttr;
    
    [self view_configSubviews:@[self.package_titleLabel, self.package_priceLabel]];
    
}

- (void)view_updateContentSubviewsFrame {
    
    [super view_updateContentSubviewsFrame];
    
    autoLayout(self.package_titleLabel).ddq_leading(self.leading, 10.0 * self.view_widthRate).ddq_centerY(self.centerY, 0.0).ddq_fitSize();
    
    autoLayout(self.package_priceLabel).ddq_trailing(self.trailing, 10.0 * self.view_widthRate).ddq_centerY(self.package_titleLabel.centerY, 0.0).ddq_fitSize();
    
}

- (void)setView_selected:(BOOL)view_selected {
    
    _view_selected = view_selected;
    
    UIColor *backgroundColor = nil;
    CGFloat borderWidth = 0.0;
    if (_view_selected) {
        
        backgroundColor = kSetColor(251.0, 238.0, 201.0, 1.0);
        
    } else {
        
        backgroundColor = [UIColor whiteColor];
        borderWidth = 1.0;
        
    }
    self.backgroundColor = backgroundColor;
    self.layer.borderWidth = borderWidth;
    
}

- (CGFloat)price {
    
    CGFloat price = 0.0;
    if (self.package_style == DDQWalletPackageViewStyleSilver) {
        
        price = 100.0;
        
    } else if (self.package_style == DDQWalletPackageViewStyleGold) {
        
        price = 300.0;
        
    } else {
        
        price = 500.0;
    }
    
    return price;
    
}

@end
