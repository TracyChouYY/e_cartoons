//
//  DDQBaseManagementController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/4.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBaseManagementController.h"

#import "DDQBaseIssueController.h"

#import "DDQManagementCell.h"


@interface DDQBaseManagementController () <DDQManagementCellDelegate>

@property (nonatomic, strong) NSMutableArray<DDQManagementModel *> *management_dataSource;

@end

@implementation DDQBaseManagementController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    //TableView
    [self base_tableViewConfig];
    
    //NetRequest
    self.management_dataSource = [NSMutableArray array];
    [self base_netRequest];
    
}

- (NSString *)base_navigationTitle {
    
    return @"基地管理";
    
}

- (void)base_tableViewConfig {
    
    [super base_tableViewConfig];
    
    DDQWeakObject(self);
    [self.base_tableView tableView_setCellConfig:^__kindof UITableViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, DDQFoundationTableView * _Nonnull tableView) {
        
        DDQManagementCell *managementCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_cellIdentifier forIndexPath:indexPath];
        [managementCell cell_updateDataWithModel:weakObjc.management_dataSource[indexPath.row]];
        tableView.tableView_layout.layout_rowHeight = [DDQManagementCell cell_getCellHeightWithModel:weakObjc.management_dataSource[indexPath.row]];
        managementCell.delegate = weakObjc;
        return managementCell;
        
    }];
}

- (DDQFoundationTableViewLayout *)base_tableViewLayout {
    
    DDQFoundationTableViewLayout *layout = [super base_tableViewLayout];
    
    layout.layout_cellClass = [DDQManagementCell class];
    layout.layout_rowCount = self.management_dataSource.count;
    layout.layout_footerHeight = 10.0;
    layout.layout_headerHeight = 10.0;
    
    return layout;
    
}

/**
 基地列表数据
 */
- (void)base_netRequest {
    
    DDQWeakObject(self);
    NSString *requestUrl = [self.base_url stringByAppendingString:@"UserApi/blist"];
    [self foundation_processNetPOSTRequestWithUrl:requestUrl Param:@{@"uid":self.base_userID} WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
        
        if (code != 1) {
            return YES;
        }
        
        NSArray *listArr = [weakObjc base_handleRequestDataIfLegal:response[@"list"] targetClass:[NSArray class]];
        for (NSDictionary *dic in listArr) {
            
            DDQManagementModel *model = [DDQManagementModel mj_objectWithKeyValues:dic];
            [weakObjc.management_dataSource addObject:model];
            model.base_image = [weakObjc.base_imageUrl stringByAppendingString:model.base_image];
            
        }
        
        weakObjc.base_currentLayout.layout_rowCount = weakObjc.management_dataSource.count;
        [weakObjc.base_tableView reloadData];
        
        return NO;
        
    }];
}

#pragma mark - CustomCell Delegate
- (void)management_didSelectEditWithModel:(__kindof DDQBaseCellModel *)model {
    
    DDQManagementModel *managementModel = model;
    DDQBaseIssueController *issueC = [self base_handleInitializeWithControllerClass:[DDQBaseIssueController class] FromNib:YES title:nil propertys:nil];
    issueC.base_id = managementModel.base_id;
    
}

@end
