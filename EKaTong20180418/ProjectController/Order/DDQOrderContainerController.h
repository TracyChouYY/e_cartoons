//
//  DDQOrderContainerController.h
//
//  Copyright © 2018年 WICEP. All rights reserved.


#import "DDQBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQOrderContainerStatus) {
    
    DDQOrderContainerStatusUnpaid,          //未付款
    DDQOrderContainerStatusPaid,            //已付款
    DDQOrderContainerStatusAll,             //全部
    DDQOrderContainerStatusFinished,        //已完成
    
};

/**
 订单的容器控制器
 */
@interface DDQOrderContainerController : DDQBaseViewController

@property (nonatomic, assign) DDQOrderContainerStatus order_status;

@end

NS_ASSUME_NONNULL_END

