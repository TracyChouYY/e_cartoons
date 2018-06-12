//
//  DDQButton.m
//
//  Copyright © 2018年 WICEP. All rights reserved.


#import "DDQButton.h"

#import <DDQProjectFoundation/UIView+DDQSimplyGetViewProperty.h>

@interface DDQButton ()

@property (nonatomic, assign) DDQButtonStyle style;

@end

@implementation DDQButton

- (instancetype)initButtonWithStyle:(DDQButtonStyle)style {
    
    self = [super initWithFrame:CGRectZero];
    
    self.style = style;
    
    self.control_space = 0.0;
    
    return self;
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    return [self initButtonWithStyle:DDQButtonStyleLeftImageView];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    return [self initButtonWithStyle:DDQButtonStyleLeftImageView];
    
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGRect titleRect = [super titleRectForContentRect:contentRect];
    CGRect imageRect = [super imageRectForContentRect:contentRect];

    //中心点为默认起始点
    CGFloat newX = CGRectGetMidX(contentRect) - CGRectGetWidth(titleRect) * 0.5;
    CGFloat newY = CGRectGetMidY(contentRect) - CGRectGetHeight(titleRect) * 0.5;
    if (self.style == DDQButtonStyleLeftImageView) {
        
        newX = CGRectGetWidth(imageRect) + self.control_space;
            
    } else if (self.style == DDQButtonStyleRightImageView) {
        
        newX = CGRectGetWidth(contentRect) - CGRectGetWidth(imageRect) - CGRectGetWidth(titleRect) - self.control_space;

    } else if (self.style == DDQButtonStyleTopImageView) {
        
        newY = CGRectGetHeight(imageRect) + self.control_space;
        
    } else if (self.style == DDQButtonStyleBottomImageView) {
        
        newY = CGRectGetHeight(contentRect) - CGRectGetHeight(titleRect);
        
    }
    titleRect.origin = CGPointMake(newX, newY);
    return titleRect;
    
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    CGRect imageRect = [super imageRectForContentRect:contentRect];
    CGRect titleRect = [super titleRectForContentRect:contentRect];

    //中心点为默认起始点
    CGFloat newX = CGRectGetMidX(contentRect) - CGRectGetWidth(imageRect) * 0.5;
    CGFloat newY = CGRectGetMidY(contentRect) - CGRectGetHeight(imageRect) * 0.5;
    if (self.style == DDQButtonStyleLeftImageView) {
        
        newX = CGRectGetMinX(contentRect);
            
    } else if (self.style == DDQButtonStyleRightImageView) {
        
        newX = CGRectGetWidth(contentRect) - CGRectGetWidth(imageRect);
        
    } else if (self.style == DDQButtonStyleTopImageView) {
        
        newY = CGRectGetMinY(contentRect);
        
    } else if (self.style == DDQButtonStyleBottomImageView) {
        
        newY = CGRectGetHeight(contentRect) - CGRectGetHeight(titleRect) - self.control_space - CGRectGetHeight(imageRect);
        
    }
    imageRect.origin = CGPointMake(newX, newY);
    return imageRect;
    
}

- (void)sizeToFit {
    
    [super sizeToFit];
    
    CGRect buttonFrame = self.frame;
    
    CGRect titleRect = [self titleRectForContentRect:self.frame];
    CGRect imageRect = [self imageRectForContentRect:self.frame];

    if (self.style == DDQButtonStyleLeftImageView) {
        
        buttonFrame.size.width = CGRectGetWidth(titleRect) + CGRectGetWidth(imageRect) + self.control_space;
        
    } else if (self.style == DDQButtonStyleRightImageView) {
        
        buttonFrame.size.width = CGRectGetWidth(titleRect) + CGRectGetWidth(imageRect) + self.control_space;
        
    } else if (self.style == DDQButtonStyleTopImageView) {
        
        buttonFrame.size.height = CGRectGetHeight(titleRect) + CGRectGetHeight(imageRect) + self.control_space;
        
    } else if (self.style == DDQButtonStyleBottomImageView) {
        
        buttonFrame.size.height = CGRectGetHeight(titleRect) + CGRectGetHeight(imageRect) + self.control_space;
        
    }
    self.frame = buttonFrame;
    
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    
    [super setTitle:title forState:state];
    
    [self.titleLabel setNeedsLayout];
    
}

@end
