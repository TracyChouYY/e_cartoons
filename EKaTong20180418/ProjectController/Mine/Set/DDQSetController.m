//
//  DDQSetController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/25.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQSetController.h"

#import "DDQUserInfoController.h"
#import "DDQBandAccountController.h"
#import "DDQPayPasswordController.h"
#import "DDQEditPasswordController.h"

#import "DDQSetCell.h"
#import "DDQCacheSetCell.h"

@interface DDQSetController ()

@property (nonatomic, strong) NSMutableArray<NSArray *> *set_dataSource;

@end

@implementation DDQSetController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //DataSource
    NSString *titleKey = @"title";
    NSArray *titles = @[@[@{titleKey:@"编辑个人资料"}], @[@{titleKey:@"支付设置"}], @[@{titleKey:@"账号绑定"}, @{titleKey:@"修改密码"}], @[@{titleKey:@"关于我们"}, @{titleKey:@"清除缓存"}]];
    self.set_dataSource = [NSMutableArray arrayWithCapacity:titles.count];
    
    for (NSArray *array in titles) {
        
        NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:array.count];
        for (NSDictionary *dic in array) {
            
            [tempArray addObject:[DDQSetModel mj_objectWithKeyValues:dic]];
            
        }
        [self.set_dataSource addObject:tempArray];
        
    }
    
    //TableView
    [self base_tableViewConfig];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    [self.base_navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
}

- (void)base_tableViewConfig {
    
    [super base_tableViewConfig];
    
    [self.base_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header"];
    [self.base_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"footer"];

    DDQWeakObject(self);
    [self.base_tableView tableView_setHeaderHeightConfig:^CGFloat(NSInteger section) {
        
        return ((section == 0) ? 90.0 : 45.0) * weakObjc.base_widthRate;
        
    }];
    
    [self.base_tableView tableView_setHeaderViewConfig:^__kindof UIView * _Nullable(NSInteger section, DDQFoundationTableView * _Nonnull tableView) {
        
        if (section != 0) return nil;
        
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
        UILabel *label = [headerView.contentView viewWithTag:1];
        if (!label) {
            
            label = [UILabel labelChangeText:@"设置" font:DDQFont(26.0) textColor:kSetColor(42.0, 42.0, 42.0, 1.0)];
            label.tag = 1;
            [headerView.contentView addSubview:label];
            
        }
        [label mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(headerView.contentView.mas_left).offset(20.0 * weakObjc.base_widthRate);
            make.top.equalTo(headerView.contentView.mas_top).offset(15.0 * weakObjc.base_widthRate);
            
        }];
        
        return headerView;
        
    }];
    
    [self.base_tableView tableView_setFooterHeightConfig:^CGFloat(NSInteger section) {
        
        return (section == weakObjc.set_dataSource.count - 1) ? 110.0 : 0.0;
        
    }];
    
    [self.base_tableView tableView_setFooterViewConfig:^__kindof UIView * _Nullable(NSInteger section, DDQFoundationTableView * _Nonnull tableView) {
        
        if (section != weakObjc.set_dataSource.count - 1) return nil;
        
        UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer"];
        UIButton *button = [footerView.contentView viewWithTag:1];
        if (!button) {
            
            button = [UIButton buttonChangeFont:DDQFont(15.0) titleColor:tableView.defaultBlueColor image:nil backgroundImage:nil title:@"退出登录" attributeTitle:nil target:weakObjc sel:@selector(set_didSelectLogout)];
            button.tag = 1;
            [footerView.contentView addSubview:button];
            [button view_hanlderLayerWithRadius:3.0 borderWidth:1.0 borderColor:tableView.defaultBlueColor];
            
        }

        [button mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.mas_equalTo(UIEdgeInsetsMake(40.0 * weakObjc.base_widthRate, 20.0 * weakObjc.base_widthRate, 12.0, 20.0 * weakObjc.base_widthRate));
            
        }];
        
        return footerView;
        
    }];
    
    [self.base_tableView tableView_setRowConfig:^NSInteger(NSInteger section) {
        
        return weakObjc.set_dataSource[section].count;
        
    }];
    
    [self.base_tableView tableView_setCellHeightConfig:^CGFloat(NSIndexPath * _Nonnull indexPath) {
        
        return [DDQSetCell cell_getCellHeightWithModel:weakObjc.set_dataSource[indexPath.section][indexPath.row]];
        
    }];
    
    [self.base_tableView tableView_setCellConfig:^__kindof UITableViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, DDQFoundationTableView * _Nonnull tableView) {
        
        if (indexPath.section == weakObjc.set_dataSource.count - 1) {
            
            if (indexPath.row == 1) {
                
                DDQCacheSetCell *cacheCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_reuseDataSource[NSStringFromClass([DDQCacheSetCell class])]];
                [cacheCell cell_updateDataWithModel:weakObjc.set_dataSource[indexPath.section][indexPath.row]];
                return cacheCell;

            }
        }
        DDQSetCell *setCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_reuseDataSource[NSStringFromClass([DDQSetCell class])]];
        [setCell cell_updateDataWithModel:weakObjc.set_dataSource[indexPath.section][indexPath.row]];
        return setCell;

    }];
    
    [self.base_tableView tableView_setDidSelectConfig:^(NSIndexPath * _Nonnull indexPath) {
        
        if (indexPath.section == 0) {//编辑个人资料
            
            [weakObjc base_handleInitializeWithControllerClass:[DDQUserInfoController class] FromNib:NO title:nil propertys:nil];
            
        }
        
        if (indexPath.section == 1) {//支付设置
            
            [weakObjc base_handleInitializeWithControllerClass:[DDQPayPasswordController class] FromNib:NO title:nil propertys:nil];

        }
        
        if (indexPath.section == 2) {//账号设置
            
            if (indexPath.row == 0) {
                
                [weakObjc base_handleInitializeWithControllerClass:[DDQBandAccountController class] FromNib:YES title:nil propertys:nil];
                
            } else {
                
                [weakObjc base_handleInitializeWithControllerClass:[DDQEditPasswordController class] FromNib:YES title:nil propertys:nil];
                
            }
        }
    }];
}

- (DDQFoundationTableViewLayout *)base_tableViewLayout {
    
    DDQFoundationTableViewLayout *layout = [super base_tableViewLayout];
    
    DDQFoundationControllerCellIdentifier const DDQSetNormalCellID = @"set_normal";
    DDQFoundationControllerCellIdentifier const DDQSetCacheCellID = @"set_cache";

    layout.layout_reuseDataSource = @{NSStringFromClass([DDQSetCell class]):DDQSetNormalCellID, NSStringFromClass([DDQCacheSetCell class]):DDQSetCacheCellID};
    layout.layout_sectionCount = self.set_dataSource.count;
    
    return layout;
    
}

/**
 点击退出登录
 */
- (void)set_didSelectLogout {
    
    DDQWeakObject(self);
    [self base_presentAlertControllerWithTitle:@"提示" message:@"您真的要退出当前账号吗？" style:DDQAlertControllerStyleAlert cancel:nil sure:^{
        
        [weakObjc base_handleUserLogoutCompleted:^{
            
            [DDQNotificationCenter postNotificationName:DDQLogoutSuccessNotification object:nil];
            
        }];
    }];
}

@end
