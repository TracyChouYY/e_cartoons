//
//  DDQOrderOperationBar.m
//
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQOrderOperationBar.h"

@interface DDQOrderOperationBar ()

@property (nonatomic, strong) NSMutableArray<UIButton *> *bar_buttons;
@property (nonatomic, assign) CGFloat bar_buttonH;
@property (nonatomic, assign) DDQViewVHSpace bar_space;

@end

@implementation DDQOrderOperationBar

- (instancetype)initViewWithFrame:(CGRect)frame {
    
    self = [super initViewWithFrame:frame];
    if (!self) return nil;
    
    self.bar_buttons = [NSMutableArray array];
    self.bar_buttonWidth = 70.0 * self.view_rateSet.widthRate;
    
    DDQViewVHMargin margin = {0.0, 12.0 * self.view_rateSet.widthRate};
    self.bar_margin = margin;
    return self;
    
}

- (void)view_updateContentSubviewsFrame {
    
    [super view_updateContentSubviewsFrame];
    
    CGFloat buttonW = self.bar_buttonWidth;
    CGFloat buttonX = self.width - self.bar_margin.horMargin - buttonW;
    CGFloat buttonH = 28.0;
    for (NSInteger index = 0; index < self.bar_buttons.count; index++) {
        
        UIButton *button = self.bar_buttons[index];
        button.frame = CGRectMake(buttonX, self.boundsMidY - buttonH * 0.5, buttonW, buttonH);
        buttonX = button.x - self.bar_space.horSpace - buttonW;
        
        if (!button.view_drawLayer) {
            
            [button view_hanlderLayerWithRadius:3.0 borderWidth:1.0 borderColor:[button titleColorForState:UIControlStateNormal]];
            
        }
    }
}

- (void)setBar_functionTextContainer:(NSArray<NSString *> *)bar_functionTextContainer {
    
    _bar_functionTextContainer = bar_functionTextContainer;
    
    //是否已经布局过按钮
    if (self.bar_buttons.count > 0) {//布局过按钮了
        
        for (UIButton *button in self.bar_buttons) {
            
            [button removeFromSuperview];
            
        }
        [self.bar_buttons removeAllObjects];
    }
    
    for (NSInteger count = 0; count < _bar_functionTextContainer.count; count++) {
        
        UIColor *titleColor = (count == 0) ? self.defaultOrangeColor : kSetColor(51.0, 51.0, 51.0, 1.0);
        UIButton *button = [UIButton buttonChangeFont:[UIFont systemFontOfSize:12.0] titleColor:titleColor image:nil backgroundImage:nil title:_bar_functionTextContainer[count] attributeTitle:nil target:self sel:@selector(function_didSelectWithButton:)];
        [self addSubview:button];
        button.tag = count;
        [self.bar_buttons addObject:button];
    }
    
    DDQViewVHSpace space = {0.0, 12.0 * self.view_rateSet.widthRate};
    self.bar_space = space;
    [self view_updateContentSubviewsFrame];
    
}

- (void)setBar_space:(DDQViewVHSpace)bar_space {
    
    _bar_space = bar_space;
    [self view_updateContentSubviewsFrame];
    
}

- (void)setBar_margin:(DDQViewVHMargin)bar_margin {
    
    _bar_margin = bar_margin;
    [self view_updateContentSubviewsFrame];
    
}

/**
 点击了功能按钮
 */
- (void)function_didSelectWithButton:(UIButton *)button {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(operation_didSelectWithType:)]) {
        
        DDQOrderOperationType type = DDQOrderOperationTypeEvaluate;
        NSInteger tag = button.tag;
        int state = self.bar_state.intValue;
        //点击的按钮判断
        if (tag == 0) {//第一个按钮
            
            //订单状态判断
            if (state == 2) {
                
                
            } else if (state == 3) {//订单完成
                
                
            }
        } else if (tag == 1) {//第二个按钮
            
            if (state == 2) {//待收货
                
                
            } else if (state == 3) {
                
                
            }
        }
        [self.delegate operation_didSelectWithType:type];
        
    }
}

@end
