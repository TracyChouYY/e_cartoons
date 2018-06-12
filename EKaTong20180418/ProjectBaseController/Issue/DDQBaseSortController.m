//
//  DDQBaseSortController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/11.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBaseSortController.h"

@interface DDQBaseSortController ()

@property (nonatomic, strong) NSMutableArray<NSDictionary *> *sort_dataSource;
@property (nonatomic, copy) DDQSelectBaseSort sort;

@end

@implementation DDQBaseSortController

DDQBaseSortDataKey const DDQBaseSortDataNameKey = @"name";
DDQBaseSortDataKey const DDQBaseSortDataIdKey = @"id";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //TableView
    [self base_tableViewConfig];
    
    //NetRequest
    self.sort_dataSource = [NSMutableArray array];
    [self sort_netRequest];
    
}

- (NSString *)base_navigationTitle {
    
    return @"基地分类";
    
}

- (void)base_tableViewConfig {
    
    [super base_tableViewConfig];
    
    DDQWeakObject(self);
    [self.base_tableView tableView_setCellConfig:^__kindof UITableViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, DDQFoundationTableView * _Nonnull tableView) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_cellIdentifier forIndexPath:indexPath];
        cell.textLabel.font = DDQFont(15.0);
        cell.textLabel.textColor = kSetColor(84.0, 86.0, 89.0, 1.0);
        NSDictionary *data = weakObjc.sort_dataSource[indexPath.row];
        cell.textLabel.text = [data valueForKey:DDQBaseSortDataNameKey];

        UIView *separator = [cell.contentView viewWithTag:1];
        if (!separator) {
            
            separator = [UIView viewChangeBackgroundColor:kSetColor(247.0, 247.0, 247.0, 1.0)];
            [cell.contentView addSubview:separator];
            [cell.contentView bringSubviewToFront:separator];
            separator.tag = 1;
            
        }
        
        [separator mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(cell.contentView.mas_bottom);
            make.left.equalTo(cell.contentView.mas_left).offset(15.0);
            make.height.mas_equalTo(1);
            make.right.equalTo(cell.contentView.mas_right);
            
        }];
        
        return cell;
        
    }];
    
    [self.base_tableView tableView_setDidSelectConfig:^(NSIndexPath * _Nonnull indexPath) {
        
        NSDictionary *data = weakObjc.sort_dataSource[indexPath.row];
        if (weakObjc.sort) {
            
            weakObjc.sort(data);
            [self base_handlePopController];

        }
    }];
}

- (DDQFoundationTableViewLayout *)base_tableViewLayout {
    
    DDQFoundationTableViewLayout *layout = [super base_tableViewLayout];
    layout.layout_rowHeight = 44.0;
    return layout;
    
}

/**
 分类页请求
 */
- (void)sort_netRequest {
    
    DDQWeakObject(self);
    NSString *requestUrl = [self.base_url stringByAppendingString:@"UserApi/basetype"];
    [self foundation_processNetPOSTRequestWithUrl:requestUrl Param:@{@"uid":self.base_userID} WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
        
        if (code == 1) {
            
            NSArray *listArr = [weakObjc base_handleRequestDataIfLegal:[response valueForKey:@"list"] targetClass:[NSArray class]];
            for (NSDictionary *dic in listArr) {
                
                [weakObjc.sort_dataSource addObject:dic];
                
            }
            weakObjc.base_currentLayout.layout_rowCount = weakObjc.sort_dataSource.count;
            [weakObjc base_reloadTableViewWithSection:0];
            return NO;
            
        }
        return YES;
        
    }];
}

- (void)sort_didSelectSort:(DDQSelectBaseSort)sort {
    
    if (sort) {
        
        self.sort = sort;
        
    }
}

@end
