//
//  DDQMyPointController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/25.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQMyPointController.h"

#import "DDQDailyBonusController.h"

#import "DDQMyPointHeaderView.h"

#import "DDQMyPointDetailCell.h"

@interface DDQMyPointController ()

@end

@implementation DDQMyPointController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //TableView
    [self base_tableViewConfig];
    
}

- (NSString *)base_navigationTitle {
    
    return @"我的积分";
    
}

- (void)base_tableViewConfig {
    
    [super base_tableViewConfig];
    
    DDQMyPointHeaderView *headerView = [[DDQMyPointHeaderView alloc] initViewWithFrame:CGRectZero];
    headerView.frame = CGRectMake(0.0, 0.0, self.view.width, headerView.header_estimateHeight);
    self.base_tableView.tableHeaderView = headerView;
    DDQWeakObject(self);
    [headerView header_didSelectSignIn:^{
        
        DDQDailyBonusController *dbController = [weakObjc base_initializeControllerClass:[DDQDailyBonusController class] FromNib:YES Title:nil];
        [weakObjc presentViewController:dbController animated:YES completion:nil];
        
    }];
    
    [self.base_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header"];
    
    [self.base_tableView tableView_setHeaderViewConfig:^__kindof UIView * _Nullable(NSInteger section, DDQFoundationTableView * _Nonnull tableView) {
        
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
        headerView.contentView.backgroundColor = headerView.defaultViewBackgroundColor;
        
        UILabel *label = [headerView.contentView viewWithTag:1];
        if (!label) {
            
            label = [UILabel labelChangeText:@"积分明细" font:DDQFont(16.0) textColor:[UIColor blackColor]];
            label.tag = 1;
            label.backgroundColor = [UIColor whiteColor];
            [headerView.contentView addSubview:label];
            
        }
        
        [label mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.mas_equalTo(UIEdgeInsetsMake(10.0 * weakObjc.base_widthRate, 0.0, 1.0, 0.0));
            
        }];
        
        return headerView;
        
    }];
    
    DDQBaseCellModel *model = [DDQBaseCellModel new];
    [self.base_tableView tableView_setCellConfig:^__kindof UITableViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, DDQFoundationTableView * _Nonnull tableView) {
        
        DDQMyPointDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_cellIdentifier];
        [cell cell_updateDataWithModel:model];
        tableView.tableView_layout.layout_rowHeight = [DDQMyPointDetailCell cell_getCellHeightWithModel:model];
        return cell;
        
    }];
}

- (DDQFoundationTableViewLayout *)base_tableViewLayout {
    
    DDQFoundationTableViewLayout *layout = [super base_tableViewLayout];
    
    layout.layout_headerHeight = 55.0 * self.base_widthRate;
    layout.layout_cellClass = [DDQMyPointDetailCell class];
    layout.layout_rowCount = 1;
    
    return layout;
    
}

@end
