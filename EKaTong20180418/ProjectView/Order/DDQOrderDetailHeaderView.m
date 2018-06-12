//
//  DDQOrderDetailHeaderView.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/1.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQOrderDetailHeaderView.h"

#import "UIView+DDQAdditionalContent.h"

@interface DDQOrderDetailHeaderView ()

@property (nonatomic, strong) UILabel *header_titleLabel;
@property (nonatomic, strong) UIView *header_verLine;
@property (nonatomic, strong) UIView *header_separator;

@end

@implementation DDQOrderDetailHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    self.header_titleLabel = [UILabel labelChangeText:@"" font:DDQFont(14.0) textColor:self.defaultBlackColor];
    
    self.header_verLine = [UIView viewChangeBackgroundColor:self.defaultBlueColor];
    
    self.header_separator = [UIView viewChangeBackgroundColor:self.defaultSeparatorColor];
    
    [self.contentView view_configSubviews:@[self.header_titleLabel, self.header_verLine, self.header_separator]];
    
    return self;
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.header_titleLabel sizeToFit];
    
    DDQRateSet rateSet = [UIView view_getCurrentDeviceRateWithVersion:DDQFoundationRateDevice_iPhone6];
    autoLayout(self.header_verLine).ddq_leading(self.contentView.leading, 15.0 * rateSet.widthRate).ddq_top(self.contentView.top, 12.0 * rateSet.widthRate).ddq_size(CGSizeMake(1.0, self.header_titleLabel.height));
    
    autoLayout(self.header_titleLabel).ddq_leading(self.header_verLine.trailing, 5.0).ddq_centerY(self.header_verLine.centerY, 0.0).ddq_fitSize();
    
    autoLayout(self.header_separator).ddq_leading(self.header_verLine.leading, 0.0).ddq_bottom(self.contentView.bottom, 0.0).ddq_size(CGSizeMake(self.contentView.width - self.header_separator.x, 1.0));
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
}

- (void)setHeader_title:(NSString *)header_title {
    
    _header_title = header_title;
    
    self.header_titleLabel.text = _header_title;
    
}


@end
