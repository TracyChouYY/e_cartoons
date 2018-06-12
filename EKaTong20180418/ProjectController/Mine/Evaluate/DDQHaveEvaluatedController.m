//
//  DDQHaveEvaluatedController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/2.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQHaveEvaluatedController.h"

#import "DDQHaveEvaluatedCell.h"

@interface DDQHaveEvaluatedController ()

@end

@implementation DDQHaveEvaluatedController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //TableView
    [self base_tableViewConfig];
    
}

- (void)base_tableViewConfig {
    
    [super base_tableViewConfig];
    
    DDQBaseCellModel *model = [DDQBaseCellModel new];
    
    [self.base_tableView tableView_setCellConfig:^__kindof UITableViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, DDQFoundationTableView * _Nonnull tableView) {
        
        DDQHaveEvaluatedCell *haveCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_cellIdentifier];
        [haveCell cell_updateDataWithModel:model];
        tableView.tableView_layout.layout_rowHeight = [DDQHaveEvaluatedCell cell_getCellHeightWithModel:model];
        return haveCell;
        
    }];
}

- (DDQFoundationTableViewLayout *)base_tableViewLayout {
    
    DDQFoundationTableViewLayout *layout = [super base_tableViewLayout];
    
    layout.layout_cellClass = [DDQHaveEvaluatedCell class];
    layout.layout_rowCount = 1;
    layout.layout_footerHeight = 10.0;
    layout.layout_headerHeight = 10.0;
    
    return layout;
    
}

@end
