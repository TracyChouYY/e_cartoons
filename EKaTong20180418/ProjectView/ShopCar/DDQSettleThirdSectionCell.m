//
//  DDQSettleThirdSectionCell.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/2.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQSettleThirdSectionCell.h"

@interface DDQSettleThirdSectionCell ()

@property (nonatomic, strong) UILabel *third_titleLabel;
@property (nonatomic, strong) DDQButton *third_infoButton;

@end

@implementation DDQSettleThirdSectionCell

- (void)cell_contentViewSubviewsConfig {
    
    [super cell_contentViewSubviewsConfig];
    
    self.third_titleLabel = [UILabel labelChangeText:@"优惠券" font:DDQFont(14.0) textColor:self.defaultBlackColor];
    
    self.third_infoButton = [DDQButton ddq_customButtonWithStyle:DDQButtonStyleRightImageView fontSize:14.0 title:@" " image:kSetImage(@"mine_more") titleColor:self.defaultGrayColor target:self selector:@selector(third_didSelectInfo)];
    self.third_infoButton.control_space = 10.0;
    
    [self.contentView view_configSubviews:@[self.third_titleLabel, self.third_infoButton]];
    
}

- (void)cell_updateContentSubviewsFrame {
    
    autoLayout(self.third_titleLabel).ddq_leading(self.contentView.leading, self.cell_defaultLeftMargin).ddq_top(self.contentView.top, 20.0 * self.cell_widthRate).ddq_fitSize();
    
    autoLayout(self.third_infoButton).ddq_trailing(self.contentView.trailing, self.cell_defaultLeftMargin).ddq_centerY(self.third_titleLabel.centerY, 0.0).ddq_fitSize();
    
    [super cell_updateContentSubviewsFrame];
    
}

- (UIView *)cell_layoutBottomControl {
    
    return self.third_titleLabel;
    
}

- (CGFloat)cell_bottomMargin {
    
    return self.third_titleLabel.y;
    
}

/**
 点击优惠券
 */
- (void)third_didSelectInfo {
    
    
}

@end
