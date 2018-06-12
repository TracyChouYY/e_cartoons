//
//  DDQMineController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/20.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQMineController.h"

#import "DDQSetController.h"
#import "DDQMyPointController.h"
#import "DDQMyCouponController.h"
#import "DDQUserInfoController.h"
#import "DDQMyWalletController.h"
#import "DDQMyVoucherController.h"
#import "DDQSuggestionsController.h"
#import "DDQMyCollectionController.h"
#import "DDQMemberCenterController.h"
#import "DDQOrderContainerController.h"
#import "DDQEvaluateContainerController.h"

#import "DDQMineFirstSectionCell.h"
#import "DDQMineThirdSectionCell.h"
#import "DDQMineSecondSectionCell.h"

@interface DDQMineController () <DDQMineCellDelegate>

@property (nonatomic, strong) NSMutableArray<NSArray *> *mine_dataSource;

@end

@implementation DDQMineController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //DataSource
    self.mine_dataSource = @[@[[DDQMineFirstSectionModel mj_objectWithKeyValues:@{@"image":self.base_infomationManager.image, @"nickname":[self mine_handleShowUserDefaultName]}]],
                             @[[DDQBaseCellModel new]],
                             @[[DDQBaseCellModel new]]].mutableCopy;
    
    //TableView
    [self base_tableViewConfig];

    //NetRequest
    [self mine_netRequest];
    
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
    
    DDQWeakObject(self);
    [self.base_tableView tableView_setRowConfig:^NSInteger(NSInteger section) {
        
        return weakObjc.mine_dataSource[section].count;
        
    }];
    
    [self.base_tableView tableView_setCellHeightConfig:^CGFloat(NSIndexPath * _Nonnull indexPath) {
        
        return [DDQCell cell_getCellHeightWithModel:weakObjc.mine_dataSource[indexPath.section][indexPath.row]];
        
    }];
    
    [self.base_tableView tableView_setCellConfig:^__kindof UITableViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, DDQFoundationTableView * _Nonnull tableView) {
        
        if (indexPath.section == 0) {
            
            DDQMineFirstSectionCell *firstCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_reuseDataSource[NSStringFromClass([DDQMineFirstSectionCell class])] forIndexPath:indexPath];
            [firstCell cell_updateDataWithModel:weakObjc.mine_dataSource[indexPath.section][indexPath.row]];
            
            firstCell.delegate = weakObjc;
            return firstCell;

        } else if (indexPath.section == 1) {
            
            DDQMineSecondSectionCell *secondCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_reuseDataSource[NSStringFromClass([DDQMineSecondSectionCell class])] forIndexPath:indexPath];
            [secondCell cell_updateDataWithModel:weakObjc.mine_dataSource[indexPath.section][indexPath.row]];
            secondCell.delegate = weakObjc;
            return secondCell;

        }
        
        DDQMineThirdSectionCell *thirdCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_reuseDataSource[NSStringFromClass([DDQMineThirdSectionCell class])] forIndexPath:indexPath];
        [thirdCell cell_updateDataWithModel:weakObjc.mine_dataSource[indexPath.section][indexPath.row]];
        thirdCell.delegate = weakObjc;
        return thirdCell;

    }];
}

- (DDQFoundationTableViewLayout *)base_tableViewLayout {
    
    DDQFoundationTableViewLayout *layout = [super base_tableViewLayout];
    
    DDQFoundationControllerCellIdentifier const DDQMineFirstSectionCellID = @"Mine_FirstID";
    DDQFoundationControllerCellIdentifier const DDQMineSecondSectionCellID = @"Mine_SecondID";
    DDQFoundationControllerCellIdentifier const DDQMineThirdSectionCellID = @"Mine_ThirdID";
    
    layout.layout_reuseDataSource = @{NSStringFromClass([DDQMineFirstSectionCell class]):DDQMineFirstSectionCellID,
                                      NSStringFromClass([DDQMineSecondSectionCell class]):DDQMineSecondSectionCellID,
                                      NSStringFromClass([DDQMineThirdSectionCell class]):DDQMineThirdSectionCellID};
    layout.layout_sectionCount = self.mine_dataSource.count;
    layout.layout_rowCount = 1;
    
    return layout;
    
}

- (void)base_handleWhenInformationKeyValueChange:(DDQUserInformationManager *)manager {
    
    if ([manager.information_changeKeys containsObject:@"image"] || [manager.information_changeKeys containsObject:@"uname"]) {

        DDQMineFirstSectionModel *model = self.mine_dataSource.firstObject.firstObject;
        model.image = manager.image;
        model.nickname = [self mine_handleShowUserDefaultName];
        [self base_reloadTableViewWithSection:0];
        
    }
}

/**
 网络请求
 */
- (void)mine_netRequest {
    
    DDQWeakObject(self);
    NSString *requestUrl = [self.base_url stringByAppendingString:@"UserApi/upersonal"];
    [self foundation_processNetPOSTRequestWithUrl:requestUrl Param:@{@"uid":self.base_userID} WaitHud:nil ShowHud:NO WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
        
        if (code == 1) {
            
            [weakObjc base_handleUserInfomationWithData:response];
            return NO;
        }
        return YES;
        
    } AfterAlert:nil];
}

/**
 判断显示当前用户的用户名
 */
- (NSString *)mine_handleShowUserDefaultName {
    
    return (self.base_infomationManager.uname.length > 0) ? self.base_infomationManager.uname : [self base_handleSecureEntryWithPhoneNumber:self.base_infomationManager.phone];

}

#pragma mark - FirstSection Cell Delegate
- (void)first_didSelectUserIconWithStyle:(DDQMineFirstSectionCellStyle)style {
    
    if (style != DDQMineFirstSectionCellStylePersonal) return;
    
    [self base_handleInitializeWithControllerClass:[DDQUserInfoController class] FromNib:NO title:nil propertys:nil];
    
}

- (void)first_didSelectToRightCornerButtonWithStyle:(DDQMineFirstSectionCellStyle)style {
    
    if (style == DDQMineFirstSectionCellStyleManager) return;
    
    if (style == DDQMineFirstSectionCellStylePersonal) {
        
        [self base_handleInitializeWithControllerClass:[DDQSetController class] FromNib:NO title:nil propertys:nil];
        
    }
}

- (void)first_didSelectMemberCenter {
    
    [self base_handleInitializeWithControllerClass:[DDQMemberCenterController class] FromNib:NO title:nil propertys:nil];
    
}

- (void)first_didSelectWallet {
    
    [self base_handleInitializeWithControllerClass:[DDQMyWalletController class] FromNib:NO title:nil propertys:nil];
    
}

#pragma maek - SecondSection Cell Delegate
- (void)second_didSelctOrderOperation:(DDQMineSecondSection_Operation)operation {
    
    if (operation == DDQMineSecondSection_Operation_Evaluate) {
        
        [self base_handleInitializeWithControllerClass:[DDQEvaluateContainerController class] FromNib:NO title:nil propertys:nil];
        return;
        
    }
    
    DDQOrderContainerStatus status = DDQOrderContainerStatusAll;
    switch (operation) {
            
        case DDQMineSecondSection_Operation_Unpaid:
            status = DDQOrderContainerStatusUnpaid;
            break;
            
        case DDQMineSecondSection_Operation_Finished:
            status = DDQOrderContainerStatusFinished;
            break;

        case DDQMineSecondSection_Operation_Paid:
            status = DDQOrderContainerStatusPaid;
            break;

        default:
            break;
    }
    
    DDQOrderContainerController *containerC = [self base_handleInitializeWithControllerClass:[DDQOrderContainerController class] FromNib:NO title:nil propertys:nil];
    containerC.order_status = status;
    
}

#pragma mark - ThirdSection Cell Delegate
- (void)third_personal_didSelectOperation:(DDQMineThirdSection_Personal_Operation)operation {
    
    if (operation == DDQMineThirdSection_Personal_Operation_Point) {
        
        [self base_handleInitializeWithControllerClass:[DDQMyPointController class] FromNib:NO title:nil propertys:nil];
        
    } else if (operation == DDQMineThirdSection_Personal_Operation_Coupon) {
        
        [self base_handleInitializeWithControllerClass:[DDQMyCouponController class] FromNib:NO title:nil propertys:nil];
        
    } else if (operation == DDQMineThirdSection_Personal_Operation_Suggestion) {
        
        [self base_handleInitializeWithControllerClass:[DDQSuggestionsController class] FromNib:NO title:nil propertys:nil];
        
    } else if (operation == DDQMineThirdSection_Personal_Operation_Collection) {
        
        [self base_handleInitializeWithControllerClass:[DDQMyCollectionController class] FromNib:NO title:nil propertys:nil];
        
    } else if (operation == DDQMineThirdSection_Personal_Operation_Voucher) {
        
        [self base_handleInitializeWithControllerClass:[DDQMyVoucherController class] FromNib:NO title:nil propertys:nil];
        
    }
}

@end
