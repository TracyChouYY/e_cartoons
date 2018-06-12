//
//  DDQLabelItem.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/23.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQLabelItem.h"

@interface DDQLabelItem () {
    
    NSString *_title;
    NSString *_subTitle;
    
}

@property (nonatomic, assign) DDQLabelItemStyle itemStyle;
@property (nonatomic, strong, readwrite) UILabel *item_titleLabel;
@property (nonatomic, strong, readwrite) UILabel *item_subTitleLabel;

@end

@implementation DDQLabelItem

- (void)sizeToFit {
    
    [super sizeToFit];
    
//    CGRect frame = self.frame;
//    if (self.itemStyle == DDQLabelItemStyleUD) {
//
//        CGFloat maxWidth = (self.item_titleLabel.width > self.item_subTitleLabel.width) ? self.item_titleLabel.width : self.item_subTitleLabel.width;
//        frame.size = CGSizeMake(maxWidth, self.item_subTitleLabel.frameMaxY);
//
//    } else {
//
//        CGFloat maxHeight = (self.item_titleLabel.height > self.item_subTitleLabel.height) ? self.item_titleLabel.height : self.item_subTitleLabel.height;
//        frame.size = CGSizeMake(self.item_subTitleLabel.frameMaxX, maxHeight);
//
//    }
//    self.frame = frame;
    
}

- (instancetype)initLableItemWithStyle:(DDQLabelItemStyle)style title:(NSString *)title subTitle:(NSString *)subTitle {
    
    _title = title;
    _subTitle = subTitle;
    
    self = [super initViewWithFrame:CGRectZero];
    
    self.itemStyle = style;
    
    self.item_labelSpace = 10.0 * self.view_widthRate;

    return self;
    
}

- (instancetype)initViewWithFrame:(CGRect)frame {
    
    return [self initLableItemWithStyle:DDQLabelItemStyleUD title:@"" subTitle:@""];
    
}

- (void)view_subviewsConfig {
    
    [super view_subviewsConfig];
    
    self.item_titleLabel = [UILabel labelChangeText:_title font:DDQFont(12.0) textColor:kSetColor(95.0, 95.0, 95.0, 1.0)];
    
    self.item_subTitleLabel = [UILabel labelChangeText:_subTitle font:DDQFont(14.0) textColor:self.item_titleLabel.textColor];
    
    [self view_configSubviews:@[self.item_subTitleLabel, self.item_titleLabel]];
    
}

- (void)view_updateContentSubviewsFrame {
    
    CGSize estimateSize = CGSizeMake(self.item_width, 15.0);
    if (self.itemStyle == DDQLabelItemStyleUD) {
        
        autoLayout(self.item_titleLabel).ddq_centerX(self.centerX, 0.0).ddq_top(self.top, 0.0).ddq_estimateSize(estimateSize);
        
        autoLayout(self.item_subTitleLabel).ddq_centerX(self.centerX, 0.0).ddq_top(self.item_titleLabel.bottom, self.item_labelSpace).ddq_estimateSize(estimateSize);
        
    } else {
    
        autoLayout(self.item_titleLabel).ddq_leading(self.leading, 0.0).ddq_top(self.top, 0.0).ddq_estimateSize(estimateSize);
        
        autoLayout(self.item_subTitleLabel).ddq_leading(self.item_titleLabel.trailing, self.item_labelSpace).ddq_centerY(self.item_titleLabel.centerY, 0.0).ddq_estimateSize(estimateSize);
        
    }
    
    [super view_updateContentSubviewsFrame];
    
}

- (CGFloat)item_estimateHeight {
    
    return (self.item_titleLabel.frameMaxY > self.item_subTitleLabel.frameMaxY) ? self.item_titleLabel.frameMaxY : self.item_subTitleLabel.frameMaxY;
    
}

@end
