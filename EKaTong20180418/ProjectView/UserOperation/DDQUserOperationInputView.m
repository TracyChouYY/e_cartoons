
//
//  DDQUserOperationInputView.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/18.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQUserOperationInputView.h"

@interface DDQUserOperationInputView ()

@property (nonatomic, strong) UIView *input_underLine;
@property (nonatomic, strong, readwrite) UITextField *input_field;
@property (nonatomic, strong) UIButton *input_codeButton;
@property (nonatomic, assign) DDQUserOperationInputViewStyle input_style;

@property (nonatomic, strong) UIView *input_areaUnderline;
@property (nonatomic, strong) UIButton *input_areaButton;

@property (nonatomic, strong) NSMutableDictionary *input_placeholderAttr;

@property (nonatomic, copy) NSString *input_initPlaceholder;

@end

@implementation DDQUserOperationInputView


- (instancetype)initInputViewWithStyle:(DDQUserOperationInputViewStyle)style placeholder:(NSString *)placeholder {
    
    self.input_style = style;
    self.input_initPlaceholder = placeholder;
    
    self = [super initViewWithFrame:CGRectZero];
    
    self.input_estimateHeight = 45.0;
    self.input_placeholderAttr = [NSMutableDictionary dictionaryWithDictionary:@{NSFontAttributeName:DDQFont(14.0), NSForegroundColorAttributeName:kSetColor(199.0, 199.0, 205.0, 1.0)}];
    
    [self.input_field addObserver:self forKeyPath:@"placeholder" options:NSKeyValueObservingOptionNew context:nil];

    return self;
    
}

- (instancetype)initViewWithFrame:(CGRect)frame {
    
    return [self initInputViewWithStyle:DDQUserOperationInputViewStyleNormal placeholder:nil];
    
}

- (void)dealloc {
    
    [self.input_field removeObserver:self forKeyPath:@"placeholder"];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"placeholder"]) {
        
        NSAttributedString *changePlaceholder = [[NSAttributedString alloc] initWithString:change[NSKeyValueChangeNewKey] attributes:self.input_placeholderAttr];
        self.input_field.attributedPlaceholder = changePlaceholder;
        
    }
}

- (void)view_subviewsConfig {
    
    [super view_subviewsConfig];
    
    self.input_underLine = [UIView viewChangeBackgroundColor:kSetColor(194.0, 194.0, 194.0, 1.0)];
    
    self.input_field = [UITextField fieldChangeFont:DDQFont(15.0) textColor:[UIColor blackColor] placeholder:self.input_initPlaceholder attributePlaceholder:nil];

    NSMutableArray *subviews = [NSMutableArray arrayWithArray:@[self.input_underLine, self.input_field]];
    if (self.input_style == DDQUserOperationInputViewStyleMessageCode) {
        
        self.input_codeButton = [UIButton buttonChangeFont:DDQFont(11.0) titleColor:[UIColor whiteColor] image:nil backgroundImage:nil title:@"获取验证码" attributeTitle:nil target:self sel:@selector(input_didSelectSendMessageCodeWithButton:)];
        [subviews addObject:self.input_codeButton];
        self.input_codeButton.backgroundColor = self.defaultBlueColor;
        self.input_codeButton.layer.cornerRadius = 3.0;
        self.input_field.keyboardType = UIKeyboardTypeNumberPad;
        
    } else if (self.input_style == DDQUserOperationInputViewStylePassword) {
        
        self.input_field.secureTextEntry = YES;
        self.input_field.clearsOnBeginEditing = YES;
        
    } else if (self.input_style == DDQUserOperationInputViewStylePhone) {
        
        self.input_areaButton = [UIButton buttonChangeFont:DDQFont(14.0) titleColor:self.input_placeholderAttr[NSForegroundColorAttributeName] image:nil backgroundImage:nil title:@"+86" attributeTitle:nil target:nil sel:nil];
        self.input_areaButton.enabled = NO;
        
        self.input_areaUnderline = [UIView viewChangeBackgroundColor:self.input_underLine.backgroundColor];
        
        [subviews addObjectsFromArray:@[self.input_areaUnderline, self.input_areaButton]];
    
        self.input_field.keyboardType = UIKeyboardTypePhonePad;
        
    }
    [self view_configSubviews:subviews];
    
}

- (void)view_updateContentSubviewsFrame {
    
    [super view_updateContentSubviewsFrame];

    autoLayout(self.input_underLine).ddq_top(self.bottom, 0.0).ddq_leading(self.leading, 0.0).ddq_size(CGSizeMake(self.width, 1.0));
    
    if (self.input_style == DDQUserOperationInputViewStyleMessageCode) {
        
        [self.input_codeButton sizeToFit];
        autoLayout(self.input_codeButton).ddq_trailing(self.input_underLine.trailing, 0.0).ddq_top(self.top, 6.0).ddq_size(CGSizeMake(self.input_codeButton.width + 15.0, self.input_codeButton.height + 6.0));
        autoLayout(self.input_field).ddq_bottom(self.input_underLine.top, 0.0).ddq_leading(self.leading, 0.0).ddq_size(CGSizeMake(self.input_codeButton.x - 5.0, self.input_underLine.y));
        return;

    } else if (self.input_style == DDQUserOperationInputViewStylePhone) {
        
        autoLayout(self.input_areaButton).ddq_leading(self.leading, 0.0).ddq_top(self.top, 0.0).ddq_size(CGSizeMake(self.input_estimateHeight, self.input_estimateHeight));
        autoLayout(self.input_areaUnderline).ddq_leading(self.input_areaButton.leading, 0.0).ddq_top(self.input_areaButton.bottom, 0.0).ddq_size(CGSizeMake(self.input_areaButton.width, 1.0));
        autoLayout(self.input_underLine).ddq_leading(self.input_areaUnderline.trailing, 10.0 * self.view_widthRate).ddq_top(self.input_areaUnderline.top, 0.0).ddq_size(CGSizeMake(self.width - self.input_underLine.x, self.input_underLine.height));
        autoLayout(self.input_field).ddq_leading(self.input_underLine.leading, 0.0).ddq_bottom(self.input_underLine.top, 0.0).ddq_size(CGSizeMake(self.input_underLine.width, self.input_underLine.y));
        return;
        
    }
    autoLayout(self.input_field).ddq_bottom(self.input_underLine.top, 0.0).ddq_leading(self.leading, 0.0).ddq_size(CGSizeMake(self.input_underLine.width, self.input_underLine.y));

}

/**
 点击发送验证码
 */
- (void)input_didSelectSendMessageCodeWithButton:(UIButton *)button {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(input_didSelectSendMessageCode:)]) {
        
        [self.delegate input_didSelectSendMessageCode:^(BOOL send) {
            
            if (send) {
                
                [button button_countDownWithInterval:1.0 totalTime:60 comletion:^(BOOL finished, NSDictionary * _Nullable beginSource) {
                    
                    if (finished) {
                        
                        [button setTitle:beginSource[DDQButtonBeginTitle] forState:UIControlStateNormal];
                        
                    }
                }];
            }
        }];
    }
}

@end
