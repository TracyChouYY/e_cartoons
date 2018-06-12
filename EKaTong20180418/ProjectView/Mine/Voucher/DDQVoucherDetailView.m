//
//  DDQVoucherDetailView.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/28.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQVoucherDetailView.h"

@interface DDQVoucherDetailView ()

@property (nonatomic, strong) UIImageView *detail_backgroundImageView;

@property (nonatomic, strong) UILabel *detail_titleLabel;
@property (nonatomic, strong) UILabel *detail_timeLabel;
@property (nonatomic, strong) UILabel *detail_addressLabel;
@property (nonatomic, strong) UIImageView *detail_imageView;

@property (nonatomic, strong) UILabel *detail_numberLabel;
@property (nonatomic, strong) UILabel *detail_statusLabel;
@property (nonatomic, strong) UILabel *detail_tipLabel;
@property (nonatomic, strong) UIImageView *detail_qrImageView;

@end

@implementation DDQVoucherDetailView

- (void)view_subviewsConfig {
    
    [super view_subviewsConfig];
    
    self.detail_backgroundImageView = [UIImageView imageViewChangeImage:kSetImage(@"voucher_content")];
    
    self.detail_imageView = [UIImageView imageView];
    
    self.detail_titleLabel = [UILabel labelChangeText:@"fnfshasnfncsfavshfnfn" font:DDQFont(22.0) textColor:self.defaultBlackColor];
    
    self.detail_timeLabel = [UILabel labelChangeText:@"dfasndfvaknn" font:DDQFont(12.0) textColor:self.defaultBlackColor];
    
    self.detail_addressLabel = [UILabel labelChangeText:@"fhahdjoifnanvkasfcnkaskdncfhansfvnaskvbgnasnfnakfnakfnm" font:DDQFont(13.0) textColor:self.defaultBlackColor];
    self.detail_addressLabel.textAlignment = NSTextAlignmentLeft;
    
    self.detail_numberLabel = [UILabel labelChangeText:@"发给你三个   女生看到GV看帅哥" font:DDQFont(15.0) textColor:self.defaultBlackColor];
    
    self.detail_statusLabel = [UILabel labelChangeText:@"发给你上课电力公司那个是" font:DDQFont(14.0) textColor:self.defaultGrayColor];
    
    self.detail_tipLabel = [UILabel labelChangeText:@"展示给验票人员进行扫描" font:DDQFont(15.0) textColor:self.defaultGrayColor];
    
    self.detail_qrImageView = [UIImageView imageView];
    
    [self addSubview:self.detail_backgroundImageView];
    [self.detail_backgroundImageView view_configSubviews:@[self.detail_titleLabel, self.detail_timeLabel, self.detail_imageView, self.detail_addressLabel, self.detail_numberLabel, self.detail_statusLabel, self.detail_qrImageView, self.detail_tipLabel]];

    self.backgroundColor = self.defaultViewBackgroundColor;
    
}

- (void)view_updateContentSubviewsFrame {
    
    [super view_updateContentSubviewsFrame];
    
    autoLayout(self.detail_backgroundImageView).ddq_top(self.top, 20.0 * self.view_widthRate).ddq_centerX(self.centerX, 0.0).ddq_fitScaleSize(self.view_widthRate);
    
    autoLayout(self.detail_imageView).ddq_trailing(self.detail_backgroundImageView.trailing, 18.0 * self.view_widthRate).ddq_top(self.detail_backgroundImageView.top, 20.0 * self.view_widthRate).ddq_size(CGSizeMake(115.0 * self.view_widthRate, 80.0 * self.view_widthRate));
    
    CGSize maxSize = CGSizeMake(self.detail_imageView.x - self.detail_titleLabel.x - 5.0, 27.0);
    autoLayout(self.detail_titleLabel).ddq_leading(self.detail_backgroundImageView.leading, 20.0 * self.view_widthRate).ddq_top(self.detail_imageView.top, 0.0).ddq_estimateSize(maxSize);
    
    autoLayout(self.detail_timeLabel).ddq_leading(self.detail_titleLabel.leading, 0.0).ddq_top(self.detail_titleLabel.bottom, 12.0 * self.view_widthRate).ddq_estimateSize(CGSizeMake(maxSize.width, 13.0));
    
    autoLayout(self.detail_addressLabel).ddq_leading(self.detail_timeLabel.leading, 0.0).ddq_top(self.detail_timeLabel.bottom, 5.0).ddq_estimateSize(CGSizeMake(maxSize.width, 30.0));
    
    autoLayout(self.detail_statusLabel).ddq_trailing(self.detail_imageView.trailing, 0.0).ddq_top(self.detail_imageView.bottom, 44.0 * self.view_widthRate).ddq_estimateSize(CGSizeMake(100.0, 16.0));
    
    autoLayout(self.detail_numberLabel).ddq_leading(self.detail_titleLabel.leading, 0.0).ddq_centerY(self.detail_statusLabel.centerY, 0.0).ddq_estimateSize(CGSizeMake(self.detail_statusLabel.x - self.detail_numberLabel.x - 5.0, 17.0));
    
    autoLayout(self.detail_qrImageView).ddq_centerX(self.detail_backgroundImageView.centerX, 0.0).ddq_top(self.detail_numberLabel.bottom, 30.0 * self.view_widthRate).ddq_size(CGSizeMake(155.0 * self.view_widthRate, 155.0 * self.view_widthRate));
    
    autoLayout(self.detail_tipLabel).ddq_centerX(self.detail_backgroundImageView.centerX, 0.0).ddq_top(self.detail_qrImageView.bottom, 20.0 * self.view_widthRate).ddq_fitSize();
    
}

@end
