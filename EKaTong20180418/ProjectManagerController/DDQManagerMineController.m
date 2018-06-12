//
//  DDQManagerMineController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/20.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQManagerMineController.h"

#import "DDQBaseReviewController.h"
#import "DDQActivityReviewController.h"
#import "DDQRegisterReviewController.h"

#import "DDQManagerMineFirstSectionCell.h"
#import "DDQManagerMineSecondSectionCell.h"

@interface DDQManagerMineController () <DDQMineCellDelegate>


@end

@implementation DDQManagerMineController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //TableView
    [self base_tableViewConfig];
    
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    self.base_tableView.frame = CGRectMake(0.0, -20.0, self.view.width, self.view.height + 20.0);
    
}

- (DDQBaseNavigationBarStyle)base_navigationBarStyle {
    
    return DDQBaseNavigationBarStyleHiddenBar;
    
}

- (void)base_tableViewConfig {
    
    [super base_tableViewConfig];
    
    self.base_tableView.view_autoLayout = NO;
    
    [self.base_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"footer"];

    DDQBaseCellModel *firstModel = [DDQBaseCellModel new];
    DDQBaseCellModel *secondModel = [DDQBaseCellModel new];
    DDQWeakObject(self);
    [self.base_tableView tableView_setFooterHeightConfig:^CGFloat(NSInteger section) {
        
        return (section == 1) ? 115.0 * weakObjc.base_widthRate : 0.0;
        
    }];
    
    [self.base_tableView tableView_setFooterViewConfig:^__kindof UIView * _Nullable(NSInteger section, DDQFoundationTableView * _Nonnull tableView) {
        
        UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer"];
        
        UIButton *logoutButton = [footerView.contentView viewWithTag:1];
        if (!logoutButton) {
            
            logoutButton = [UIButton buttonChangeFont:DDQFont(15.) titleColor:footerView.defaultBlueColor image:nil backgroundImage:nil title:@"退出登录" attributeTitle:nil target:weakObjc sel:@selector(manager_didSelectLogout)];
            logoutButton.tag = 1;
            [logoutButton view_hanlderLayerWithRadius:3.0 borderWidth:1.0 borderColor:footerView.defaultBlueColor];
            [footerView.contentView addSubview:logoutButton];
            
        }
        
        [logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.mas_equalTo(UIEdgeInsetsMake(65.0 * weakObjc.base_widthRate, 10.0 * weakObjc.base_widthRate, 0.0, 10.0 * weakObjc.base_widthRate));
            
        }];
        return footerView;
        
    }];
    
    [self.base_tableView tableView_setCellHeightConfig:^CGFloat(NSIndexPath * _Nonnull indexPath) {
        
        if (indexPath.section == 0) {
            
            return [DDQManagerMineFirstSectionCell cell_getCellHeightWithModel:firstModel];
            
        }
        return [DDQManagerMineSecondSectionCell cell_getCellHeightWithModel:secondModel];
        
    }];
    
    [self.base_tableView tableView_setCellConfig:^__kindof UITableViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, DDQFoundationTableView * _Nonnull tableView) {
        
        if (indexPath.section == 0) {
            
            DDQManagerMineFirstSectionCell *firstCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_reuseDataSource[NSStringFromClass([DDQManagerMineFirstSectionCell class])] forIndexPath:indexPath];
            [firstCell cell_updateDataWithModel:firstModel];
            return firstCell;

        }
        
        DDQManagerMineSecondSectionCell *secondCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_reuseDataSource[NSStringFromClass([DDQManagerMineSecondSectionCell class])] forIndexPath:indexPath];
        [secondCell cell_updateDataWithModel:secondModel];
        secondCell.delegate = weakObjc;
        return secondCell;

    }];
}

- (DDQFoundationTableViewLayout *)base_tableViewLayout {
    
    DDQFoundationTableViewLayout *layout = [super base_tableViewLayout];
    
    DDQFoundationControllerCellIdentifier const DDQManagerFirstSectionCellID = @"Manager.FisrtID";
    DDQFoundationControllerCellIdentifier const DDQManagerSecondSectionCellID = @"Manager.SecondID";
    layout.layout_reuseDataSource = @{NSStringFromClass([DDQManagerMineFirstSectionCell class]):DDQManagerFirstSectionCellID, NSStringFromClass([DDQManagerMineSecondSectionCell class]):DDQManagerSecondSectionCellID};
    layout.layout_rowCount = 1;
    layout.layout_sectionCount = 2;
    
    return layout;
    
}

/**
 点击退出登录
 */
- (void)manager_didSelectLogout {
    
    
}

#pragma mark - Custom Delegate
- (void)third_manager_didSelectOperation:(DDQMineThirdSection_Manager_Operation)operation {
    
    if (operation == DDQMineThirdSection_Manager_Operation_Register) {
        
        [self base_handleInitializeWithControllerClass:[DDQRegisterReviewController class] FromNib:NO title:nil propertys:nil];
        
    } else if (operation == DDQMineThirdSection_Manager_Operation_Base) {
        
        [self base_handleInitializeWithControllerClass:[DDQBaseReviewController class] FromNib:NO title:nil propertys:nil];
        
    } else if (operation == DDQMineThirdSection_Manager_Operation_Activity) {
        
        [self base_handleInitializeWithControllerClass:[DDQActivityReviewController class] FromNib:NO title:nil propertys:nil];
        
    }
}
@end
