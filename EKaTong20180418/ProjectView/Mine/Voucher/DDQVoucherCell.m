//
//  DDQVoucherCell.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/27.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQVoucherCell.h"

@interface DDQVoucherCell ()

@property (nonatomic, strong) UIImageView *voucher_backgroundImage;
@property (nonatomic, strong) UILabel *voucher_titleLabel;
@property (nonatomic, strong) UILabel *voucher_timeLabel;
@property (nonatomic, strong) UILabel *voucher_addressLabel;

@end

@implementation DDQVoucherCell

- (void)cell_contentViewSubviewsConfig {
    
    [super cell_contentViewSubviewsConfig];
    
    DDQVoucherCellStyle style = [self.class voucherCellStyle];
    if (style == DDQVoucherCellStyleUnknown) return;
    
    UIImage *image = (style == DDQVoucherCellStyleExamine) ? kSetImage(@"voucher_check") : kSetImage(@"voucher_uncheck");
    self.voucher_backgroundImage = [UIImageView imageViewChangeImage:image];
    
    UIColor *normalColor = kSetColor(20.0, 26.0, 36.0, 1.0);
    UIColor *titleColor = (style == DDQVoucherCellStyleExamine) ? kSetColor(148.0, 148.0, 148.0, 1.0) : normalColor;
    self.voucher_titleLabel = [UILabel labelChangeText:@"ssssssfsdgfbsdf" font:DDQFont(15.0) textColor:titleColor];
    
    self.voucher_timeLabel = [UILabel labelChangeText:@"dfcsdfvasc" font:DDQFont(11.0) textColor:kSetColor(148.0, 148.0, 148.0, 1.0)];
    
    self.voucher_addressLabel = [UILabel labelChangeText:@"fxsacfafvdfs" font:DDQFont(11.0) textColor:self.voucher_timeLabel.textColor];
    
    [self.contentView view_configSubviews:@[self.voucher_backgroundImage, self.voucher_titleLabel, self.voucher_timeLabel, self.voucher_addressLabel]];
    
    self.contentView.backgroundColor = self.defaultViewBackgroundColor;
    
}

- (void)cell_updateContentSubviewsFrame {
    
    autoLayout(self.voucher_backgroundImage).ddq_top(self.contentView.top, 0.0).ddq_centerX(self.contentView.centerX, 0.0).ddq_fitScaleSize(self.cell_widthRate);
    
    autoLayout(self.voucher_titleLabel).ddq_leading(self.voucher_backgroundImage.leading, 60.0 * self.cell_widthRate).ddq_top(self.voucher_backgroundImage.top, 15.0 * self.cell_widthRate).ddq_estimateSize(CGSizeMake(225.0 * self.cell_widthRate, 16.0));
    
    autoLayout(self.voucher_timeLabel).ddq_leading(self.voucher_titleLabel.leading, 0.0).ddq_top(self.voucher_titleLabel.bottom, 10.0 * self.cell_widthRate).ddq_estimateSize(CGSizeMake(225.0 * self.cell_widthRate, 12.0));
    
    autoLayout(self.voucher_addressLabel).ddq_leading(self.voucher_timeLabel.leading, 0.0).ddq_top(self.voucher_timeLabel.bottom, 10.0 * self.cell_widthRate).ddq_estimateSize(CGSizeMake(225.0 * self.cell_widthRate, 12.0));
    
    [super cell_updateContentSubviewsFrame];
    
}

+ (DDQVoucherCellStyle)voucherCellStyle {
    
    return DDQVoucherCellStyleUnknown;
    
}

- (UIView *)cell_layoutBottomControl {
    
    return self.voucher_backgroundImage;
    
}

@end
