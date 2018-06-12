//
//  DDQEvaluateStarView.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/2.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQEvaluateStarView.h"

@interface DDQEvaluateStarView ()

@property (nonatomic, assign) NSInteger star_count;
@property (nonatomic, strong) NSMutableArray<UIButton *> *star_buttons;

@end

@implementation DDQEvaluateStarView

- (void)sizeToFit {
    
    [super sizeToFit];
    
    CGRect frame = self.frame;
    UIButton *button = self.star_buttons.firstObject;
    frame.size = CGSizeMake(button.width * self.star_buttons.count, button.height);
    self.frame = frame;
    
}

- (instancetype)initStarViewWithCount:(NSInteger)count {
    
    self.star_count = count;
    self.star_buttons = [NSMutableArray arrayWithCapacity:count];
    
    self = [super initViewWithFrame:CGRectZero];
    
    return self;
    
}

- (instancetype)initViewWithFrame:(CGRect)frame {
    
    return [self initStarViewWithCount:5];
    
}

- (void)view_subviewsConfig {
    
    [super view_subviewsConfig];
    
    for (NSInteger count = 0; count < self.star_count; count++) {
        
        UIButton *button = [UIButton buttonChangeFont:nil titleColor:nil image:kSetImage(@"star_normal") backgroundImage:nil title:nil attributeTitle:nil target:self sel:@selector(star_didSelectStarButton:)];
        button.tag = count;
        [self addSubview:button];
        [self.star_buttons addObject:button];
        
    }
}

- (void)view_updateContentSubviewsFrame {
    
    [super view_updateContentSubviewsFrame];
    
    UIButton *tempButton = [[UIButton alloc] initWithFrame:CGRectZero];
    for (UIButton *button in self.star_buttons) {
        
        [button sizeToFit];
        autoLayout(button).ddq_leading(tempButton.trailing, 0.0).ddq_top(tempButton.top, 0.0).ddq_size(CGSizeMake(button.width + 8.0, button.height));
        tempButton = button;
        
    }
}

/**
 点击了星星的视图
 */
- (void)star_didSelectStarButton:(UIButton *)button {
    
    NSInteger index = button.tag;
    for (NSInteger count = 0; count <= index; count++) {
        
        UIButton *button = self.star_buttons[count];
        [button setImage:kSetImage(@"star_selected") forState:UIControlStateNormal];
        
    }
    
    for (NSInteger count = index + 1; count <= self.star_buttons.count - 1; count++) {

        UIButton *button = self.star_buttons[count];
        [button setImage:kSetImage(@"star_normal") forState:UIControlStateNormal];

    }
}

@end
