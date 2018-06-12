//
//  DDQContentInputView.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/3.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQContentInputView.h"

@interface DDQContentInputView ()

@property (nonatomic, strong, readwrite) UILabel *input_titleLabel;
@property (nonatomic, strong, readwrite) UITextField *input_textField;
@property (nonatomic, strong, readwrite) UIButton *input_placeholderButton;

@property (nonatomic, strong) UIImageView *input_placeholderArrowImageView;
@property (nonatomic, strong) UIView *input_separator;

@property (nonatomic, assign) DDQContentInputViewStyle input_style;
@property (nonatomic, assign) CGFloat input_fieldMargin;
@property (nonatomic, copy) NSString *input_title;
@property (nonatomic, copy) NSString *input_placeholder;

@end

@implementation DDQContentInputView

- (instancetype)initInputViewWithStyle:(DDQContentInputViewStyle)style title:(nullable NSString *)title placeholder:(nullable NSString *)placeholder {
    
    self.input_style = style;
    self.input_fieldMargin = 95.0 * self.view_widthRate;
    self.input_title = title;
    self.input_placeholder = placeholder;
    return [super initViewWithFrame:CGRectZero];
    
}

- (instancetype)initViewWithFrame:(CGRect)frame {
    
    return [self initInputViewWithStyle:DDQContentInputViewStyleNormal title:@"" placeholder:@""];
    
}

- (void)view_subviewsConfig {
    
    [super view_subviewsConfig];
    
    self.input_titleLabel = [UILabel labelChangeText:self.input_title font:DDQFont(16.0) textColor:self.defaultBlackColor];
    
    NSAttributedString *attr = nil;
    if (self.input_title.length > 0) {
        
        attr = [[NSAttributedString alloc] initWithString:self.input_placeholder attributes:@{NSFontAttributeName:DDQFont(15.0), NSForegroundColorAttributeName:kSetColor(199.0, 199.0, 205.0, 1.0)}];
        
    }
    self.input_textField = [UITextField fieldChangeFont:DDQFont(16.0) textColor:self.defaultBlackColor placeholder:nil attributePlaceholder:attr];
    if (self.input_style == DDQContentInputViewStylePlaceholder) {
        
        self.input_textField.enabled = NO;
        
    }
    
    self.input_separator = [UIView viewChangeBackgroundColor:self.defaultSeparatorColor];
    
    [self view_configSubviews:@[self.input_textField, self.input_titleLabel, self.input_separator]];
    
    if (self.input_style == DDQContentInputViewStylePlaceholder) {
        
        self.input_placeholderButton = [UIButton buttonChangeFont:nil titleColor:nil image:nil backgroundImage:nil title:nil attributeTitle:nil target:self sel:@selector(view_didSelectPlaceholder)];
        self.input_placeholderButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        self.input_placeholderArrowImageView = [UIImageView imageViewChangeImage:kSetImage(@"mine_more")];
        
        [self view_configSubviews:@[self.input_placeholderButton, self.input_placeholderArrowImageView]];
        
    }
}

- (void)view_updateContentSubviewsFrame {
    
    [super view_updateContentSubviewsFrame];
    
    autoLayout(self.input_titleLabel).ddq_leading(self.leading, self.view_defaultControlMargin.horMargin).ddq_top(self.top, self.view_defaultControlMargin.verMargin).ddq_estimateSize(CGSizeMake(self.input_fieldMargin - self.input_titleLabel.x - 3.0, 18.0));
    
    autoLayout(self.input_separator).ddq_leading(self.input_titleLabel.leading, 0.0).ddq_top(self.input_titleLabel.bottom, self.input_titleLabel.y).ddq_size(CGSizeMake(self.width - self.input_separator.x, 1.0));
    
    autoLayout(self.input_textField).ddq_leading(self.leading, self.input_fieldMargin).ddq_top(self.top, 0.0).ddq_height(self.input_separator.y);

    if (self.input_style == DDQContentInputViewStyleNormal) {
        
        autoLayout(self.input_textField).ddq_width(self.width - self.input_fieldMargin - self.input_titleLabel.x);
        
    } else {
        
        autoLayout(self.input_placeholderArrowImageView).ddq_trailing(self.trailing, self.view_defaultControlMargin.horMargin).ddq_centerY(self.input_textField.centerY, 0.0).ddq_fitSize();
        autoLayout(self.input_textField).ddq_width(self.input_placeholderArrowImageView.x - self.input_textField.x);
        
        self.input_placeholderButton.frame = self.input_textField.frame;
        
    }
}

- (CGFloat)input_estimateHeight {
    
    return self.view_defaultControlMargin.verMargin * 2.0 + 18.0;
    
}

/**
 点击了占位的按钮
 */
- (void)view_didSelectPlaceholder {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(content_didSelectPlaceholderWithView:)]) {
        
        [self.delegate content_didSelectPlaceholderWithView:self];
        
    }
}

@end
