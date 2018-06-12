//
//  DDQOrderDetailSecondSectionCell.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/1.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQOrderDetailSecondSectionCell.h"

@interface DDQOrderDetailSecondSectionCell ()

@property (nonatomic, strong) UIImageView *second_imageView;
@property (nonatomic, strong) UILabel *second_titleLabel;
@property (nonatomic, strong) UILabel *second_timeLabel;
@property (nonatomic, strong) UILabel *second_priceLabel;

@end

@implementation DDQOrderDetailSecondSectionCell

- (void)cell_contentViewSubviewsConfig {
    
    [super cell_contentViewSubviewsConfig];
    
    self.second_imageView = [UIImageView imageView];
    
    self.second_titleLabel = [UILabel labelChangeText:@"fasdfidshfshfdashffdfkguuiguguguindfcdf" font:DDQFont(16.0) textColor:kSetColor(20.0, 26.0, 36.0, 1.0)];
    self.second_titleLabel.textAlignment = NSTextAlignmentLeft;
    
    self.second_timeLabel = [UILabel labelChangeText:@"fjacmfasdifmcaidncifdsnm" font:DDQFont(13.0) textColor:self.defaultGrayColor];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"￥100000/人" attributes:@{NSFontAttributeName:DDQFont(16.0), NSForegroundColorAttributeName:self.defaultOrangeColor}];
    NSRange range1 = [attributeString.string rangeOfString:@"￥"];
    NSRange range2 = [attributeString.string rangeOfString:@"/人"];
    [attributeString addAttribute:NSFontAttributeName value:DDQFont(12.0) range:range1];
    [attributeString addAttribute:NSFontAttributeName value:DDQFont(12.0) range:range2];
    self.second_priceLabel = [UILabel labelChangeText:@"" font:DDQFont(16.0) textColor:self.defaultOrangeColor];
    self.second_priceLabel.attributedText = attributeString.copy;
    
    [self.contentView view_configSubviews:@[self.second_imageView, self.second_titleLabel, self.second_timeLabel, self.second_priceLabel]];
 
    self.contentView.backgroundColor = [UIColor whiteColor];

}

- (void)cell_updateContentSubviewsFrame {
    
    autoLayout(self.second_imageView).ddq_leading(self.contentView.leading, self.cell_defaultLeftMargin).ddq_top(self.contentView.top, self.cell_defaultLeftMargin).ddq_size(CGSizeMake(115.0 * self.cell_widthRate, 80.0 * self.cell_widthRate));
    
    CGSize maxSize = CGSizeMake(self.contentView.width - self.second_titleLabel.x - self.second_imageView.x, 36.0);
    autoLayout(self.second_titleLabel).ddq_leading(self.second_imageView.trailing, 10.0 * self.cell_widthRate).ddq_top(self.second_imageView.top, 5.0).ddq_estimateSize(maxSize);
    
    autoLayout(self.second_timeLabel).ddq_leading(self.second_titleLabel.leading, 0.0).ddq_top(self.second_titleLabel.bottom, 10.0 * self.cell_widthRate).ddq_estimateSize(CGSizeMake(maxSize.width, 15.0));
    
    autoLayout(self.second_priceLabel).ddq_leading(self.second_titleLabel.leading, 0.0).ddq_top(self.second_timeLabel.bottom, 10.0 * self.cell_widthRate).ddq_estimateSize(CGSizeMake(maxSize.width, 18.0));
    
    [super cell_updateContentSubviewsFrame];
    
}

- (UIView *)cell_layoutBottomControl {

    return (self.second_priceLabel.frameMaxY >= self.second_imageView.frameMaxY) ? self.second_priceLabel : self.second_imageView;

}

- (CGFloat)cell_bottomMargin {

    return self.second_imageView.y;

}

@end
