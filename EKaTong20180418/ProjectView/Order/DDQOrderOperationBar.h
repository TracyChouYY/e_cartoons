//
//  DDQOrderOperationBar.h
//
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQOrderOperationType) {
    
    DDQOrderOperationTypeUnkown,        //操作未知
    DDQOrderOperationTypeCancel,        //取消订单
    DDQOrderOperationTypeAgain,         //再来一单
    DDQOrderOperationTypeDelete,        //删除订单
    DDQOrderOperationTypeEvaluate,      //去评价
    DDQOrderOperationTypeToPay,         //去支付
};
@protocol DDQOrderOperationBarDelegate;

/**
 订单列表、详情中 - 显示用户可以进行的操作
 */
@interface DDQOrderOperationBar : DDQView

/** 当前Bar对应的订单状态 */
@property (nonatomic, copy) NSString *bar_state;

/** 订单状态对应的功能名称 */
@property (nonatomic, copy) NSArray<NSString *> *bar_functionTextContainer;

/** Bar上按钮的左右边距 */
@property (nonatomic, assign) DDQViewVHMargin bar_margin;

/** Bar上按钮的宽度 */
@property (nonatomic, assign) CGFloat bar_buttonWidth;//default 70.0

@property (nonatomic, weak, nullable) id <DDQOrderOperationBarDelegate> delegate;

@end

@protocol DDQOrderOperationBarDelegate <NSObject>

@optional
/** 点击按钮对应的处理类型 */
- (void)operation_didSelectWithType:(DDQOrderOperationType)type;

@end

NS_ASSUME_NONNULL_END

