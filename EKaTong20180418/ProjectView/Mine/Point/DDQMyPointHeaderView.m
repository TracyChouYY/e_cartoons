//
//  DDQMyPointHeaderView.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/25.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQMyPointHeaderView.h"

@interface DDQMyPointHeaderView ()

@property (nonatomic, strong) UIImageView *header_imageView;
@property (nonatomic, strong) UILabel *header_pointLabel;
@property (nonatomic, strong) UILabel *header_titleLabel;
@property (nonatomic, strong) UIButton *header_signButton;
@property (nonatomic, copy) DDQMyPointHeaderOperation header_operation;

@end

@implementation DDQMyPointHeaderView

- (void)view_subviewsConfig {
    
    [super view_subviewsConfig];
    
    self.header_imageView = [UIImageView imageViewChangeImage:kSetImage(@"point_sign")];
    
    self.header_pointLabel = [UILabel labelChangeText:@"0" font:DDQFont(30.0) textColor:[UIColor blackColor]];
    
    self.header_titleLabel = [UILabel labelChangeText:@"赶紧签到获得更多积分" font:DDQFont(10.0) textColor:kSetColor(193.0, 193.0, 193.0, 1.0)];
    
    self.header_signButton = [UIButton buttonChangeFont:DDQFont(15.0) titleColor:[UIColor whiteColor] image:nil backgroundImage:nil title:@"立即签到" attributeTitle:nil target:self sel:@selector(header_didSelectSign)];
    self.header_signButton.backgroundColor = self.defaultOrangeColor;
    self.header_signButton.layer.shadowColor = kSetColor(255.0, 225.0, 219.0, 1.0).CGColor;
    self.header_signButton.layer.shadowOffset = CGSizeMake(5.0, 5.0);
    self.header_signButton.layer.shadowOpacity = 1.0;
    
    [self view_configSubviews:@[self.header_imageView, self.header_pointLabel, self.header_titleLabel, self.header_signButton]];
    
}

- (void)view_updateContentSubviewsFrame {
    
    [super view_updateContentSubviewsFrame];
    
    [self.header_imageView sizeToFit];
    
    autoLayout(self.header_pointLabel).ddq_centerX(self.centerX, 0.0).ddq_top(self.top, 30.0 * self.view_widthRate).ddq_estimateSize(CGSizeMake(self.width - self.header_imageView.width - 5.0 - 30.0 * self.view_widthRate, 45.0));
    
    autoLayout(self.header_imageView).ddq_trailing(self.header_pointLabel.leading, 5.0).ddq_centerY(self.header_pointLabel.centerY, 0.0).ddq_fitSize();
    
    autoLayout(self.header_titleLabel).ddq_centerX(self.centerX, 0.0).ddq_top(self.header_pointLabel.bottom, 25.0 * self.view_widthRate).ddq_fitSize();
    
    autoLayout(self.header_signButton).ddq_centerX(self.centerX, 0.0).ddq_top(self.header_titleLabel.bottom, 12.0 * self.view_widthRate).ddq_size(CGSizeMake(200.0 * self.view_widthRate, 40.0 * self.view_widthRate));
    self.header_signButton.layer.cornerRadius = self.header_signButton.height * 0.5;
    
}

- (CGFloat)header_estimateHeight {
    
    return self.header_signButton.frameMaxY + 10.0 * self.view_widthRate;
    
}

/**
 点击“立即签到”
 */
- (void)header_didSelectSign {
    
    if (self.header_operation) {
        
        self.header_operation();
        
    }
}

- (void)header_didSelectSignIn:(DDQMyPointHeaderOperation)operation {
    
    if (operation) {
        
        self.header_operation = operation;
        
    }
}

@end
