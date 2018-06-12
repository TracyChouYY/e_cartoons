//
//  DDQFinishOrderViewController.m
//
//  Copyright © 2018年 我叫咚咚枪. All rights reserved.
//

#import "DDQFinishOrderController.h"

#import "DDQOrderCell.h"

#import "DDQBaseViewController+DDQOrderHandler.h"

@interface DDQFinishOrderController () <DDQOrderCellDelegate> {
    
    NSArray<id<NSObject>> *_observers;
}

@property (nonatomic, strong) NSMutableArray<DDQOrderModel *> *finish_dataSource;

@end

@implementation DDQFinishOrderController

- (void)willMoveToParentViewController:(UIViewController *)parent {
    
    [super willMoveToParentViewController:parent];
    
    self.base_orderState = @"3";
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    //TableView Config
    [self base_tableViewConfig];
    
    //NetRequest
//    self.finish_dataSource = [NSMutableArray array];
//    [self handler_orderOperationWithType:DDQOrderListOperationTypeUp dataSource:self.finish_dataSource];
//    [self handler_setOrderListHeaderFooterNotNeedCompletedHandleWithDataSource:self.finish_dataSource];
//    
//    //Notification
//    _observers = [self handler_notificationCallBackWithType:DDQOrderNotificationTypeToFinished dataSource:self.finish_dataSource];
}

- (void)dealloc {
    
    for (id obsever in _observers) {
        
        [DDQNotificationCenter removeObserver:obsever];
    }
}

- (void)base_tableViewConfig {
    
    [super base_tableViewConfig];
    
    DDQWeakObject(self);
    [self.base_tableView tableView_setCellConfig:^__kindof UITableViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, UITableView * _Nonnull tableView) {
        
        DDQOrderCell *orderCell = [tableView dequeueReusableCellWithIdentifier:weakObjc.base_currentLayout.layout_cellIdentifier];
        orderCell.delegate = weakObjc;
        
        DDQOrderModel *model = weakObjc.finish_dataSource[indexPath.section];
        [orderCell cell_updateDataWithModel:model];
        weakObjc.base_currentLayout.layout_rowHeight = [DDQOrderCell cell_getCellHeightWithModel:model];
        return orderCell;
    }];
    
    [self.base_tableView tableView_setDidSelectConfig:^(NSIndexPath * _Nonnull indexPath) {
        
        DDQOrderModel *model = weakObjc.finish_dataSource[indexPath.section];
        weakObjc.base_handler.handler_dataMap = @{DDQHandlerResultClassId:[weakObjc class], DDQHandlerResultModel:model};
    }];
}

- (DDQFoundationTableViewLayout *)base_tableViewLayout {
    
    DDQFoundationTableViewLayout *layout = [super base_tableViewLayout];
    layout.layout_cellClass = [DDQOrderCell class];
    layout.layout_rowCount = 1;
    layout.layout_footerHeight = 10.0;
    layout.layout_sectionCount = self.finish_dataSource.count;
    return layout;
}

#pragma mark - OrderCell Delegate
- (void)order_didSelectFunctionWithType:(DDQOrderOperationType)type cell:(DDQOrderCell *)cell {
    
    DDQOrderModel *model = cell.cell_model;
    [self.base_handler setHandler_dataMap:@{DDQHandlerResultClassId:[self class], DDQHandlerResultData:@{DDQHandlerResultDataStatus:@(type), DDQHandlerResultDataModel:model}}];
}

- (void)order_didSelectSubOrderCellWithCell:(DDQOrderCell *)cell {
    
    [self.base_handler setHandler_dataMap:@{DDQHandlerResultClassId:[self class], DDQHandlerResultModel:cell.cell_model}];
}

@end
