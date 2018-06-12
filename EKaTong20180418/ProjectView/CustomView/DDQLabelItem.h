//
//  DDQLabelItem.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/23.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQLabelItemStyle) {
    
    DDQLabelItemStyleUD,        //up down，上下结构
    DDQLabelItemStyleLR,        //left right，左右结构
    
};

/**
 用来显示两个label结构的样式。左右和上下结构
 */
@interface DDQLabelItem : DDQView

- (instancetype)initLableItemWithStyle:(DDQLabelItemStyle)style title:(nullable NSString *)title subTitle:(nullable NSString *)subTitle DDQ_DESIGNATED_INITIALIZER;

@property (nonatomic, assign) CGFloat item_width;
@property (nonatomic, assign, readonly) CGFloat item_estimateHeight;

@property (nonatomic, strong, readonly) UILabel *item_titleLabel;
@property (nonatomic, strong, readonly) UILabel *item_subTitleLabel;

/**
 两个label之间的间距
 */
@property (nonatomic, assign) CGFloat item_labelSpace;//default 10.0

@end

NS_ASSUME_NONNULL_END

