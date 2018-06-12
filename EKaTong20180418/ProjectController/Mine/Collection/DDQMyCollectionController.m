//
//  DDQMyCollectionController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/27.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQMyCollectionController.h"

#import "DDQActivityBaseDetailController.h"

#import "DDQMyCollectionCell.h"

@interface DDQMyCollectionController ()

@property (nonatomic, strong) NSMutableArray *collection_dataSource;

@end

@implementation DDQMyCollectionController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    //TableView
    [self base_tableViewConfig];
    
    //NetRequest
    self.collection_dataSource = [NSMutableArray array];
    [self collection_netRequest];
  
}

- (NSString *)base_navigationTitle {
    
    return @"我的收藏";
    
}

- (void)base_tableViewConfig {
    
    [super base_tableViewConfig];
    
    self.base_tableView.backgroundColor = self.view.defaultViewBackgroundColor;
    
    DDQWeakObject(self);
    [self.base_tableView tableView_setCellConfig:^__kindof UITableViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, DDQFoundationTableView * _Nonnull tableView) {
        
        DDQMyCollectionCell *collectionCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_cellIdentifier];
        [collectionCell cell_updateDataWithModel:weakObjc.collection_dataSource[indexPath.section]];
        tableView.tableView_layout.layout_rowHeight = [DDQMyCollectionCell cell_getCellHeightWithModel:weakObjc.collection_dataSource[indexPath.section]];
        return collectionCell;
        
    }];
    
    [self.base_tableView tableView_setCellCanEditingConfig:^BOOL(NSIndexPath * _Nonnull indexPath) {
        
        return YES;
        
    }];
    
    [self.base_tableView tableView_setDidSelectConfig:^(NSIndexPath * _Nonnull indexPath) {
        
        DDQMyCollectionModel *model = [weakObjc.collection_dataSource objectAtIndex:indexPath.row];
        DDQActivityBaseDetailController *detailC = [weakObjc base_handleInitializeWithControllerClass:[DDQActivityBaseDetailController class] FromNib:NO title:nil propertys:nil];
        //二选一，两者都为空则不作处理
        if (model.bid.length > 0) {//基地id不为空
            
            detailC.detail_abID = [@"id" stringByAppendingFormat:@"/%@", model.bid];

        } else if (model.aid.length > 0) {//活动id不为空
            
            detailC.detail_abID = [@"id" stringByAppendingFormat:@"/%@", model.aid];
            [detailC detail_updateControllerType:DDQActivityBaseDetailTypeActivity];
            
        }
    }];
    
    [self.base_tableView tableView_setCellCommitEditingConfig:^(NSIndexPath * _Nonnull indexPath, DDQFoundationTableView * _Nonnull tableView, UITableViewCellEditingStyle style) {
        
        if (style == UITableViewCellEditingStyleDelete) {
            
            //删除收藏
            NSString *requestUrl = [weakObjc.base_url stringByAppendingString:@"UserApi/cdel"];
            DDQMyCollectionModel *model = weakObjc.collection_dataSource[indexPath.section];
            [weakObjc foundation_processNetPOSTRequestWithUrl:requestUrl Param:@{@"uid":weakObjc.base_userID, @"cid":model.cid} WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
                
                return YES;
                
            } AfterAlert:^(int code) {
                
                if (code == 1) {
                    
                    [tableView beginUpdates];
                    
                    [weakObjc.collection_dataSource removeObjectAtIndex:indexPath.section];
                    tableView.tableView_layout.layout_sectionCount = weakObjc.collection_dataSource.count;
                    [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
                    
                    [tableView endUpdates];

                }
            }];
        }
    }];
}

- (DDQFoundationTableViewLayout *)base_tableViewLayout {
    
    DDQFoundationTableViewLayout *layout = [super base_tableViewLayout];
    
    layout.layout_cellClass = [DDQMyCollectionCell class];
    layout.layout_sectionCount = self.collection_dataSource.count;
    layout.layout_rowCount = 1;
    layout.layout_headerHeight = 10.0 * self.base_widthRate;
    layout.layout_footerHeight = 5.0;
    
    return layout;
    
}

/**
 我的收藏网络请求
 */
- (void)collection_netRequest {
    
    DDQWeakObject(self);
    NSString *requestUrl = [self.base_url stringByAppendingString:@"UserApi/clist"];
    [self foundation_processNetPOSTRequestWithUrl:requestUrl Param:@{@"uid":self.base_userID} WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
        
        if (code == 1) {

            NSArray *listArr = [weakObjc base_handleRequestDataIfLegal:response[@"list"] targetClass:[NSArray class]];
            for (NSDictionary *dic in listArr) {
                
                DDQMyCollectionModel *model = [DDQMyCollectionModel mj_objectWithKeyValues:dic];
                [weakObjc.collection_dataSource addObject:model];
                model.image = [weakObjc.base_imageUrl stringByAppendingString:model.image];
                
            }
            
            weakObjc.base_currentLayout.layout_sectionCount = weakObjc.collection_dataSource.count;
            [weakObjc.base_tableView reloadData];
            return NO;
            
        }
        return YES;
        
    }];
}

@end
