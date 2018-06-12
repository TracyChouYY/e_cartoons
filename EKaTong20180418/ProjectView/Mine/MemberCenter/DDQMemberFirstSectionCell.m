//
//  DDQMemberFirstSectionCell.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/26.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQMemberFirstSectionCell.h"

@interface DDQMemberFirstSectionCell ()

@property (nonatomic, strong) UIImageView *first_contentImageView;
@property (nonatomic, strong) UILabel *first_nicknameLabel;
@property (nonatomic, strong) UILabel *first_titleLabel;
@property (nonatomic, strong) UIImageView *first_imageView;
@property (nonatomic, strong) UIView *first_cardView;
@property (nonatomic, strong) UILabel *first_nameLabel;
@property (nonatomic, strong) UILabel *first_tipLabel;
@property (nonatomic, strong) UIImageView *first_waveImageView;
@property (nonatomic, strong) UIView *first_contentView;
@property (nonatomic, strong) UILabel *first_productLabel;
@property (nonatomic, strong) UILabel *first_priceLabel;
@property (nonatomic, strong) UIView *first_lineView;
@property (nonatomic, strong) UIButton *first_openButton;

@end

@implementation DDQMemberFirstSectionCell

- (void)cell_contentViewSubviewsConfig {
    
    [super cell_contentViewSubviewsConfig];
    
    self.first_contentImageView = [UIImageView imageViewChangeImage:kSetImage(@"member_content")];
    self.first_contentImageView.contentMode = UIViewContentModeScaleToFill;
    
    self.first_nicknameLabel = [UILabel labelChangeText:@"我叫咚咚枪" font:DDQFont(18.0) textColor:[UIColor whiteColor]];
    
    self.first_titleLabel = [UILabel labelChangeText:@"购买注册卡给你更多优惠" font:DDQFont(13.0) textColor:kSetColor(228.0, 233.0, 246.0, 1.0)];
    
    self.first_imageView = [UIImageView imageView];
    self.first_imageView.backgroundColor = [UIColor redColor];
    
    self.first_cardView = [UIView viewChangeBackgroundColor:kSetColor(250.0, 250.0, 250.0, 1.0)];
    self.first_cardView.layer.cornerRadius = 5.0;
    
    self.first_tipLabel = [UILabel labelChangeText:@"E K A T O N G" font:DDQFont(30.0) textColor:kSetColor(27.0, 136.0, 238.0, 1.0)];
    
    self.first_nameLabel = [UILabel labelChangeText:@"注 册 卡" font:DDQFont(14.0) textColor:kSetColor(165.0, 169.0, 180.0, 1.0)];
    
    self.first_waveImageView = [UIImageView imageViewChangeImage:kSetImage(@"member_wave")];
    
    self.first_contentView = [UIView viewChangeBackgroundColor:[UIColor whiteColor]];
    
    self.first_productLabel = [UILabel labelChangeText:@"注册卡价格" font:DDQFont(13.0) textColor:self.defaultBlackColor];
    
    self.first_lineView = [UIView viewChangeBackgroundColor:self.defaultViewBackgroundColor];
    
    self.first_openButton = [UIButton buttonChangeFont:DDQFont(13.0) titleColor:[UIColor whiteColor] image:nil backgroundImage:nil title:@"立即开通" attributeTitle:nil target:self sel:@selector(member_didSelectOpen)];
    self.first_openButton.backgroundColor = self.defaultOrangeColor;
    
    NSMutableAttributedString *priceAttrString = [[NSMutableAttributedString alloc] initWithString:@"注册卡永久有效100元" attributes:@{NSFontAttributeName:DDQFont(13.0), NSForegroundColorAttributeName:kSetColor(64.0, 64.0, 64.0, 1.0)}];
    NSRange range = [priceAttrString.string rangeOfString:@"注册卡永久有效"];
    [priceAttrString addAttribute:NSForegroundColorAttributeName value:self.defaultOrangeColor range:NSMakeRange(range.location + range.length, priceAttrString.string.length - (range.location + range.length + 1))];
    self.first_priceLabel = [UILabel labelChangeText:@"" font:DDQFont(13.0) textColor:kSetColor(64.0, 64.0, 64.0, 1.0)];
    self.first_priceLabel.attributedText = priceAttrString;
    
    [self.contentView view_configSubviews:@[self.first_contentImageView, self.first_nicknameLabel, self.first_titleLabel, self.first_imageView, self.first_cardView, self.first_waveImageView, self.first_contentView]];
    [self.first_cardView view_configSubviews:@[self.first_nameLabel, self.first_tipLabel]];
    [self.first_contentView view_configSubviews:@[self.first_productLabel, self.first_priceLabel, self.first_openButton, self.first_lineView]];
    
}

- (void)cell_updateContentSubviewsFrame {
    
    CGFloat horMargin = 25.0 * self.cell_widthRate;
    CGSize imageSize = CGSizeMake(40.0 * self.cell_widthRate, 40.0 * self.cell_widthRate);
    CGSize maxSize = CGSizeMake(self.contentView.width - imageSize.width - horMargin * 2.0 - 5.0, 20.0);
    
    autoLayout(self.first_contentImageView).ddq_leading(self.contentView.leading, 0.0).ddq_top(self.contentView.top, 0.0).ddq_width(self.contentView.width);
    
    autoLayout(self.first_nicknameLabel).ddq_leading(self.contentView.leading, horMargin).ddq_top(self.contentView.top, 25.0 * self.cell_widthRate).ddq_estimateSize(maxSize);
    
    autoLayout(self.first_imageView).ddq_trailing(self.contentView.trailing, horMargin).ddq_centerY(self.first_nicknameLabel.bottom, 0.0).ddq_size(imageSize);
    self.first_imageView.layer.cornerRadius = imageSize.height * 0.5;
    
    autoLayout(self.first_titleLabel).ddq_leading(self.first_nicknameLabel.leading, 0.0).ddq_top(self.first_nicknameLabel.bottom, 10.0 * self.cell_widthRate).ddq_estimateSize(maxSize);
    
    autoLayout(self.first_cardView).ddq_leading(self.contentView.leading, self.cell_defaultLeftMargin).ddq_top(self.first_titleLabel.bottom, 10.0 * self.cell_widthRate).ddq_width(self.contentView.width - self.cell_defaultLeftMargin * 2.0);

    autoLayout(self.first_tipLabel).ddq_centerX(self.first_cardView.centerX, 0.0).ddq_top(self.first_cardView.top, 25.0 * self.cell_widthRate).ddq_fitSize();

    autoLayout(self.first_nameLabel).ddq_centerX(self.first_cardView.centerX, 0.0).ddq_top(self.first_tipLabel.bottom, 15.0 * self.cell_widthRate).ddq_fitSize();

    autoLayout(self.first_cardView).ddq_height(self.first_nameLabel.frameMaxY + self.first_tipLabel.y);
    
    autoLayout(self.first_contentImageView).ddq_height(self.first_cardView.frameMaxY);
    
    autoLayout(self.first_contentView).ddq_leading(self.contentView.leading, 0.0).ddq_top(self.first_cardView.bottom, 0.0).ddq_width(self.contentView.width);

    autoLayout(self.first_waveImageView).ddq_leading(self.first_contentView.leading, 0.0).ddq_bottom(self.first_contentView.top, 0.0).ddq_fitSize();

    autoLayout(self.first_productLabel).ddq_top(self.first_contentView.top, 20.0 * self.cell_widthRate).ddq_leading(self.first_contentView.leading, self.cell_defaultLeftMargin).ddq_fitSize();

    autoLayout(self.first_lineView).ddq_leading(self.first_productLabel.leading, 0.0).ddq_top(self.first_productLabel.bottom, self.first_productLabel.y).ddq_size(CGSizeMake(self.contentView.width - self.first_lineView.x, 1.0));

    autoLayout(self.first_priceLabel).ddq_leading(self.first_lineView.leading, 0.0).ddq_top(self.first_lineView.bottom, self.first_productLabel.y).ddq_fitSize();

    autoLayout(self.first_openButton).ddq_trailing(self.first_contentView.trailing, 20.0 * self.cell_widthRate).ddq_centerY(self.first_priceLabel.centerY, 0.0).ddq_size(CGSizeMake(75.0 * self.cell_widthRate, 25.0 * self.cell_widthRate));
    self.first_openButton.layer.cornerRadius = self.first_openButton.height * 0.5;

    autoLayout(self.first_contentView).ddq_height(self.first_openButton.frameMaxY + self.first_productLabel.y);
    
    [super cell_updateContentSubviewsFrame];

}

- (UIView *)cell_layoutBottomControl {
    
    return self.first_contentView;
    
}

/**
 点击立即开通
 */
- (void)member_didSelectOpen {
    
    
}

@end
