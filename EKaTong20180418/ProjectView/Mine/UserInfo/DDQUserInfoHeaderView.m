//
//  DDQUserInfoHeaderView.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/24.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQUserInfoHeaderView.h"

#import "UIView+DDQAdditionalContent.h"

#import <SDWebImage/UIButton+WebCache.h>

@interface DDQUserInfoHeaderView ()

@property (nonatomic, strong) UIButton *header_button;
@property (nonatomic, strong) UIImageView *header_cameraImageView;
@property (nonatomic, strong) UIView *header_separator;
@property (nonatomic, copy) DDQUserInfoHeaderPickImage header_pick;

@end

@implementation DDQUserInfoHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    self.header_button = [UIButton buttonChangeFont:nil titleColor:nil image:nil backgroundImage:nil title:nil attributeTitle:nil target:self sel:@selector(header_didSelectImageButton)];
    self.header_button.layer.shadowColor = kSetColor(227.0, 227.0, 227.0, 1.0).CGColor;
    self.header_button.layer.shadowRadius = 8.0;
    self.header_button.layer.shadowOpacity = 1.0;
    self.header_button.layer.masksToBounds = YES;

    self.header_cameraImageView = [UIImageView imageViewChangeImage:kSetImage(@"mine_camera")];
    
    self.header_separator = [UIView viewChangeBackgroundColor:self.defaultSeparatorColor];
    
    [self.contentView view_configSubviews:@[self.header_button, self.header_cameraImageView, self.header_separator]];
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    return self;
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    DDQRateSet rateSet = [UIView view_getCurrentDeviceRateWithVersion:DDQFoundationRateDevice_iPhone6];
    CGFloat buttonWH = 85.0 * rateSet.widthRate;
    self.header_button.auto_layout.ddq_centerX(self.contentView.centerX, 0.0).ddq_top(self.contentView.top, 20.0 * rateSet.widthRate).ddq_size(CGSizeMake(buttonWH, buttonWH));
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.header_button.boundsMidX + 2.0, self.header_button.boundsMidY + 2.0) radius:self.header_button.height * 0.5 startAngle:0.0 endAngle:2.0 * M_PI clockwise:1];
    self.header_button.layer.shadowPath = shadowPath.CGPath;
    [self.header_button view_hanlderLayerWithRadius:self.header_button.height * 0.5 borderWidth:2.0 borderColor:[UIColor whiteColor]];
//    self.header_button.layer.masksToBounds = NO;
    
    self.header_cameraImageView.auto_layout.ddq_trailing(self.header_button.trailing, 5.0 * rateSet.widthRate).ddq_bottom(self.header_button.bottom, 5.0 * rateSet.widthRate).ddq_fitSize();
    
    self.header_separator.auto_layout.ddq_bottom(self.contentView.bottom, 0.0).ddq_leading(self.contentView.leading, 0.0).ddq_size(CGSizeMake(self.contentView.width, 1.0));
    
}

/**
 点击头像
 */
- (void)header_didSelectImageButton {
    
    if (self.header_pick) {
        
        self.header_pick();
        
    }
}

- (void)userInfo_didSelectPickImage:(DDQUserInfoHeaderPickImage)pick {
    
    if (pick) {
        
        self.header_pick = pick;
        
    }
}

- (void)setHeader_image:(UIImage *)header_image {
    
    _header_image = header_image;
    
    [self.header_button setBackgroundImage:_header_image forState:UIControlStateNormal];
    
}

- (void)setHeader_url:(NSString *)header_url {
    
    _header_url = header_url;
    
    [self.header_button sd_setBackgroundImageWithURL:[NSURL URLWithString:_header_url] forState:UIControlStateNormal placeholderImage:kSetImage(@"icon_placeholder")];
    
}

@end
