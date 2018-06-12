//
//  DDQUnusedCouponController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/27.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQUnusedCouponController.h"

#import "DDQBaseViewController+DDQCouponHandler.h"

@interface DDQUnusedCouponController ()

@property (nonatomic, strong) NSArray *unused_dataSource;

@end

@implementation DDQUnusedCouponController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //NetRequest
    DDQWeakObject(self);
    [self handler_requestCouponDataWithType:@"1" completed:^(NSArray<DDQCouponModel *> * _Nonnull dataSource) {
        
        weakObjc.unused_dataSource = dataSource;
        weakObjc.base_currentLayout.layout_sectionCount = dataSource.count;
        [weakObjc.base_tableView reloadData];
        
    }];
    
    //TableView
    [self base_tableViewConfig];
    
}

- (void)base_tableViewConfig {
    
    [super base_tableViewConfig];
    
    DDQWeakObject(self);
    [self.base_tableView tableView_setCellConfig:^__kindof UITableViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, DDQFoundationTableView * _Nonnull tableView) {
        
        DDQCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_cellIdentifier forIndexPath:indexPath];
        [cell cell_updateDataWithModel:weakObjc.unused_dataSource[indexPath.section]];
        tableView.tableView_layout.layout_rowHeight = [DDQCouponCell cell_getCellHeightWithModel:weakObjc.unused_dataSource[indexPath.section]];
        return cell;
        
    }];
}

- (DDQFoundationTableViewLayout *)base_tableViewLayout {
    
    DDQFoundationTableViewLayout *layout = [super base_tableViewLayout];
    layout.layout_cellClass = [DDQCouponCell class];
    layout.layout_footerHeight = 8.0;
    layout.layout_headerHeight = 8.0;
    layout.layout_sectionCount = self.unused_dataSource.count;
    layout.layout_rowCount = 1;
    return layout;
    
}

@end
