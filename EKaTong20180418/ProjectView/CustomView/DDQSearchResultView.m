//
//  DDQSearchResultView.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/6.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQSearchResultView.h"

@interface DDQSearchResultView ()

@property (nonatomic, strong) UILabel *result_titleLabel;
@property (nonatomic, strong) NSMutableArray<UIButton *> *result_buttons;
@property (nonatomic, assign) UIEdgeInsets result_insets;
@property (nonatomic, strong) UIButton *result_clearButton;

@end

@implementation DDQSearchResultView

- (instancetype)initResultViewWithData:(NSArray<NSString *> *)data {
    
    self = [super initViewWithFrame:CGRectZero];
    
    self.result_buttons = [NSMutableArray array];
    self.result_insets = UIEdgeInsetsMake(25.0 * self.view_widthRate, self.view_defaultControlMargin.horMargin, 0.0, self.view_defaultControlMargin.horMargin);
    self.result_dataSource = data;
    
    return self;
    
}

- (instancetype)initViewWithFrame:(CGRect)frame {
    
    return [self initResultViewWithData:nil];
    
}

//+ (BOOL)view_needUpdateSubviewFrameWhenLayoutSubviews {
//
//    return YES;
//
//}

- (void)view_subviewsConfig {
    
    [super view_subviewsConfig];
    
    self.result_titleLabel = [UILabel labelChangeText:@"热门搜索" font:DDQFont(15.0) textColor:kSetColor(117.0, 117.0, 117.0, 1.0)];
    
    self.result_clearButton = [UIButton buttonChangeFont:DDQFont(15.0) titleColor:kSetColor(153.0, 153.0, 153.0, 1.0) image:nil backgroundImage:nil title:@"清空" attributeTitle:nil target:self sel:@selector(result_didSelectClear)];
    
    [self view_configSubviews:@[self.result_titleLabel, self.result_clearButton]];
    
    self.backgroundColor = [UIColor whiteColor];
    
}

- (void)view_updateContentSubviewsFrame {
    
    [super view_updateContentSubviewsFrame];
    
    autoLayout(self.result_titleLabel).ddq_leading(self.leading, self.result_insets.left).ddq_top(self.top, self.view_defaultControlMargin.verMargin).ddq_fitSize();
    
    autoLayout(self.result_clearButton).ddq_trailing(self.trailing, self.result_insets.right).ddq_centerY(self.result_titleLabel.centerY, 0.0).ddq_fitSize();
        
    NSInteger spaceNumber = 0;
    CGFloat totalWidth = 0.0;
    CGFloat buttonY = self.result_titleLabel.frameMaxY + 20.0;
    for (NSInteger index = 0; index < self.result_buttons.count; index++) {
        
        UIButton *button = self.result_buttons[index];
        [button sizeToFit];
        CGFloat buttonW = (button.width + 6.0 > self.width - self.result_insets.left - self.result_insets.right) ? self.width - self.result_insets.left - self.result_insets.right : button.width + 6.0;
        
        if (totalWidth + spaceNumber * 10.0 + self.result_insets.left + buttonW > self.result_clearButton.frameMaxX) {
            
            buttonY += 30.0;
            buttonY += 10.0;
            spaceNumber = 0;
            totalWidth = 0.0;
            
        }
        button.frame = CGRectMake(self.result_insets.left + 10.0 * spaceNumber + totalWidth, buttonY, buttonW, 30.0);
        spaceNumber++;
        totalWidth += button.width;
        
    }
//    UIButton *tempButton = [[UIButton alloc] initWithFrame:CGRectMake(self.result_insets.left, self.result_titleLabel.frameMaxY + self.result_insets.top, 0.0, 0.0)];
//    CGFloat maxWidth = self.width - self.result_insets.left - self.result_insets.right;
//    BOOL returnLine = YES;
//    for (UIButton *button in self.result_buttons) {
//
//        CGSize newSize = [button sizeThatFits:CGSizeMake(maxWidth, 27.0)];
////        CGSize newSize = CGSizeMake((button.width > maxWidth) ? maxWidth : button.width + 8.0, 27.0);
//
//        if (tempButton.frameMaxX + newSize.width >= self.width - self.result_insets.right) {
//
//            tempButton.frame = CGRectMake(self.result_insets.left, tempButton.frameMaxY + 15.0 * self.view_widthRate, 0.0, 0.0);
//            returnLine = YES;
//
//        }
//
//        if (returnLine) {
//
//            button.frame = CGRectMake(tempButton.frameMaxX, tempButton.frameMaxY, newSize.width, newSize.height);
//            returnLine = NO;
//            NSLog(@"22222 %@", button);
//
//        } else {
//
//            button.frame = CGRectMake(tempButton.frameMaxX + 10.0 * self.view_widthRate, tempButton.y, newSize.width, newSize.height);
//
//        }
//        tempButton = button;
//
//    }
}

- (void)setResult_dataSource:(NSArray<NSString *> *)result_dataSource {
    
    _result_dataSource = result_dataSource;
    
    if (self.result_buttons.count > 0) {
        
        for (UIButton *button in self.result_buttons) {
            
            [button removeFromSuperview];
        
        }
        
        [self.result_buttons removeAllObjects];
    }
    
    UIColor *grayColor = kSetColor(117.0, 117.0, 117.0, 1.0);
    for (NSInteger index = 0; index < _result_dataSource.count; index++) {
        
        UIButton *button = [UIButton buttonChangeFont:DDQFont(14.0) titleColor:grayColor image:nil backgroundImage:nil title:result_dataSource[index] attributeTitle:nil target:self sel:@selector(result_didSelectSearchTextWithButton:)];
        button.tag = index;
        [button view_hanlderLayerWithRadius:3.0 borderWidth:1.0 borderColor:grayColor];
        [self addSubview:button];
        [self.result_buttons addObject:button];
        
    }
    [self view_updateContentSubviewsFrame];
    
}

/**
 点击搜索的词汇
 */
- (void)result_didSelectSearchTextWithButton:(UIButton *)button {
    
    
    
}

/**
 点击清空
 */
- (void)result_didSelectClear {
    
    
}
@end
