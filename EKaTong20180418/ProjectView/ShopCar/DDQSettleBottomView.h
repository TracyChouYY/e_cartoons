//
//  DDQSettleBottomView.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/3.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDQSettleBottomViewDelegate;
/**
 支付页 - 显示底部的视图
 */
@interface DDQSettleBottomView : DDQView

/**
 初始化方法

 @param title 显示功能按钮的文字提示
 */
- (instancetype)initBottomViewWithButtonTitle:(nullable NSString *)title DDQ_DESIGNATED_INITIALIZER;

@property (nonatomic, weak, nullable) id <DDQSettleBottomViewDelegate> delegate;

/**
 单价。设置这个是为了方便取值
 */
@property (nonatomic, assign) float bottom_price;

/**
 个数。方便取值
 */
@property (nonatomic, assign) NSInteger bottom_number;//default 1

/**
 总价
 */
@property (nonatomic, assign) float bottom_totalPrice;

@end

@protocol DDQSettleBottomViewDelegate <NSObject>

@optional

/**
 点击底部的提交订单
 */
- (void)settle_didSelectSureWithView:(DDQSettleBottomView *)view;

@end

NS_ASSUME_NONNULL_END

