//
//  DDQRegisterCouponItem.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/26.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQMemberCouponItem.h"

#import "UIView+DDQAdditionalContent.h"

@interface DDQMemberCouponItem ()

@property (nonatomic, strong) UIImageView *coupon_backgroundImageView;
@property (nonatomic, strong) UILabel *coupon_moneyLabel;
@property (nonatomic, strong) UILabel *coupon_descrLabel;

@end

@implementation DDQMemberCouponItem

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    self.coupon_backgroundImageView = [UIImageView imageViewChangeImage:kSetImage(@"member_coupon")];
    
    NSMutableAttributedString *moneyAttr = [[NSMutableAttributedString alloc] initWithString:@"50元" attributes:@{NSFontAttributeName:DDQFont(25.0), NSForegroundColorAttributeName:self.defaultBlackColor}];
    [moneyAttr addAttribute:NSFontAttributeName value:DDQFont(13.0) range:[moneyAttr.string rangeOfString:@"元"]];
    self.coupon_moneyLabel = [UILabel labelChangeText:@"" font:DDQFont(13.0) textColor:kSetColor(51.0, 51.0, 51.0, 1.0)];
    self.coupon_moneyLabel.attributedText = moneyAttr;
    
    self.coupon_descrLabel = [UILabel labelChangeText:@"送50元无门槛券" font:DDQFont(12.0) textColor:kSetColor(62.0, 62.0, 62.0, 1.0)];
    
    [self.contentView view_configSubviews:@[self.coupon_backgroundImageView, self.coupon_moneyLabel, self.coupon_descrLabel]];

    return self;
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    autoLayout(self.coupon_backgroundImageView).ddq_insets(self.contentView, UIEdgeInsetsZero);
    
    DDQRateSet rateSet = [UIView view_getCurrentDeviceRateWithVersion:DDQFoundationRateDevice_iPhone6];
    autoLayout(self.coupon_moneyLabel).ddq_bottom(self.contentView.centerY, 10.0 * rateSet.widthRate).ddq_leading(self.contentView.leading, 10.0 * rateSet.widthRate).ddq_estimateSize(CGSizeMake(self.contentView.width - self.coupon_moneyLabel.x * 2.0, 28.0));
    
    autoLayout(self.coupon_descrLabel).ddq_top(self.contentView.centerY, 10.0 * rateSet.widthRate).ddq_leading(self.coupon_moneyLabel.leading, 0.0).ddq_estimateSize(CGSizeMake(self.contentView.width - self.coupon_descrLabel.x * 2.0, 15.0));
    
}

@end
