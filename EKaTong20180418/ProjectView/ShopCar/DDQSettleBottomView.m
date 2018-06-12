//
//  DDQSettleBottomView.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/3.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQSettleBottomView.h"

@interface DDQSettleBottomView ()

@property (nonatomic, copy) NSString *bottom_title;
@property (nonatomic, strong) UIButton *bottom_sureButton;
@property (nonatomic, strong) UILabel *bottom_priceLabel;

@end

@implementation DDQSettleBottomView

- (instancetype)initBottomViewWithButtonTitle:(NSString *)title {
    
    self.bottom_title = title;
    self = [super initViewWithFrame:CGRectZero];
    
    self.bottom_number = 1;
    
    return self;
    
}

- (instancetype)initViewWithFrame:(CGRect)frame {
    
    return [self initBottomViewWithButtonTitle:@""];
    
}


- (void)view_subviewsConfig {
    
    [super view_subviewsConfig];
    
    self.bottom_priceLabel = [UILabel labelChangeText:@"" font:DDQFont(15.0) textColor:self.defaultBlackColor];
    self.bottom_priceLabel.attributedText = [self bottom_handlerAttributedWithPrice:0];
    
    self.bottom_sureButton = [UIButton buttonChangeFont:DDQFont(16.0) titleColor:[UIColor whiteColor] image:nil backgroundImage:nil title:self.bottom_title attributeTitle:nil target:self sel:@selector(bottom_didSelectSure)];
    self.bottom_sureButton.backgroundColor = self.defaultOrangeColor;

    [self view_configSubviews:@[self.bottom_priceLabel, self.bottom_sureButton]];
    
    self.backgroundColor = [UIColor whiteColor];
    
}

- (void)view_updateContentSubviewsFrame {
    
    [super view_updateContentSubviewsFrame];
    
    autoLayout(self.bottom_sureButton).ddq_trailing(self.trailing, 0.0).ddq_top(self.top, 0.0).ddq_size(CGSizeMake(110.0 * self.view_widthRate, self.height));
    
    autoLayout(self.bottom_priceLabel).ddq_leading(self.leading, self.view_defaultControlMargin.horMargin).ddq_centerY(self.centerY, 0.0).ddq_estimateSize(CGSizeMake(self.width - self.bottom_sureButton.width - 5.0 - self.bottom_priceLabel.x, 23.0));
    
}

/**
 点击确认按钮
 */
- (void)bottom_didSelectSure {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(settle_didSelectSureWithView:)]) {
        
        [self.delegate settle_didSelectSureWithView:self];
        
    }
}

/**
 处理价格的属性字符串
 */
- (NSAttributedString *)bottom_handlerAttributedWithPrice:(float)price {
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"合计：￥%.2f", price] attributes:@{NSFontAttributeName:DDQFont(15.0), NSForegroundColorAttributeName:self.defaultOrangeColor}];
    [attributeString addAttribute:NSForegroundColorAttributeName value:self.defaultBlackColor range:[attributeString.string rangeOfString:@"合计："]];
    NSRange range = [attributeString.string rangeOfString:@"合计：￥"];
    [attributeString addAttribute:NSFontAttributeName value:DDQFont(20.0) range:NSMakeRange(range.length + range.location, attributeString.string.length - (range.length + range.location))];
    return attributeString.copy;
    
}

- (void)setBottom_totalPrice:(float)bottom_totalPrice {
    
    _bottom_totalPrice = bottom_totalPrice;
    
    self.bottom_priceLabel.attributedText = [self bottom_handlerAttributedWithPrice:_bottom_totalPrice];
    [self view_updateContentSubviewsFrame];
    
}

@end
