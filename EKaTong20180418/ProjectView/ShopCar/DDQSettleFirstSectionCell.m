//
//  DDQSettleFirstSectionCell.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/2.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQSettleFirstSectionCell.h"

@interface DDQSettleFirstSectionCell ()

@property (nonatomic, strong) UIImageView *first_imageView;
@property (nonatomic, strong) UILabel *first_titleLabel;
@property (nonatomic, strong) UILabel *first_timeLabel;
@property (nonatomic, strong) UILabel *first_addressLabel;
@property (nonatomic, strong) UILabel *first_priceLabel;

@end

@implementation DDQSettleFirstSectionCell

- (void)cell_contentViewSubviewsConfig {
    
    [super cell_contentViewSubviewsConfig];
    
    DDQSettleFirstSectionCellStyle style = [self.class firstSectionCellStyle];
    if (style == DDQSettleFirstSectionCellStyleUnknown) return;
    
    self.first_imageView = [UIImageView imageView];
    self.first_imageView.layer.cornerRadius = 5.0;
    
    self.first_titleLabel = [UILabel labelChangeText:@" " font:DDQFont(16.0) textColor:kSetColor(20.0, 26.0, 36.0, 1.0)];
    self.first_titleLabel.textAlignment = NSTextAlignmentLeft;
    
    self.first_timeLabel = [UILabel labelChangeText:@" " font:DDQFont(13.0) textColor:self.defaultGrayColor];
    self.first_timeLabel.textAlignment = NSTextAlignmentLeft;

    NSMutableArray *array = [NSMutableArray arrayWithArray:@[self.first_imageView, self.first_titleLabel, self.first_timeLabel]];
    
    if (style == DDQSettleFirstSectionCellStylePurchase) {
        
        self.first_addressLabel = [UILabel labelChangeText:@" " font:DDQFont(12.0) textColor:self.defaultGrayColor];
        self.first_addressLabel.textAlignment = NSTextAlignmentLeft;
        [array addObject:self.first_addressLabel];
        
    } else {
        
        self.first_priceLabel = [UILabel labelChangeText:@" " font:DDQFont(16.0) textColor:self.defaultOrangeColor];
        [array addObject:self.first_priceLabel];
        
    }
    [self.contentView view_configSubviews:array.copy];
    
}

- (void)cell_updateContentSubviewsFrame {
    
    DDQSettleFirstSectionCellStyle style = [self.class firstSectionCellStyle];
    if (style == DDQSettleFirstSectionCellStyleUnknown) return;

    if (style == DDQSettleFirstSectionCellStylePurchase) {
        
        autoLayout(self.first_imageView).ddq_leading(self.contentView.leading, self.cell_defaultLeftMargin).ddq_top(self.contentView.top, self.cell_defaultLeftMargin).ddq_size(CGSizeMake(85.0 * self.cell_widthRate, 85.0 * self.cell_widthRate));
        
        CGSize maxSize = CGSizeMake(self.contentView.width - self.first_titleLabel.x - self.cell_defaultLeftMargin, 42.0);
        autoLayout(self.first_titleLabel).ddq_leading(self.first_imageView.trailing, 12.0 * self.cell_widthRate).ddq_top(self.first_imageView.top, 0.0).ddq_estimateSize(maxSize);
        
        autoLayout(self.first_timeLabel).ddq_leading(self.first_titleLabel.leading, 0.0).ddq_top(self.first_titleLabel.bottom, 10.0 * self.cell_widthRate).ddq_estimateSize(CGSizeMake(maxSize.width, 14.0));
        
        autoLayout(self.first_addressLabel).ddq_leading(self.first_timeLabel.leading, 0.0).ddq_top(self.first_timeLabel.bottom, 12.0 * self.cell_widthRate).ddq_estimateSize(CGSizeMake(maxSize.width, 30.0));
        
    } else {
        
        autoLayout(self.first_imageView).ddq_leading(self.contentView.leading, 0.0).ddq_top(self.contentView.top, 0.0).ddq_size(CGSizeMake(self.contentView.width, 270.0 * self.cell_widthRate));
        
        autoLayout(self.first_titleLabel).ddq_leading(self.contentView.leading, self.cell_defaultLeftMargin).ddq_top(self.first_imageView.bottom, self.cell_defaultLeftMargin).ddq_estimateSize(CGSizeMake(self.contentView.width - self.cell_defaultLeftMargin * 2.0, 36.0));
        
        autoLayout(self.first_timeLabel).ddq_leading(self.first_titleLabel.leading, 0.0).ddq_top(self.first_titleLabel.bottom, 10.0 * self.cell_widthRate).ddq_estimateSize(CGSizeMake(self.contentView.width * 0.6, 15.0));
        
        autoLayout(self.first_priceLabel).ddq_trailing(self.contentView.trailing, self.cell_defaultLeftMargin).ddq_centerY(self.first_timeLabel.centerY, 0.0).ddq_estimateSize(CGSizeMake(self.contentView.width - self.first_timeLabel.frameMaxX - self.cell_defaultLeftMargin - 5.0, 18.0));
        
    }
    
    [super cell_updateContentSubviewsFrame];
    
}

- (void)cell_updateDataWithModel:(__kindof DDQBaseCellModel *)model {
    
    DDQSettleFirstSectionModel *firstModel = model;
    
    [self.first_imageView sd_setImageWithURL:[NSURL URLWithString:firstModel.image]];
    self.first_titleLabel.text = firstModel.name;
    self.first_timeLabel.text = [@"门票日期  " stringByAppendingString:[self cell_exchangeWithStartTime:firstModel.start endTime:firstModel.end]];
    
    if ([self.class firstSectionCellStyle] == DDQSettleFirstSectionCellStyleJogin) {
        
        NSString *price = [NSString stringWithFormat:@"￥%@/人", firstModel.price];
        NSMutableAttributedString *priceAttr = [[NSMutableAttributedString alloc] initWithString:price attributes:@{NSFontAttributeName:DDQFont(16.0), NSForegroundColorAttributeName:self.defaultOrangeColor}];
        [priceAttr addAttribute:NSFontAttributeName value:DDQFont(12.0) range:[priceAttr.string rangeOfString:@"￥"]];
        [priceAttr addAttribute:NSFontAttributeName value:DDQFont(12.0) range:[priceAttr.string rangeOfString:@"/人"]];
        self.first_priceLabel.attributedText = priceAttr;
        
    } else if ([self.class firstSectionCellStyle] == DDQSettleFirstSectionCellStylePurchase) {
        
        self.first_addressLabel.text = firstModel.address;
        
    }
    [super cell_updateDataWithModel:model];
    
}

- (UIView *)cell_layoutBottomControl {
    
    DDQSettleFirstSectionCellStyle style = [self.class firstSectionCellStyle];
    if (style == DDQSettleFirstSectionCellStyleUnknown) return nil;
    
    if (style == DDQSettleFirstSectionCellStylePurchase) {
        
        return (self.first_addressLabel.frameMaxY > self.first_imageView.frameMaxY) ? self.first_addressLabel : self.first_imageView;
        
    } else {
        
        return self.first_priceLabel;

    }
}

- (CGFloat)cell_bottomMargin {
    
    DDQSettleFirstSectionCellStyle style = [self.class firstSectionCellStyle];
    if (style == DDQSettleFirstSectionCellStyleUnknown) return 0.0;
    
    return 15.0 * self.cell_widthRate;

}

+ (DDQSettleFirstSectionCellStyle)firstSectionCellStyle {
    
    return DDQSettleFirstSectionCellStyleUnknown;
    
}

@end

@implementation DDQSettleFirstSectionModel

@end
