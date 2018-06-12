//
//  DDQToEvaluatedController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/2.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQToEvaluatedController.h"

#import "DDQWriteEvaluateController.h"

#import "DDQToEvaluatedCell.h"

@interface DDQToEvaluatedController () <DDQEvaluateCellDelegate>

@end

@implementation DDQToEvaluatedController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //TableView
    [self base_tableViewConfig];
    
}

- (void)base_tableViewConfig {
    
    [super base_tableViewConfig];
    
    DDQBaseCellModel *model = [DDQBaseCellModel new];
    DDQWeakObject(self);
    [self.base_tableView tableView_setCellConfig:^__kindof UITableViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, DDQFoundationTableView * _Nonnull tableView) {
        
        DDQToEvaluatedCell *toCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_cellIdentifier];
        [toCell cell_updateDataWithModel:model];
        tableView.tableView_layout.layout_rowHeight = [DDQToEvaluatedCell cell_getCellHeightWithModel:model];
        toCell.delegate = weakObjc;
        return toCell;
        
    }];
}

- (DDQFoundationTableViewLayout *)base_tableViewLayout {
    
    DDQFoundationTableViewLayout *layout = [super base_tableViewLayout];
    
    layout.layout_cellClass = [DDQToEvaluatedCell class];
    layout.layout_rowCount = 1;
    layout.layout_headerHeight = 10.0;
    layout.layout_footerHeight = 10.0;
    
    return layout;
    
}

#pragma mark - Custom Cell Delegate
- (void)evaluate_didSelectToEvaluateWithCell:(DDQEvaluateCell *)cell {
    
    [self base_handleInitializeWithControllerClass:[DDQWriteEvaluateController class] FromNib:NO title:nil propertys:nil];
    
}

@end
