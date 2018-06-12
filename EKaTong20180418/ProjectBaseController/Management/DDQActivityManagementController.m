//
//  DDQActivityManagementController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/4.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQActivityManagementController.h"

#import "DDQManagementCell.h"

#import "DDQActivityIssueController.h"

@interface DDQActivityManagementController () <DDQManagementCellDelegate>

@property (nonatomic, strong) NSMutableArray<DDQActivityModel *> *activity_dataSource;

@end

@implementation DDQActivityManagementController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //TableView
    [self base_tableViewConfig];
    
    //NetRequest
    self.activity_dataSource = [NSMutableArray array];
    [self activity_netRequest];

}

- (NSString *)base_navigationTitle {
    
    return @"我的活动";
    
}

- (void)base_tableViewConfig {
    
    [super base_tableViewConfig];
    
    DDQWeakObject(self);
    [self.base_tableView tableView_setCellConfig:^__kindof UITableViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, DDQFoundationTableView * _Nonnull tableView) {
        
        DDQManagementCell *managementCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_cellIdentifier forIndexPath:indexPath];
        [managementCell cell_updateDataWithModel:weakObjc.activity_dataSource[indexPath.row]];
        tableView.tableView_layout.layout_rowHeight = [DDQManagementCell cell_getCellHeightWithModel:weakObjc.activity_dataSource[indexPath.row]];
        managementCell.delegate = weakObjc;
        return managementCell;
        
    }];
}

- (DDQFoundationTableViewLayout *)base_tableViewLayout {
    
    DDQFoundationTableViewLayout *layout = [super base_tableViewLayout];
    
    layout.layout_cellClass = [DDQManagementCell class];
    layout.layout_rowCount = self.activity_dataSource.count;
    layout.layout_footerHeight = 10.0;
    layout.layout_headerHeight = 10.0;
    
    return layout;
    
}

/**
 网络请求
 */
- (void)activity_netRequest {
    
    DDQWeakObject(self);
    NSString *requestUrl = [self.base_url stringByAppendingString:@"UserApi/alist"];
    [self foundation_processNetPOSTRequestWithUrl:requestUrl Param:@{@"uid":self.base_userID} WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
        
        if (code != 1)
            return YES;
        
        NSArray *listArr = [weakObjc base_handleRequestDataIfLegal:response[@"list"] targetClass:[NSArray class]];
        for (NSDictionary *dic in listArr) {
            
            DDQActivityModel *model = [DDQActivityModel mj_objectWithKeyValues:dic];
            [weakObjc.activity_dataSource addObject:model];
            model.activity_image = [weakObjc.base_imageUrl stringByAppendingString:model.activity_image];
            
        }
        
        weakObjc.base_currentLayout.layout_rowCount = weakObjc.activity_dataSource.count;
        [weakObjc.base_tableView reloadData];
        
        return NO;

    }];
}

#pragma mark - CustomCell Delegate
- (void)management_didSelectEditWithModel:(__kindof DDQBaseCellModel *)model {
    
    DDQActivityModel *activityModel = model;
    DDQActivityIssueController *issueC = [self base_handleInitializeWithControllerClass:[DDQActivityIssueController class] FromNib:NO title:nil propertys:nil];
    issueC.issue_type = DDQActivityIssueTypeEdit;
    issueC.issue_activityID = activityModel.activity_id;
        
}

@end
