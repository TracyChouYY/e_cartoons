//
//  DDQBaseViewController+DDQOrderHandler.h
//  WeiDuoShiGuang20171106
//
//  Created by 我叫咚咚枪 on 2017/12/28.
//  Copyright © 2017年 我叫咚咚枪. All rights reserved.
//

#import "DDQBaseViewController.h"

#import "DDQOrderCell.h"
#import "DDQOrderSubCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef BOOL(^DDQHandlerRequestCompleted)(NSArray<DDQOrderModel *> *dataSource, int code);
typedef void(^DDQHandlerOperationRequestCompleted)(NSArray<DDQOrderModel *> *dataSource, int code);

typedef NS_ENUM(NSUInteger, DDQOrderListOperationType) {
    
    DDQOrderListOperationTypeDown,      //下拉
    DDQOrderListOperationTypeUp,        //上拉
};

typedef NS_ENUM(NSUInteger, DDQOrderNotificationType) {
    
    DDQOrderNotificationTypeAll,                //全部订单控制器
    DDQOrderNotificationTypeToSend,             //待发货控制器
    DDQOrderNotificationTypeToReceive,          //待收货控制器
    DDQOrderNotificationTypeToFinished,         //已完成控制器
};

typedef NS_ENUM(NSUInteger, DDQOrderHandlerType) {
    
    DDQOrderHandlerTypeDelete,                  //删除
    DDQOrderHandlerTypeCancel,                  //取消
    DDQOrderHandlerTypeSureOrder,               //确认收货
    DDQOrderHandlerTypeCheckExpress,            //查看物流

};

typedef NSString *DDQOrderHandlerOrderDataKey;
typedef NSString *DDQOrderHandlerToPayDataKey;

/**
 集中处理订单操作
 */
@interface DDQBaseViewController (DDQOrderHandler)

/** 订单的网络请求 */
- (void)handler_requestWithPage:(int)page completed:(DDQHandlerRequestCompleted)completed;

/**
 根据订单的状态显示订单的描述
 例:1 = @“待付款”
 */
- (nullable NSString *)handler_getDescriptionWithOrderState:(NSString *)state status:(NSString *)status;

/**
 根据订单的状态显示不同的功能名称。不同工程对应的功能亦不同
 例：1 = 去支付和删除订单
 */
- (nullable NSArray<NSString *> *)handler_getFunctionWithOrderStata:(NSString *)state;

/**
 处理订单列表的上下拉刷新
 */
- (void)handler_setOrderListHeaderFooterWithDataSource:(NSMutableArray<DDQOrderModel *> *)dSource headerCompleted:(DDQHandlerOperationRequestCompleted)hCompleted footerCompleted:(DDQHandlerOperationRequestCompleted)fCompleted;

/**
 处理订单列表的TableView刷新
 @param isH 是否是下拉刷新
 @param dSource 控制器中储存Model的容器
 @param rSource 请求后的数据
 */
- (void)handler_tableViewReloadWithHeader:(BOOL)isH dataSource:(NSMutableArray<DDQOrderModel *> *)dSource requestData:(nullable NSArray<DDQOrderModel *> *)rSource;

/**
 按照公司上下刷新的流程处理数据源
 */
- (void)handler_orderOperationWithType:(DDQOrderListOperationType)type dataSource:(NSMutableArray<DDQOrderModel *> *)dSource;

/**
 对 - handler_setOrderListHeaderFooterWithHeaderCompleted:footerCompleted:的简易封装
 只需要传数据源容器即可
 */
- (void)handler_setOrderListHeaderFooterNotNeedCompletedHandleWithDataSource:(NSMutableArray<DDQOrderModel *> *)dSource;

/**
 处理每个控制器需要注册的通知
 */
- (nullable NSArray<id<NSObject>> *)handler_notificationCallBackWithType:(DDQOrderNotificationType)type dataSource:(NSMutableArray<DDQOrderModel *> *)dSource;

/**
 集中处理订单的删除、确认收货等操作
 */
- (void)handler_handleOrderWithType:(DDQOrderHandlerType)type orderData:(nullable NSDictionary<DDQOrderHandlerOrderDataKey, NSString *> *)orderData needToPay:(nullable NSDictionary<DDQOrderHandlerToPayDataKey, NSString *> *)payData completed:(nullable void(^)(void))completed;

@end

UIKIT_EXTERN DDQHandlerResultKey const DDQHandlerResultData;        //Cell的传值
UIKIT_EXTERN DDQHandlerResultKey const DDQHandlerResultDataStatus;
UIKIT_EXTERN DDQHandlerResultKey const DDQHandlerResultDataModel;

UIKIT_EXTERN NSNotificationName const DDQOrderHandlerListMakeSureNotification;          //确认订单的通知。全部、待收货，两个控制器更新数据
UIKIT_EXTERN NSNotificationName const DDQOrderHandlerListDeleteNotification;            //删除订单的通知。全部、已完成订单更新
UIKIT_EXTERN NSNotificationName const DDQOrderHandlerListCancelNotification;            //取消订单的通知。全部、待付款，两个控制器更新

//待处理的订单信息
UIKIT_EXTERN DDQOrderHandlerOrderDataKey const DDQOrderHandlerOrderCodeKey;         //订单号
UIKIT_EXTERN DDQOrderHandlerOrderDataKey const DDQOrderHandlerOrderIDKey;           //订单ID

NS_ASSUME_NONNULL_END
