//
//  DDQOperationBar.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/27.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDQOperationBarDelegate <NSObject>

@optional
- (void)bar_didSelectWithIndex:(NSInteger)index lastIndex:(NSInteger)lastIndex;

@end

/**
 工程里点击切换不同状态
 */
@interface DDQOperationBar : DDQView

/**
 根据数据源初始化

 @param container NSString
 */
- (instancetype)initBarWithContainer:(nullable NSArray *)container DDQ_DESIGNATED_INITIALIZER;

@property (nonatomic, weak, nullable) id <DDQOperationBarDelegate> delegate;

/**
 底部的underLine是否填满
 */
@property (nonatomic, assign) BOOL bar_underLineFill;//default YES

@property (nonatomic, strong) UIColor *bar_normalColor;
@property (nonatomic, strong) UIColor *bar_selectedColor;

@property (nonatomic, assign) NSInteger bar_index;
@property (nonatomic, assign, readonly) NSInteger bar_lastIndex;

@end

NS_ASSUME_NONNULL_END

