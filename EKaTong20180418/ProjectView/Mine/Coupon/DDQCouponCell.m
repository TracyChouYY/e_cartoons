//
//  DDQCouponCell.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/17.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQCouponCell.h"

@interface DDQCouponCell ()

@property (nonatomic, strong) UIImageView *coupon_imageView;
@property (nonatomic, strong) UILabel *coupon_titleLabel;
@property (nonatomic, strong) UILabel *coupon_timeLabel;
@property (nonatomic, strong) UILabel *coupon_descrptionLabel;
@property (nonatomic, strong) UIView *coupon_contentView;

@end

@implementation DDQCouponCell

- (void)cell_contentViewSubviewsConfig {
    
    [super cell_contentViewSubviewsConfig];
    
    self.coupon_contentView = [UIView viewChangeBackgroundColor:[UIColor whiteColor]];
    
    self.coupon_imageView = [UIImageView imageView];
    self.coupon_titleLabel = [UILabel labelChangeText:@"" font:DDQFont(15.0) textColor:kSetColor(76.0, 77.0, 79.0, 1.0)];
    self.coupon_timeLabel = [UILabel labelChangeText:@"" font:DDQFont(12.0) textColor:kSetColor(121.0, 121.0, 121.0, 1.0)];
    self.coupon_descrptionLabel = [UILabel labelChangeText:@"" font:DDQFont(12.0) textColor:self.coupon_timeLabel.textColor];
    
    [self.coupon_contentView view_configSubviews:@[self.coupon_imageView, self.coupon_titleLabel, self.coupon_timeLabel, self.coupon_descrptionLabel]];
    
    [self.contentView addSubview:self.coupon_contentView];
    
    self.contentView.backgroundColor = self.defaultViewBackgroundColor;
    
}

- (void)cell_updateContentSubviewsFrame {
    
    autoLayout(self.coupon_contentView).ddq_leading(self.contentView.leading, 10.0 * self.cell_widthRate).ddq_top(self.contentView.top, 0.0).ddq_width(self.contentView.width - 10.0 * self.cell_widthRate);
    
    autoLayout(self.coupon_imageView).ddq_leading(self.coupon_contentView.leading, 0.0).ddq_top(self.coupon_contentView.top, 0.0).ddq_size(CGSizeMake(90.0 * self.cell_widthRate, 90.0 * self.cell_widthRate));
    
    autoLayout(self.coupon_titleLabel).ddq_leading(self.coupon_imageView.trailing, 15.0 * self.cell_widthRate).ddq_top(self.coupon_imageView.top, 15.0 * self.cell_widthRate).ddq_estimateSize(CGSizeMake(self.coupon_contentView.width - self.coupon_titleLabel.x - 5.0, 35.0));
    
    autoLayout(self.coupon_timeLabel).ddq_leading(self.coupon_titleLabel.leading, 0.0).ddq_top(self.coupon_titleLabel.bottom, 12.0 * self.cell_widthRate).ddq_estimateSize(CGSizeMake(self.coupon_contentView.width - self.coupon_timeLabel.x - 5.0, 14.0));
    
    autoLayout(self.coupon_descrptionLabel).ddq_leading(self.coupon_titleLabel.leading, 0.0).ddq_top(self.coupon_timeLabel.bottom, 8.0).ddq_estimateSize(CGSizeMake(self.coupon_contentView.width - self.coupon_descrptionLabel.x - 5.0, 27.0));
    
    [super cell_updateContentSubviewsFrame];
    
}

- (void)cell_updateDataWithModel:(__kindof DDQBaseCellModel *)model {
    
    DDQCouponModel *couponModel = model;
    
    [self.coupon_imageView sd_setImageWithURL:[NSURL URLWithString:couponModel.coupon_image]];
    self.coupon_titleLabel.text = couponModel.coupon_name;
    self.coupon_timeLabel.text = [NSString stringWithFormat:@"有效期：%@至%@", [self view_changeTimes:couponModel.coupon_start format:@"yyyy-MM-dd"], [self view_changeTimes:couponModel.coupon_end format:@"yyyy-MM-dd"]];
    self.coupon_descrptionLabel.text = [NSString stringWithFormat:@"订单满%@元可用", couponModel.coupon_price];
    
    [super cell_updateDataWithModel:model];
    
}

- (UIView *)cell_layoutBottomControl {
    
    return (self.coupon_descrptionLabel.frameMaxY > self.coupon_imageView.frameMaxY) ? self.coupon_descrptionLabel : self.coupon_imageView;
    
}

- (CGFloat)cell_bottomMargin {
    
    return (self.coupon_descrptionLabel.frameMaxY > self.coupon_imageView.frameMaxY) ? 5.0 : 0.0;

}


@end

@implementation DDQCouponModel
@end
