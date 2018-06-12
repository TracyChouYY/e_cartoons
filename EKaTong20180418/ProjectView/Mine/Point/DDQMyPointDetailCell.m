//
//  DDQMyPointDetailCell.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/26.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQMyPointDetailCell.h"

@interface DDQMyPointDetailCell ()

@property (nonatomic, strong) UILabel *detail_titleLabel;
@property (nonatomic, strong) UILabel *detail_timeLabel;
@property (nonatomic, strong) UILabel *detail_pointLabel;

@end

@implementation DDQMyPointDetailCell

- (void)cell_contentViewSubviewsConfig {
    
    [super cell_contentViewSubviewsConfig];
    
    self.detail_titleLabel = [UILabel labelChangeText:@"222fasdfawethbegtryhvascerfcwtgxwervtgcd2222" font:DDQFont(14.0) textColor:self.defaultBlackColor];
    
    self.detail_timeLabel = [UILabel labelChangeText:@"222tvactxeawctbvceyvtjnghtgsrzjhxdtjtdrjur2222" font:DDQFont(10.0) textColor:self.defaultGrayColor];
    
    self.detail_pointLabel = [UILabel labelChangeText:@"+1asdgasgasbyuvtiylu,kmbjvhcvsdbsjuyjkyuy0" font:DDQFont(16.0) textColor:self.defaultOrangeColor];
    
    [self.contentView view_configSubviews:@[self.detail_titleLabel, self.detail_timeLabel, self.detail_pointLabel]];
    
}

- (void)cell_updateContentSubviewsFrame {
    
    DDQViewVHMargin margin = DDQViewVHMarginMaker(12.0 * self.cell_widthRate, 15.0 * self.cell_widthRate);
    CGSize pointSize = [self.detail_pointLabel label_boundWithMaxSize:CGSizeMake(self.contentView.width * 0.5 - margin.horMargin - 5.0, 15.0) options:NSStringDrawingUsesFontLeading];

    autoLayout(self.detail_titleLabel).ddq_leading(self.contentView.leading, margin.horMargin).ddq_top(self.contentView.top, margin.verMargin).ddq_estimateSize(CGSizeMake(self.contentView.width - pointSize.width - 5.0 * 2.0 - margin.horMargin, 30.0));
    
    autoLayout(self.detail_pointLabel).ddq_trailing(self.contentView.trailing, margin.horMargin).ddq_top(self.detail_titleLabel.centerY, 0.0).ddq_size(pointSize);
    
    autoLayout(self.detail_timeLabel).ddq_leading(self.detail_titleLabel.leading, 0.0).ddq_top(self.detail_pointLabel.bottom, 6.0 * self.cell_widthRate).ddq_estimateSize(CGSizeMake(self.contentView.width - self.detail_titleLabel.x * 2.0, 20.0));
    
    [super cell_updateContentSubviewsFrame];

}

- (UIView *)cell_layoutBottomControl {
    
    return self.detail_timeLabel;
    
}

- (CGFloat)cell_bottomMargin {
    
    return self.detail_titleLabel.y;
    
}

@end
