//
//  DDQBaseReviewController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/3.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBaseReviewController.h"

#import "DDQBaseReviewCell.h"

@interface DDQBaseReviewController ()

@end

@implementation DDQBaseReviewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //TableView
    [self base_tableViewConfig];
    
}

- (NSString *)base_navigationTitle {
    
    return @"基地审核";
    
}

- (void)base_tableViewConfig {
    
    [super base_tableViewConfig];
    
    DDQBaseCellModel *model = [DDQBaseCellModel new];
    [self.base_tableView tableView_setCellConfig:^__kindof UITableViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, DDQFoundationTableView * _Nonnull tableView) {
        
        DDQBaseReviewCell *reviewCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_cellIdentifier forIndexPath:indexPath];
        [reviewCell cell_updateDataWithModel:model];
        tableView.tableView_layout.layout_rowHeight = [DDQBaseReviewCell cell_getCellHeightWithModel:model];
        return reviewCell;
        
    }];
}

- (DDQFoundationTableViewLayout *)base_tableViewLayout {
    
    DDQFoundationTableViewLayout *layout = [super base_tableViewLayout];
    
    layout.layout_cellClass = [DDQBaseReviewCell class];
    layout.layout_rowCount = 1;
    layout.layout_headerHeight = 10.0;
    layout.layout_footerHeight = 10.0;
    
    return layout;
    
}

@end
