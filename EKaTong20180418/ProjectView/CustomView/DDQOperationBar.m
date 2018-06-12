//
//  DDQOperationBar.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/27.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQOperationBar.h"

@interface DDQOperationBar ()

@property (nonatomic, copy) NSArray *operationData;
@property (nonatomic, strong) NSMutableArray<UIButton *> *operation_buttons;
@property (nonatomic, strong) UIButton *operation_tempButton;

@property (nonatomic, strong) UIView *operation_underLine;

@end

@implementation DDQOperationBar

@synthesize bar_index = _bar_index;

- (instancetype)initBarWithContainer:(NSArray *)container {
    
    self.operationData = container;
    self.operation_buttons = [NSMutableArray arrayWithCapacity:container.count];
    self.bar_selectedColor = self.defaultBlueColor;
    self.bar_normalColor = kSetColor(102.0, 102.0, 102.0, 1.0);

    self = [super initViewWithFrame:CGRectZero];
    
    self.bar_underLineFill = YES;
    self.bar_index = 0;
    
    return self;
    
}

- (instancetype)initViewWithFrame:(CGRect)frame {
    
    return [self initBarWithContainer:[NSArray array]];
    
}

- (void)view_subviewsConfig {
    
    [super view_subviewsConfig];
    
    for (id object in self.operationData) {
        
        if ([[object class] isSubclassOfClass:[NSString class]]) {
            
            NSString *text = object;
            UIButton *button = [UIButton buttonChangeFont:DDQFont(13.0) titleColor:self.bar_normalColor image:nil backgroundImage:nil title:text attributeTitle:nil target:self sel:@selector(bar_didSelectOperationButton:)];
            [self.operation_buttons addObject:button];
            [self addSubview:button];
            button.tag = [self.operationData indexOfObject:object];
            
        } else {
            
            NSException *exc = [NSException exceptionWithName:NSInvalidArgumentException reason:@"数据源类型不是字符串" userInfo:nil];
            [exc raise];
            
        }
    }
    
    self.operation_underLine = [UIView viewChangeBackgroundColor:self.bar_selectedColor];
    [self addSubview:self.operation_underLine];
    
    self.backgroundColor = [UIColor whiteColor];
    
}

- (void)view_updateContentSubviewsFrame {
    
    [super view_updateContentSubviewsFrame];
    
    UIButton *tempButton = [[UIButton alloc] initWithFrame:CGRectZero];
    CGFloat buttonW = self.width / self.operation_buttons.count;;
    
    for (UIButton *button in self.operation_buttons) {
        
        autoLayout(button).ddq_leading(tempButton.trailing, 0.0).ddq_top(self.top, 0.0).ddq_size(CGSizeMake(buttonW, self.height));
        tempButton = button;
        
    }
    
    UIButton *selectButton = self.operation_buttons[self.bar_index];
    CGFloat underLineWidth = selectButton.width;
    if (!self.bar_underLineFill) {
        
        underLineWidth = [selectButton.titleLabel sizeThatFits:selectButton.size].width;
        
    }
    autoLayout(self.operation_underLine).ddq_bottom(selectButton.bottom, 0.0).ddq_centerX(selectButton.centerX, 0.0).ddq_size(CGSizeMake(underLineWidth, 1.0));
    
}

/**
 点击对应button
 */
- (void)bar_didSelectOperationButton:(UIButton *)button {
    
    if (self.operation_tempButton == button) return;
    
    [button setTitleColor:self.bar_selectedColor forState:UIControlStateNormal];
    [self.operation_tempButton setTitleColor:self.bar_normalColor forState:UIControlStateNormal];
    _bar_index = button.tag;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        autoLayout(self.operation_underLine).ddq_bottom(button.bottom, 0.0).ddq_leading(button.leading, 0.0).ddq_size(CGSizeMake(button.width, 1.0));
        
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(bar_didSelectWithIndex:lastIndex:)]) {
        
        [self.delegate bar_didSelectWithIndex:button.tag lastIndex:self.operation_tempButton.tag];
        
    }
    
    self.operation_tempButton = button;

}

- (void)setBar_index:(NSInteger)bar_index {
    
    _bar_index = bar_index;
    
    [self bar_didSelectOperationButton:self.operation_buttons[_bar_index]];
    
}

- (NSInteger)bar_index {
    
    return _bar_index;
    
}

- (NSInteger)bar_lastIndex {
    
    return self.operation_tempButton.tag;
    
}

@end
