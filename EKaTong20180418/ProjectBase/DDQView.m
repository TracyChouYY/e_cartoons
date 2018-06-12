//
//  DDQView.m
//
//  Copyright © 2018年 WICEP. All rights reserved.

#import "DDQView.h"

@implementation DDQView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    [self endEditing:YES];
    
}

+ (BOOL)view_useBoundRectLayout {
    
    return NO;
    
}

- (DDQViewVHMargin)view_defaultControlMargin {
    
    return DDQViewVHMarginMaker(15.0 * self.view_widthRate, 15.0 * self.view_widthRate);
    
}

- (DDQViewVHSpace)view_defaultControlSpace {
    
    return DDQViewVHSpaceMaker(10.0 * self.view_widthRate, 10.0 * self.view_widthRate);
    
}

- (NSString *)view_protocolText {
    
    return @"我已阅读并同意《e动科普使用协议》";
}

@end
