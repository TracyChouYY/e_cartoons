//
//  DDQCell.h
//
//  Copyright © 2018年 WICEP. All rights reserved.

#import <DDQProjectFoundation/DDQFoundationHeader.h>

#import "UIView+DDQAdditionalContent.h"

#import "DDQButton.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDQCellContentLayoutDelegate <NSObject>

@optional
/**
 cell布局后最下面一个的视图
 */
- (UIView *)cell_layoutBottomControl;

/**
 cell布局的底部边距
 */
- (CGFloat)cell_bottomMargin;

@end

/**
 工程自定义cell基类
 */
@interface DDQCell : DDQBaseCell <DDQCellContentLayoutDelegate>

/**
 设置下cell的宽度
 */
@property (nonatomic, assign) CGFloat cell_contentViewWidth;//default value's current device width

/**
 默认的水平边距
 */
@property (nonatomic, assign) DDQViewVHMargin cell_defaultControlMargin;

/**
 默认的控件间距
 */
@property (nonatomic, assign) DDQViewVHSpace cell_defaultControlSpace;

- (NSString *)cell_exchangeWithStartTime:(NSString *)start endTime:(NSString *)end;

@end

NS_ASSUME_NONNULL_END
