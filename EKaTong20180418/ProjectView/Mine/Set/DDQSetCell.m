//
//  DDQSetCell.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/25.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQSetCell.h"

@interface DDQSetCell ()

@property (nonatomic, strong) UILabel *set_titleLabel;
@property (nonatomic, strong) UILabel *set_sizeLabel;
@property (nonatomic, strong) UIImageView *set_arrowImageView;

@end

@implementation DDQSetCell

- (void)cell_contentViewSubviewsConfig {
    
    [super cell_contentViewSubviewsConfig];
    
    DDQSetCellStyle style = [self.class setCellStyle];
    
    self.set_titleLabel = [UILabel labelChangeText:@"" font:DDQFont(14.0) textColor:kSetColor(42.0, 42.0, 42.0, 1.0)];
    NSMutableArray *subviews = [NSMutableArray arrayWithObject:self.set_titleLabel];
    
    if (style == DDQSetCellStyleNormal) {
        
        self.set_arrowImageView = [UIImageView imageViewChangeImage:kSetImage(@"mine_more")];
        [subviews addObject:self.set_arrowImageView];
        
    } else {
        
        self.set_sizeLabel = [UILabel labelChangeText:@"0B" font:DDQFont(14.0) textColor:kSetColor(184.0, 184.0, 184.0, 1.0)];
        [subviews addObject:self.set_sizeLabel];
        
    }
    [self.contentView view_configSubviews:subviews.copy];
    
    self.cell_separatorStyle = DDQTableViewCellSeparatorStyleBottom;
    self.cell_separatorColor = self.defaultSeparatorColor;
    self.cell_separatorMargin = DDQSeparatorMarginMaker(20.0 * self.cell_widthRate, 20.0 * self.cell_widthRate);
    
}

- (void)cell_updateContentSubviewsFrame {
    
    autoLayout(self.set_titleLabel).ddq_leading(self.contentView.leading, self.cell_separatorMargin.leftMargin).ddq_top(self.contentView.top, 20.0 * self.cell_widthRate).ddq_fitSize();
    
    DDQSetCellStyle style = [self.class setCellStyle];
    if (style == DDQSetCellStyleNormal) {
        
        autoLayout(self.set_arrowImageView).ddq_trailing(self.contentView.trailing, self.cell_separatorMargin.rightMargin).ddq_centerY(self.set_titleLabel.centerY, 0.0).ddq_fitSize();
        
    } else {
        
        autoLayout(self.set_sizeLabel).ddq_trailing(self.contentView.trailing, self.cell_separatorMargin.rightMargin).ddq_centerY(self.set_titleLabel.centerY, 0.0).ddq_fitSize();
        
    }
    [super cell_updateContentSubviewsFrame];
    
}

- (void)cell_updateDataWithModel:(__kindof DDQBaseCellModel *)model {
    
    DDQSetModel *setModel = model;
    
    self.set_sizeLabel.text = setModel.size;
    self.set_titleLabel.text = setModel.title;
    
    [super cell_updateDataWithModel:model];
    
}

- (UIView *)cell_layoutBottomControl {
    
    return self.set_titleLabel;
    
}

- (CGFloat)cell_bottomMargin {
    
    return self.set_titleLabel.y;
    
}

+ (DDQSetCellStyle)setCellStyle {
    
    return DDQSetCellStyleNormal;
    
}

@end

@implementation DDQSetModel

@end
