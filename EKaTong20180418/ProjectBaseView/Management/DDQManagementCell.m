//
//  DDQManagementCell.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/4.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQManagementCell.h"

@interface DDQManagementCell ()

@property (nonatomic, strong) UIImageView *management_imageView;
@property (nonatomic, strong) UILabel *management_titleLabel;
@property (nonatomic, strong) UILabel *management_timeLabel;
@property (nonatomic, strong) UILabel *management_priceLabel;
@property (nonatomic, strong) UIView *management_separator;
@property (nonatomic, strong) UIButton *management_editButton;

@end

@implementation DDQManagementCell

- (void)cell_contentViewSubviewsConfig {
    
    [super cell_contentViewSubviewsConfig];
    
    self.management_imageView = [UIImageView imageView];
    
    self.management_titleLabel = [UILabel labelChangeText:@" " font:DDQFont(16.0) textColor:kSetColor(20.0, 26.0, 36.0, 1.0)];
    self.management_titleLabel.textAlignment = NSTextAlignmentLeft;
    
    self.management_timeLabel = [UILabel labelChangeText:@" " font:DDQFont(13.0) textColor:self.defaultGrayColor];
    
    self.management_priceLabel = [UILabel labelChangeText:@" " font:DDQFont(16.0) textColor:self.defaultOrangeColor];
    
    self.management_separator = [UIView viewChangeBackgroundColor:self.defaultSeparatorColor];
    
    self.management_editButton = [UIButton buttonChangeFont:DDQFont(14.0) titleColor:kSetColor(135.0, 135.0, 135.0, 1.0) image:nil backgroundImage:nil title:@"编辑" attributeTitle:nil target:self sel:@selector(management_didSelectEdit)];
    [self.management_editButton view_hanlderLayerWithRadius:3.0 borderWidth:1.0 borderColor:kSetColor(135.0, 135.0, 135.0, 1.0)];
    
    [self.contentView view_configSubviews:@[self.management_imageView, self.management_titleLabel, self.management_timeLabel, self.management_priceLabel, self.management_separator, self.management_editButton]];
    
}

- (void)cell_updateContentSubviewsFrame {
    
    autoLayout(self.management_imageView).ddq_leading(self.contentView.leading, self.cell_defaultLeftMargin).ddq_top(self.contentView.top, 8.0 * self.cell_widthRate).ddq_size(CGSizeMake(115.0 * self.cell_widthRate, 80.0 * self.cell_widthRate));
    
    CGSize maxSize = CGSizeMake(self.contentView.width - self.management_imageView.frameMaxX - 10.0 * self.cell_widthRate - self.cell_defaultLeftMargin, 40.0);
    autoLayout(self.management_titleLabel).ddq_leading(self.management_imageView.trailing, 10.0 * self.cell_widthRate).ddq_top(self.management_imageView.top, 3.0).ddq_estimateSize(maxSize);
    
    autoLayout(self.management_timeLabel).ddq_leading(self.management_titleLabel.leading, 0.0).ddq_top(self.management_titleLabel.bottom, 10.0 * self.cell_widthRate).ddq_estimateSize(CGSizeMake(maxSize.width, 15.0));
    
    autoLayout(self.management_priceLabel).ddq_leading(self.management_timeLabel.leading, 0.0).ddq_top(self.management_timeLabel.bottom, 10.0 * self.cell_widthRate).ddq_estimateSize(CGSizeMake(maxSize.width, 18.0));
    
    autoLayout(self.management_separator).ddq_leading(self.contentView.leading, 0.0).ddq_top(((self.management_priceLabel.frameMaxX > self.management_imageView.frameMaxX) ? self.management_priceLabel : self.management_imageView).bottom, self.cell_defaultLeftMargin).ddq_size(CGSizeMake(self.contentView.width, 1.0));
    
    autoLayout(self.management_editButton).ddq_trailing(self.contentView.trailing, self.cell_defaultLeftMargin).ddq_top(self.management_separator.bottom, 8.0).ddq_size(CGSizeMake(60.0 * self.cell_widthRate, 27.0));
    
    [super cell_updateContentSubviewsFrame];
    
}

- (void)cell_updateDataWithModel:(__kindof DDQBaseCellModel *)model {
    
    NSString *title = nil;
    NSMutableAttributedString *priceAttr = nil;
    NSString *time = nil;
    NSString *url = nil;
    
    if ([model isKindOfClass:[DDQActivityModel class]]) {
        
        DDQActivityModel *activityModel = model;
        title = activityModel.activity_name;
        
        NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:activityModel.activity_start.doubleValue];
        NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:activityModel.activity_end.doubleValue];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSInteger sMonth = [calendar component:NSCalendarUnitMonth fromDate:startDate];
        NSInteger sDay = [calendar component:NSCalendarUnitDay fromDate:startDate];
        NSInteger eMonth = [calendar component:NSCalendarUnitMonth fromDate:endDate];
        NSInteger eDay = [calendar component:NSCalendarUnitDay fromDate:endDate];
        time = [NSString stringWithFormat:@"%ld.%ld-%ld.%ld", sMonth, sDay, eMonth, eDay];
        
        NSString *price = [NSString stringWithFormat:@"￥%@/人", activityModel.activity_price];
        priceAttr = [[NSMutableAttributedString alloc] initWithString:price attributes:@{NSFontAttributeName:DDQFont(16.0), NSForegroundColorAttributeName:self.defaultOrangeColor}];
        [priceAttr addAttribute:NSFontAttributeName value:DDQFont(12.0) range:[priceAttr.string rangeOfString:@"￥"]];
        [priceAttr addAttribute:NSFontAttributeName value:DDQFont(12.0) range:[priceAttr.string rangeOfString:@"/人"]];

        url = activityModel.activity_image;

    } else {
        
        DDQManagementModel *managementModel = model;
        title = managementModel.base_name;
        
        NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:managementModel.base_start.doubleValue];
        NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:managementModel.base_end.doubleValue];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSInteger sMonth = [calendar component:NSCalendarUnitMonth fromDate:startDate];
        NSInteger sDay = [calendar component:NSCalendarUnitDay fromDate:startDate];
        NSInteger eMonth = [calendar component:NSCalendarUnitMonth fromDate:endDate];
        NSInteger eDay = [calendar component:NSCalendarUnitDay fromDate:endDate];
        time = [NSString stringWithFormat:@"%ld.%ld-%ld.%ld", sMonth, sDay, eMonth, eDay];
        
        NSString *price = [NSString stringWithFormat:@"￥%@/人", managementModel.base_price];
        priceAttr = [[NSMutableAttributedString alloc] initWithString:price attributes:@{NSFontAttributeName:DDQFont(16.0), NSForegroundColorAttributeName:self.defaultOrangeColor}];
        [priceAttr addAttribute:NSFontAttributeName value:DDQFont(12.0) range:[priceAttr.string rangeOfString:@"￥"]];
        [priceAttr addAttribute:NSFontAttributeName value:DDQFont(12.0) range:[priceAttr.string rangeOfString:@"/人"]];
        
        url = managementModel.base_image;

    }
    
    self.management_titleLabel.text = title;
    
    [self.management_imageView sd_setImageWithURL:[NSURL URLWithString:url]];
    
    self.management_priceLabel.attributedText = priceAttr;
    
    self.management_timeLabel.text = time;

    [super cell_updateDataWithModel:model];
    
}

- (UIView *)cell_layoutBottomControl {
    
    return self.management_editButton;
    
}

- (CGFloat)cell_bottomMargin {
    
    return 8.0;
    
}

/**
 点击“编辑”
 */
- (void)management_didSelectEdit {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(management_didSelectEditWithModel:)]) {
        
        [self.delegate management_didSelectEditWithModel:self.cell_model];
        
    }
}

@end

@implementation DDQManagementModel

@end

@implementation DDQActivityModel

@end
