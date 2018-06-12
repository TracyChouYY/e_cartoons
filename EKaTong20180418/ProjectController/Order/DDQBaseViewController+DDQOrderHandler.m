//
//  DDQBaseViewController+DDQOrderHandler.m
//  WeiDuoShiGuang20171106
//
//  Created by 我叫咚咚枪 on 2017/12/28.
//  Copyright © 2017年 我叫咚咚枪. All rights reserved.
//

#import "DDQBaseViewController+DDQOrderHandler.h"

//#import "DDQOrderExpressController.h"

@implementation DDQBaseViewController (DDQOrderHandler)

DDQHandlerResultKey const DDQHandlerResultData = @"HandlerResultData";
DDQHandlerResultKey const DDQHandlerResultDataStatus = @"HandlerResultStatus";
DDQHandlerResultKey const DDQHandlerResultDataModel = @"HandlerResultDataModel";

NSNotificationName const DDQOrderHandlerListMakeSureNotification = @"OrderList.MakeSure";
NSNotificationName const DDQOrderHandlerListDeleteNotification = @"OrderList.Delete";
NSNotificationName const DDQOrderHandlerListCancelNotification = @"OrderList.Cancel";

DDQOrderHandlerOrderDataKey const DDQOrderHandlerOrderCodeKey = @"HandlerOrderCode";
DDQOrderHandlerOrderDataKey const DDQOrderHandlerOrderIDKey = @"HandlerOrderID";

- (void)handler_requestWithPage:(int)page completed:(DDQHandlerRequestCompleted)completed {
    
    NSString *requestUrl = [self.base_url stringByAppendingFormat:@"UserApi/olist"];
    
    DDQWeakObject(self);
    [self foundation_processNetPOSTRequestWithUrl:requestUrl Param:@{@"uid":self.base_userID, @"state":self.base_orderState} WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
        
        if (code == 1) {

#warning 数据格式需要修改
#warning 返回值有问题
            NSArray *listArray = [response valueForKey:@"list"];
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:listArray.count];

            //订单数据
            for (NSDictionary *dic in listArray) {

                DDQOrderModel *orderModel = [DDQOrderModel mj_objectWithKeyValues:dic];
                [array addObject:orderModel];

                //订单商品数据
                NSMutableArray<DDQOrderSubModel *> *subModels = [NSMutableArray arrayWithCapacity:1];
                DDQOrderSubModel *model = [DDQOrderSubModel mj_objectWithKeyValues:[orderModel mj_keyValues]];
                model.image = [weakObjc.base_imageUrl stringByAppendingString:model.image];
                [subModels addObject:model];
                orderModel.order_content = subModels.copy;
//                for (NSDictionary *subDic in subModels) {
//
//                    DDQOrderSubModel *subModel = [DDQOrderSubModel mj_objectWithKeyValues:subDic];
//                    [subModels addObject:subModel];
//                    subModel.image = [weakObjc.base_imageUrl stringByAppendingString:subModel.image];
//
//                }
//                orderModel.dd = subModels.copy;

                //对状态对应文字进行处理
                NSString *state = orderModel.state;
                orderModel.functions = [weakObjc handler_getFunctionWithOrderStata:orderModel.state];
                orderModel.stateName = [weakObjc handler_getDescriptionWithOrderState:state status:orderModel.status];
            }
            return (completed) ? completed(array, code) : NO;
        }
        return YES;

    }];
}

/**
 获得当前订单状态和使用状态下对应显示的名称

 @param state 订单状态
 @param status 使用状态，即验票或未验票
 @return 描述
 */
- (NSString *)handler_getDescriptionWithOrderState:(NSString *)state status:(NSString *)status {
    
    if (state == nil || state.length == 0) return nil;
    
    NSString *stateDesc = nil;
    int stateCode = state.intValue;
    int statusCode = status.intValue;
    if (stateCode == 1) {//已付款
        
        if (statusCode == 1) {//未验票
            
            stateDesc = @"已支付未验票";
            
        } else {
            
            stateDesc = @"已支付已验票";
            
        }
    } else if (stateCode == 2) {//未付款
        
        stateDesc = @"未支付";

    } else if (stateCode == 3) {//已完成
        
        stateDesc = @"已完成";

    } else if (stateCode == 4) {//已取消
        
        stateDesc = @"已取消";
        
    } else if (stateCode == 5) {//已过期
        
        stateDesc = @"已过期";
        
    }     

    return stateDesc;
    
}

- (NSArray<NSString *> *)handler_getFunctionWithOrderStata:(NSString *)state {
    
    if (state.length == 0 || !state) return nil;
    
    int stateNum = state.intValue;
    if (stateNum == 1) {//已付款
        
       return @[@"再来一单", @"删除订单"];
        
    } else if (stateNum == 2) {//未付款
        
        return @[@"立即支付", @"取消订单"];
        
    } else if (stateNum == 3) {//已完成
        
        return @[@"再来一单", @"删除订单"];

    } else if (stateNum == 4) {//已取消
        
        return @[@"删除订单"];

    } else if (stateNum == 5) {//已过期
        
        return @[@"删除订单"];

    } else {//其他订单状态
        
        return @[@"删除订单"];
    }
}

- (void)handler_setOrderListHeaderFooterWithDataSource:(NSMutableArray<DDQOrderModel *> *)dSource headerCompleted:(DDQHandlerOperationRequestCompleted)hCompleted footerCompleted:(DDQHandlerOperationRequestCompleted)fCompleted {
    
    DDQWeakObject(self);
    [self base_setTableViewHeaderFooterWithHeaderCompleted:^(int page) {
        
        [weakObjc handler_requestWithPage:page completed:^BOOL(NSArray<DDQOrderModel *> * _Nonnull dataSource, int code) {
            
            if (code >= DDQFoundationRequestFailure) return YES;
            
            if (dataSource.count > 0) {
                
                [weakObjc.base_tableView foundation_endRestNoMoreData];
            }
            
            if (hCompleted) hCompleted(dataSource, code);
            return NO;
        }];
    } footerCompleted:^(int page) {
        
        [weakObjc handler_requestWithPage:page completed:^BOOL(NSArray<DDQOrderModel *> * _Nonnull dataSource, int code) {
            
            if (code >= DDQFoundationRequestFailure) return YES;

            if (dataSource.count == 0) {

                [weakObjc.base_tableView foundation_endNoMoreData];
            }
            
            if (fCompleted) fCompleted(dataSource, code);
            return NO;
        }];
    }];
}

- (void)handler_tableViewReloadWithHeader:(BOOL)isH dataSource:(NSMutableArray<DDQOrderModel *> *)dSource requestData:(NSArray<DDQOrderModel *> *)rSource {
    
    //操作判断
    if (isH) {//下拉刷新
        
        [dSource removeAllObjects];
        [dSource addObjectsFromArray:rSource];
        
    } else {//上拉加载
        
        [dSource addObjectsFromArray:rSource];
    }
    self.base_currentLayout.layout_sectionCount = dSource.count;
    [self.base_tableView reloadData];
}

- (void)handler_orderOperationWithType:(DDQOrderListOperationType)type dataSource:(NSMutableArray<DDQOrderModel *> *)dSource {
    
    self.base_requestPage = (type == DDQOrderListOperationTypeUp) ? self.base_requestPage + 1 : 1;
    
    DDQWeakObject(self);
    [self handler_requestWithPage:self.base_requestPage completed:^BOOL(NSArray<DDQOrderModel *> * _Nonnull dataSource, int code) {
        
        if (code == 1) {

            [weakObjc handler_tableViewReloadWithHeader:(type == DDQOrderListOperationTypeDown) ? YES : NO dataSource:dSource requestData:dataSource];
            return NO;
        }
        return YES;
    }];
}

- (void)handler_setOrderListHeaderFooterNotNeedCompletedHandleWithDataSource:(NSMutableArray<DDQOrderModel *> *)dSource {
    
    DDQWeakObject(self);
    [self handler_setOrderListHeaderFooterWithDataSource:dSource headerCompleted:^void(NSArray<DDQOrderModel *> * _Nonnull dataSource, int code) {
        
        if (code == 1) {//为1是表示请求成功
            
            [weakObjc handler_tableViewReloadWithHeader:YES dataSource:dSource requestData:dataSource];
        }
    } footerCompleted:^void(NSArray<DDQOrderModel *> * _Nonnull dataSource, int code) {
        
        if (code == 1) {
         
            [weakObjc handler_tableViewReloadWithHeader:NO dataSource:dSource requestData:dataSource];
        }
    }];
}

- (NSArray<id<NSObject>> *)handler_notificationCallBackWithType:(DDQOrderNotificationType)type dataSource:(NSMutableArray<DDQOrderModel *> *)dSource {
    
//    if (type == DDQOrderNotificationTypeToSend) return nil;
//
//    DDQWeakObject(self);
//    //不同控制器判断
//    if (type == DDQOrderNotificationTypeAll) {//全部控制器
//
//        //列表删除订单
//        id listDeleteObserver = [DDQNotificationCenter addObserverForName:DDQOrderHandlerListDeleteNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//
//            //对我来说也是一次下拉刷新的操作
//            [weakObjc handler_orderOperationWithType:DDQOrderListOperationTypeDown dataSource:dSource];
//        }];
//
//        //订单列表确认收货
//        id listMakeSureObserver = [DDQNotificationCenter addObserverForName:DDQOrderHandlerListMakeSureNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//
//            [weakObjc handler_orderOperationWithType:DDQOrderListOperationTypeDown dataSource:dSource];
//        }];
//
//        //订单详情删除订单
//        id detailDeleteObserver = [DDQNotificationCenter addObserverForName:DDQOrderHandlerDetailDeleteNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//
//            [weakObjc handler_orderOperationWithType:DDQOrderListOperationTypeDown dataSource:dSource];
//        }];
//
//        //订单详情确认收货
//        id detailMakeSureObserver = [DDQNotificationCenter addObserverForName:DDQOrderHandlerDetailMakeSureNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//
//            [weakObjc handler_orderOperationWithType:DDQOrderListOperationTypeDown dataSource:dSource];
//        }];
//
//
//        return @[listDeleteObserver, listMakeSureObserver, detailDeleteObserver, detailMakeSureObserver];
//
//    } else if (type == DDQOrderNotificationTypeToReceive) {//待收货
//
//        //订单列表确认收货
//        id listMakeSureObserver = [DDQNotificationCenter addObserverForName:DDQOrderHandlerListMakeSureNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//
//            [weakObjc handler_orderOperationWithType:DDQOrderOperationTypeDown dataSource:dSource];
//        }];
//
//        //订单详情确认收货
//        id detailMakeSureObserver = [DDQNotificationCenter addObserverForName:DDQOrderHandlerDetailMakeSureNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//
//            [weakObjc handler_orderOperationWithType:DDQOrderOperationTypeDown dataSource:dSource];
//        }];
//
//        return @[listMakeSureObserver, detailMakeSureObserver];
//
//    } else if (type == DDQOrderNotificationTypeToSend) {//待发货
//
//        return @[];
//
//    } else {//全部订单
//
//        //订单详情删除订单
//        id detailDeleteObserver = [DDQNotificationCenter addObserverForName:DDQOrderHandlerDetailDeleteNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//
//            [weakObjc handler_orderOperationWithType:DDQOrderOperationTypeDown dataSource:dSource];
//        }];
//
//        //列表删除订单
//        id listDeleteObserver = [DDQNotificationCenter addObserverForName:DDQOrderHandlerListDeleteNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
//
//            //对我来说也是一次下拉刷新的操作
//            [weakObjc handler_orderOperationWithType:DDQOrderOperationTypeDown dataSource:dSource];
//        }];
//
//        return @[listDeleteObserver, detailDeleteObserver];
//
//    }
    return nil;
}

- (void)handler_handleOrderWithType:(DDQOrderHandlerType)type orderData:(NSDictionary<DDQOrderHandlerOrderDataKey,NSString *> *)orderData needToPay:(NSDictionary<DDQOrderHandlerToPayDataKey,NSString *> *)payData completed:(void (^)(void))completed {
    
    DDQWeakObject(self);
    //当前处理的类型判断
    if (type == DDQOrderHandlerTypeDelete) {//删除
        
        [self base_presentAlertControllerWithTitle:nil message:@"您确定要删除这个订单吗？" style:DDQAlertControllerStyleAlert cancel:nil sure:^{
            
            NSString *requestUrl = [weakObjc.base_url stringByAppendingString:@"Grzx/del_order"];
            [weakObjc foundation_processNetPOSTRequestWithUrl:requestUrl Param:@{@"uid":weakObjc.base_userID, @"order_code":[orderData valueForKey:DDQOrderHandlerOrderCodeKey]?:@""} WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
                
                return YES;
            } AfterAlert:^(int code) {
                
                if (code == 1) {
                    
                    if (completed) completed();
                }
            }];
        }];
    } else if (type == DDQOrderHandlerTypeSureOrder) {//确认收货
        
        [self base_presentAlertControllerWithTitle:nil message:@"是否确认收货?" style:DDQAlertControllerStyleAlert cancel:nil sure:^{

            NSString *sureUrl = [weakObjc.base_url stringByAppendingString:@"Grzx/qrsh"];
            [weakObjc foundation_processNetPOSTRequestWithUrl:sureUrl Param:@{@"uid":weakObjc.base_userID, @"id":orderData[DDQOrderHandlerOrderIDKey]} WhenHUDHidden:^BOOL(id  _Nullable response, int code) {

                return YES;
            } AfterAlert:^(int code) {

                //订单状态判断
                if (code == 1) {

                    if (completed) {

                        completed();
                    }
                }
            }];
        }];
    } else if (type == DDQOrderHandlerTypeCancel) {//取消订单
        
        [self base_presentAlertControllerWithTitle:nil message:@"是否取消订单?" style:DDQAlertControllerStyleAlert cancel:nil sure:^{
            
            NSString *sureUrl = [weakObjc.base_url stringByAppendingString:@"Buy/order_qx"];
            [weakObjc foundation_processNetPOSTRequestWithUrl:sureUrl Param:@{@"uid":weakObjc.base_userID, @"code":orderData[DDQOrderHandlerOrderCodeKey]} WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
                
                return YES;
            } AfterAlert:^(int code) {
                
                //订单状态判断
                if (code == 1) {
                    
                    if (completed) {
                        
                        completed();
                    }
                }
            }];
        }];
    } else {//查看物流
        
//        DDQOrderExpressController *orderExpressController = [self base_handleInitializeWithControllerClass:[DDQOrderExpressController class] FromNib:NO title:nil propertys:nil];
//        orderExpressController.express_orderCode = orderData[DDQOrderHandlerOrderCodeKey];
        
    }
}

@end
