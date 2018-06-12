//
//  DDQOrderSubCell.m
//  WeiDuoShiGuang20171106
//
//  Created by 我叫咚咚枪 on 2017/12/1.
//  Copyright © 2017年 我叫咚咚枪. All rights reserved.
//

#import "DDQOrderSubCell.h"

@interface DDQOrderSubCell ()

/** 图片 */
@property (nonatomic, strong) UIImageView *sub_imageView;
/** 名称 */
@property (nonatomic, strong) UILabel *sub_nameLabel;
/** 个数 */
@property (nonatomic, strong) UILabel *sub_countLabel;
@property (nonatomic, strong) UILabel *sub_timeLabel;
@property (nonatomic, strong) UILabel *sub_priceLabel;

@property (nonatomic, assign) DDQViewVHMargin sub_defalutMargin;

@end

@implementation DDQOrderSubCell

- (void)cell_contentViewSubviewsConfig {
    
    [super cell_contentViewSubviewsConfig];
    
    self.sub_imageView = [UIImageView imageView];
    self.sub_imageView.layer.cornerRadius = 5.0;
    self.sub_imageView.layer.masksToBounds = YES;
    
    CGFloat fontSize = 16.0;
    UIColor *textColor = [UIColor blackColor];
    self.sub_nameLabel = [UILabel labelChangeText:@" " font:[UIFont systemFontOfSize:fontSize] textColor:textColor];
    self.sub_nameLabel.textAlignment = NSTextAlignmentLeft;
    
    self.sub_countLabel = [UILabel labelChangeText:@" " font:[UIFont systemFontOfSize:fontSize - 4.0] textColor:self.defaultGrayColor];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"￥6000" attributes:@{NSFontAttributeName:DDQFont(fontSize - 2.0), NSForegroundColorAttributeName:self.defaultBlackColor}];
    [attributeString addAttribute:NSFontAttributeName value:DDQFont(11.0) range:[attributeString.string rangeOfString:@"￥"]];
    self.sub_priceLabel = [UILabel labelChangeText:@"" font:[UIFont systemFontOfSize:fontSize - 2.0] textColor:self.defaultBlackColor];
    self.sub_priceLabel.attributedText = attributeString.copy;
    
    self.sub_timeLabel = [UILabel labelChangeText:@" " font:[UIFont systemFontOfSize:fontSize - 4.0] textColor:self.defaultGrayColor];
    
    [self.contentView view_configSubviews:@[self.sub_imageView, self.sub_nameLabel, self.sub_countLabel, self.sub_priceLabel, self.sub_timeLabel]];
    
    self.sub_defalutMargin = DDQViewVHMarginMaker(10.0 * self.cell_widthRate, self.cell_defaultLeftMargin);
    
    self.cell_separatorMargin = DDQSeparatorMarginZero;
    self.cell_separatorStyle = DDQTableViewCellSeparatorStyleBottom;
    self.cell_separatorColor = self.defaultSeparatorColor;
    
}

- (void)cell_updateDataWithModel:(__kindof DDQBaseCellModel *)model {
    
    DDQOrderSubModel *subModel = model;
    
    [self.sub_imageView sd_setImageWithURL:[NSURL URLWithString:subModel.image]];
    self.sub_nameLabel.text = subModel.name;
    self.sub_countLabel.text = [NSString stringWithFormat:@"数量：%@", subModel.num];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:subModel.time.doubleValue];
    NSInteger month = [calendar component:NSCalendarUnitMonth fromDate:date];
    NSInteger day = [calendar component:NSCalendarUnitDay fromDate:date];
    self.sub_timeLabel.text = [NSString stringWithFormat:@"%ld月%ld日", month, day];
    
    [super cell_updateDataWithModel:model];
    
}

- (void)cell_updateContentSubviewsFrame {
    
    DDQViewVHSpace space = DDQViewVHSpaceMaker(0.0, 10.0 * self.cell_widthRate);

    autoLayout(self.sub_imageView).ddq_leading(self.contentView.leading, self.sub_defalutMargin.horMargin).ddq_top(self.contentView.top, self.sub_defalutMargin.verMargin).ddq_size(CGSizeMake(115.0 * self.cell_widthRate, 95.0 * self.cell_widthRate));
    
    autoLayout(self.sub_priceLabel).ddq_trailing(self.contentView.trailing, self.sub_defalutMargin.horMargin).ddq_top(self.sub_imageView.top, 15.0 * self.cell_widthRate).ddq_estimateSize(CGSizeMake(100.0 * self.cell_widthRate, 16.0));
    
    CGFloat maxW = self.contentView.width - (self.sub_imageView.frameMaxX + space.horSpace + self.sub_defalutMargin.horMargin + self.sub_priceLabel.width + 5.0);
    autoLayout(self.sub_nameLabel).ddq_leading(self.sub_imageView.trailing, space.horSpace).ddq_top(self.sub_imageView.top, 5.0).ddq_estimateSize(CGSizeMake(maxW, 45.0 * self.cell_widthRate));
    
    autoLayout(self.sub_timeLabel).ddq_leading(self.sub_nameLabel.leading, 0.0).ddq_top(self.sub_nameLabel.bottom, 8.0 * self.cell_widthRate).ddq_estimateSize(CGSizeMake(maxW, 14.0));
    
    autoLayout(self.sub_countLabel).ddq_leading(self.sub_nameLabel.leading, 0.0).ddq_top(self.sub_timeLabel.bottom, 15.0 * self.cell_widthRate).ddq_estimateSize(CGSizeMake(maxW + self.sub_priceLabel.width, 14.0));
    
    [super cell_updateContentSubviewsFrame];

}

- (UIView *)cell_layoutBottomControl {
    
    return self.sub_imageView;
    
}

- (CGFloat)cell_bottomMargin {
    
    return self.sub_defalutMargin.verMargin + 5.0;
    
}

+ (CGFloat)sub_estimateHeight {
    
    DDQRateSet rateSet = [UIView view_getCurrentDeviceRateWithVersion:DDQFoundationRateDevice_iPhone6];
    return (95.0 + 25.0) * rateSet.widthRate;
    
}

@end

@implementation DDQOrderSubModel


@end
