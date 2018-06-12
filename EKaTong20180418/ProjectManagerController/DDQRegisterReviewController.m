//
//  DDQRegisterReviewController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/3.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQRegisterReviewController.h"

#import "DDQManagerReviewCell.h"

@interface DDQRegisterReviewController ()

@property (nonatomic, strong) NSMutableArray *register_dataSource;

@end

@implementation DDQRegisterReviewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.register_dataSource = [NSMutableArray array];
    
    //TableView
    [self base_tableViewConfig];
    
}

- (NSString *)base_navigationTitle {
    
    return @"注册审核";
    
}

- (void)base_tableViewConfig {
    
    [super base_tableViewConfig];
    
    DDQBaseCellModel *model = [DDQBaseCellModel new];
    [self.base_tableView tableView_setCellConfig:^__kindof UITableViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, DDQFoundationTableView * _Nonnull tableView) {
        
        DDQManagerReviewCell *reviewCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_cellIdentifier forIndexPath:indexPath];
        [reviewCell cell_updateDataWithModel:model];
        tableView.tableView_layout.layout_rowHeight = [DDQManagerReviewCell cell_getCellHeightWithModel:model];
        return reviewCell;
        
    }];
}

- (DDQFoundationTableViewLayout *)base_tableViewLayout {
    
    DDQFoundationTableViewLayout *layout = [super base_tableViewLayout];
    
    layout.layout_cellClass = [DDQManagerReviewCell class];
    layout.layout_rowCount = 1;
    layout.layout_headerHeight = 10.0;
    layout.layout_footerHeight = 10.0;
    
    return layout;
    
}

@end
