//
//  DDQOrderDetailFirstSectionCell.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/1.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQOrderDetailFirstSectionCell.h"

@interface DDQOrderDetailFirstSectionCell ()

@property (nonatomic, strong) UILabel *first_orderCodeLabel;
@property (nonatomic, strong) UILabel *first_orderTimeLabel;

@end

@implementation DDQOrderDetailFirstSectionCell

- (void)cell_contentViewSubviewsConfig {
    
    [super cell_contentViewSubviewsConfig];
    
    self.first_orderCodeLabel = [UILabel labelChangeText:@"afasfafafabfafca" font:DDQFont(14.0) textColor:kSetColor(102.0, 102.0, 102.0, 1.0)];
    
    self.first_orderTimeLabel = [UILabel labelChangeText:@"facfasfafcadsfcsdf" font:DDQFont(14.0) textColor:kSetColor(102.0, 102.0, 102.0, 1.0)];
    
    [self.contentView view_configSubviews:@[self.first_orderTimeLabel, self.first_orderCodeLabel]];

    self.contentView.backgroundColor = [UIColor whiteColor];
    
}

- (void)cell_updateContentSubviewsFrame {

    CGSize maxSize = CGSizeMake(self.contentView.width - self.first_orderCodeLabel.x * 2.0, 16.0);
    autoLayout(self.first_orderCodeLabel).ddq_leading(self.contentView.leading, self.cell_defaultLeftMargin).ddq_top(self.contentView.top, 15.0 * self.cell_widthRate).ddq_estimateSize(maxSize);
    
    autoLayout(self.first_orderTimeLabel).ddq_leading(self.first_orderCodeLabel.leading, 0.0).ddq_top(self.first_orderCodeLabel.bottom, 10.0 * self.cell_widthRate).ddq_estimateSize(maxSize);
    
    [super cell_updateContentSubviewsFrame];

}

- (UIView *)cell_layoutBottomControl {
    
    return self.first_orderTimeLabel;
    
}

- (CGFloat)cell_bottomMargin {
    
    return self.first_orderCodeLabel.y;
    
}

@end
