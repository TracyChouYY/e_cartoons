//
//  UIView+DDQAdditionalContent.m
//
//  Copyright © 2018年 WICEP. All rights reserved.

#import "UIView+DDQAdditionalContent.h"

@implementation UIView (DDQAdditionalContent)

- (DDQAutoLayout *)auto_layout {
    
    if (!self.superview) {
        
        NSException *exception = [NSException exceptionWithName:@"父视图错误" reason:[NSString stringWithFormat:@"%@的父视图为空", self] userInfo:nil];
        [exception raise];
        
    }
    return [[DDQAutoLayout alloc] initLayoutWithView:self];
    
}

- (UIColor *)defaultSeparatorColor {
    
    return kSetColor(229.0, 229.0, 229.0, 1.0);
    
}

- (UIColor *)defaultGrayColor {
    
    return kSetColor(153.0, 153.0, 153.0, 1.0);
    
}

- (UIColor *)defaultOrangeColor {
    
    return kSetColor(255.0, 98.0, 48.0, 1.0);
    
}

- (UIColor *)defaultBlueColor {
    
    return kSetColor(27.0, 136.0, 238.0, 1.0);
    
}

- (UIColor *)defaultCellTextColor {
    
    
    return kSetColor(102.0, 102.0, 102.0, 1.0);
    
}

- (UIColor *)defaultViewBackgroundColor {
    
    return kSetColor(247.0, 247.0, 247.0, 1.0);
    
}

- (UIColor *)defaultBlackColor {
    
    return kSetColor(51.0, 51.0, 51.0, 1.0);
    
}

- (UIColor *)default_password_buttonTitleColor {
    
    return kSetColor(181.0, 181.0, 181.0, 1.0);

}

- (UIColor *)default_password_buttonBackgroundColor {
    
    return kSetColor(239.0, 239.0, 239.0, 1.0);
    
}

- (UIFont *)defaultFieldFont {
    
    return DDQFont(13.0);
    
}

- (UIFont *)defaultButtonFont {
    
    return DDQFont(15.0);
    
}

- (NSAttributedString *)setAttributeStringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color {
    
    return [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:color}];
    
}

+ (DDQButton *)ddq_customButtonWithStyle:(DDQButtonStyle)style fontSize:(CGFloat)fSize title:(NSString *)title image:(UIImage *)image titleColor:(UIColor *)tColor target:(id)target selector:(SEL)sel {
    
    DDQButton *button = [[DDQButton alloc] initButtonWithStyle:style];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:tColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:fSize];
    [button setImage:image forState:UIControlStateNormal];
    if (sel) {
        
        [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
        
    }
    return button;
    
}

@end
