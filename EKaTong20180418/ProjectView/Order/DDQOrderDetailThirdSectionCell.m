//
//  DDQOrderDetailThirdSectionCell.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/1.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQOrderDetailThirdSectionCell.h"

@interface DDQOrderDetailThirdSectionCell ()

@property (nonatomic, strong) UILabel *third_wayLabel;
@property (nonatomic, strong) UILabel *third_countLabel;
@property (nonatomic, strong) UILabel *third_priceLabel;

@end

@implementation DDQOrderDetailThirdSectionCell

- (void)cell_contentViewSubviewsConfig {
    
    [super cell_contentViewSubviewsConfig];
    
    self.third_wayLabel = [UILabel labelChangeText:@"支付方式：支付宝" font:DDQFont(13.0) textColor:kSetColor(102.0, 102.0, 102.0, 1.0)];
    
    self.third_countLabel = [UILabel labelChangeText:@"数量：2" font:DDQFont(13.0) textColor:self.third_wayLabel.textColor];
    
    self.third_priceLabel = [UILabel labelChangeText:@"费用总计：￥2000000" font:DDQFont(13.0) textColor:self.third_wayLabel.textColor];
    
    [self.contentView view_configSubviews:@[self.third_wayLabel, self.third_countLabel, self.third_priceLabel]];
 
    self.contentView.backgroundColor = [UIColor whiteColor];

}

- (void)cell_updateContentSubviewsFrame {
    
    CGSize maxSize = CGSizeMake(self.contentView.width - self.cell_defaultLeftMargin * 2.0, 15.0);
    autoLayout(self.third_wayLabel).ddq_leading(self.contentView.leading, self.cell_defaultLeftMargin).ddq_top(self.contentView.top, 12.0 * self.cell_widthRate).ddq_estimateSize(maxSize);
    
    autoLayout(self.third_countLabel).ddq_leading(self.third_wayLabel.leading, 0.0).ddq_top(self.third_wayLabel.bottom, 10.0 * self.cell_widthRate).ddq_estimateSize(maxSize);
    
    autoLayout(self.third_priceLabel).ddq_leading(self.third_wayLabel.leading, 0.0).ddq_top(self.third_countLabel.bottom, 10.0 * self.cell_widthRate).ddq_estimateSize(maxSize);
    
    [super cell_updateContentSubviewsFrame];
    
}

- (UIView *)cell_layoutBottomControl {
    
    return self.third_priceLabel;
    
}

- (CGFloat)cell_bottomMargin {
    
    return self.third_wayLabel.y;
    
}

@end
