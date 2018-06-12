//
//  DDQWalletFirstSectionCell.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/26.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQWalletFirstSectionCell.h"

#import "DDQLevelView.h"

@interface DDQWalletFirstSectionCell ()

@property (nonatomic, strong) UIImageView *first_imageView;
@property (nonatomic, strong) UILabel *first_nameLabel;
@property (nonatomic, strong) DDQLevelView *first_levelView;

@property (nonatomic, strong) UIView *first_contentView;
@property (nonatomic, strong) UILabel *first_titleLabel;
@property (nonatomic, strong) UILabel *first_moneyLabel;
@property (nonatomic, strong) UILabel *first_todayLabel;
@property (nonatomic, strong) DDQButton *first_detailButton;

@end

@implementation DDQWalletFirstSectionCell

- (void)cell_contentViewSubviewsConfig {
    
    [super cell_contentViewSubviewsConfig];
    
    self.first_imageView = [UIImageView imageView];
    self.first_imageView.backgroundColor = [UIColor redColor];
    
    self.first_nameLabel = [UILabel labelChangeText:@"我叫咚咚枪" font:DDQFont(18.0) textColor:self.defaultBlackColor];
    
    self.first_levelView = [[DDQLevelView alloc] initLevelViewWithStyle:DDQLevelViewStyleIron];
    
    self.first_contentView = [UIView viewChangeBackgroundColor:[UIColor whiteColor]];
    self.first_contentView.layer.shadowOffset = CGSizeMake(5.0, 5.0);
    self.first_contentView.layer.shadowRadius = 5.0;
    self.first_contentView.layer.shadowOpacity = 1.0;
    self.first_contentView.layer.shadowColor = self.defaultViewBackgroundColor.CGColor;
    
    self.first_titleLabel = [UILabel labelChangeText:@"E卡通储值余额" font:DDQFont(13.0) textColor:kSetColor(150.0, 150.0, 150.0, 1.0)];
    
    NSMutableAttributedString *moneyAttr = [[NSMutableAttributedString alloc] initWithString:@"￥ 0" attributes:@{NSFontAttributeName:DDQFont(35.0), NSForegroundColorAttributeName:self.defaultOrangeColor}];
    [moneyAttr addAttribute:NSFontAttributeName value:DDQFont(20.0) range:[moneyAttr.string rangeOfString:@"￥"]];
    self.first_moneyLabel = [UILabel labelChangeText:@"" font:DDQFont(20.0) textColor:self.defaultOrangeColor];
    self.first_moneyLabel.attributedText = moneyAttr;
    
    self.first_todayLabel = [UILabel labelChangeText:@"今日充值0元" font:DDQFont(14.0) textColor:self.defaultBlackColor];
    
    self.first_detailButton = [DDQButton ddq_customButtonWithStyle:DDQButtonStyleRightImageView fontSize:14.0 title:@"余额明细" image:kSetImage(@"wallet_detail") titleColor:kSetColor(150.0, 150.0, 150.0, 1.0) target:self selector:@selector(wallet_didSelectDetail)];
    self.first_detailButton.control_space = 5.0;
    
    [self.contentView view_configSubviews:@[self.first_imageView, self.first_nameLabel, self.first_levelView, self.first_contentView]];
    [self.first_contentView view_configSubviews:@[self.first_titleLabel, self.first_moneyLabel, self.first_todayLabel, self.first_detailButton]];
    
}

- (void)cell_updateContentSubviewsFrame {
    
    DDQViewVHMargin margin = DDQViewVHMarginMaker(15.0 * self.cell_widthRate, 15.0 * self.cell_widthRate);
    autoLayout(self.first_imageView).ddq_top(self.contentView.top, margin.verMargin).ddq_leading(self.contentView.leading, margin.horMargin).ddq_size(CGSizeMake(85.0 * self.cell_widthRate, 85.0 * self.cell_widthRate));
    self.first_imageView.layer.cornerRadius = self.first_imageView.height * 0.5;
    
    autoLayout(self.first_nameLabel).ddq_leading(self.first_imageView.trailing, 8.0).ddq_bottom(self.first_imageView.centerY, 2.5).ddq_estimateSize(CGSizeMake(self.contentView.width - self.first_imageView.frameMaxX - 8.0 - self.first_imageView.x, 20.0));
    
    autoLayout(self.first_levelView).ddq_leading(self.first_nameLabel.leading, 0.0).ddq_top(self.first_imageView.centerY, 2.5).ddq_fitSize();
    
    autoLayout(self.first_contentView).ddq_leading(self.first_imageView.leading, 0.0).ddq_top(self.first_imageView.bottom, 12.0 * self.cell_widthRate).ddq_width(self.contentView.width - self.first_contentView.x * 2.0);
    
    autoLayout(self.first_titleLabel).ddq_leading(self.first_contentView.leading, self.cell_defaultLeftMargin).ddq_top(self.first_contentView.top, 20.0 * self.cell_widthRate).ddq_fitSize();
    
    autoLayout(self.first_moneyLabel).ddq_leading(self.first_titleLabel.leading, 0.0).ddq_top(self.first_titleLabel.bottom, 12.0 * self.cell_widthRate).ddq_estimateSize(CGSizeMake(self.contentView.width - self.first_moneyLabel.x * 2.0, 40.0));
    
    autoLayout(self.first_detailButton).ddq_top(self.first_moneyLabel.bottom, 30.0 * self.cell_widthRate).ddq_trailing(self.first_contentView.trailing, self.cell_defaultLeftMargin).ddq_fitSize();

    autoLayout(self.first_todayLabel).ddq_leading(self.first_titleLabel.leading, 0.0).ddq_centerY(self.first_detailButton.centerY, 0.0).ddq_estimateSize(CGSizeMake(self.first_detailButton.x - 5.0 - self.first_moneyLabel.x, 16.0));
    
    autoLayout(self.first_contentView).ddq_height(self.first_detailButton.frameMaxY + 15.0 * self.cell_widthRate);
    
    [super cell_updateContentSubviewsFrame];

}

- (UIView *)cell_layoutBottomControl {
    
    return self.first_contentView;
    
}

- (CGFloat)cell_bottomMargin {
    
    return self.first_contentView.layer.shadowOffset.height;
    
}

/**
 点击查看余额明细
 */
- (void)wallet_didSelectDetail {
    
    
}

@end
