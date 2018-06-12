//
//  DDQAllOderController.m
//
//  Copyright © 2017年 我叫咚咚枪. All rights reserved.
//

#import "DDQAllOderController.h"

#import "DDQBaseViewController+DDQOrderHandler.h"

@interface DDQAllOderController ()<DDQOrderCellDelegate> {

    NSArray<id<NSObject>> *_observers;
}

@property (nonatomic, strong) NSMutableArray<DDQOrderModel *> *all_dataSource;

@end

@implementation DDQAllOderController

- (void)willMoveToParentViewController:(UIViewController *)parent {
    
    [super willMoveToParentViewController:parent];

    self.base_orderState = @"0";
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    //TableViewConfig
    [self base_tableViewConfig];
    
    //NetRequest
    self.all_dataSource = [NSMutableArray array];
    //第一次请求不过是一次下拉刷新
    [self handler_orderOperationWithType:DDQOrderListOperationTypeDown dataSource:self.all_dataSource];

    //上下拉刷新
    [self handler_setOrderListHeaderFooterNotNeedCompletedHandleWithDataSource:self.all_dataSource];
    
    //Notification
    _observers = [self handler_notificationCallBackWithType:DDQOrderNotificationTypeAll dataSource:self.all_dataSource];
    
}

- (void)dealloc {

    for (id observer in _observers) {
        
        [DDQNotificationCenter removeObserver:observer];
    }
}

- (void)base_tableViewConfig {
    
    [super base_tableViewConfig];
    
    DDQWeakObject(self);
    [self.base_tableView tableView_setCellConfig:^__kindof UITableViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, UITableView * _Nonnull tableView) {
        
        DDQOrderCell *orderCell = [tableView dequeueReusableCellWithIdentifier:weakObjc.base_currentLayout.layout_cellIdentifier];
        orderCell.delegate = weakObjc;
        
        DDQOrderModel *model = weakObjc.all_dataSource[indexPath.section];
        [orderCell cell_updateDataWithModel:model];
        weakObjc.base_currentLayout.layout_rowHeight = [DDQOrderCell cell_getCellHeightWithModel:model];
        return orderCell;
        
    }];
    
    [self.base_tableView tableView_setDidSelectConfig:^(NSIndexPath * _Nonnull indexPath) {

        [weakObjc.base_handler setHandler_dataMap:@{DDQHandlerResultClassId:[weakObjc class], DDQHandlerResultModel:weakObjc.all_dataSource[indexPath.section]}];
        
    }];
}

- (DDQFoundationTableViewLayout *)base_tableViewLayout {
    
    DDQFoundationTableViewLayout *layout = [super base_tableViewLayout];
    layout.layout_cellClass = [DDQOrderCell class];
    layout.layout_sectionCount = self.all_dataSource.count;
    layout.layout_rowCount = 1;
    layout.layout_footerHeight = 10.0;
    return layout;
}

#pragma mark - FunctionBar Delegate
- (void)order_didSelectFunctionWithType:(DDQOrderOperationType)type cell:(DDQOrderCell *)cell {
    
    DDQOrderModel *model = cell.cell_model;
    [self.base_handler setHandler_dataMap:@{DDQHandlerResultClassId:[self class], DDQHandlerResultData:@{DDQHandlerResultDataStatus:@(type), DDQHandlerResultDataModel:model}}];
    
}

- (void)order_didSelectSubOrderCellWithCell:(DDQOrderCell *)cell {
    
    [self.base_handler setHandler_dataMap:@{DDQHandlerResultClassId:[self class], DDQHandlerResultModel:cell.cell_model}];
    
}

@end
