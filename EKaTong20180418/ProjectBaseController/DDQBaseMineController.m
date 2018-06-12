//
//  DDQBaseMineController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/20.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBaseMineController.h"

#import "DDQIssueController.h"
#import "DDQBaseIssueController.h"
#import "DDQActivityIssueController.h"
#import "DDQBaseManagementController.h"
#import "DDQActivityManagementController.h"

#import "DDQBaseMineFirstSectionCell.h"
#import "DDQBaseMineSecondSectionCell.h"

@interface DDQBaseMineController () <DDQMineCellDelegate>

@property (nonatomic, copy) NSArray<NSArray *> *mine_dataSource;

@end

@implementation DDQBaseMineController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //DataSource
    NSString *username = (self.base_infomationManager.uname.length > 0) ? self.base_infomationManager.uname : [self base_handleSecureEntryWithPhoneNumber:self.base_infomationManager.phone];
    self.mine_dataSource = @[@[[DDQMineFirstSectionModel mj_objectWithKeyValues:@{@"image":self.base_infomationManager.image, @"nickname":username}]],
                             @[[DDQBaseCellModel new]]];
    
    //TableView
    [self base_tableViewConfig];
    
    //NetRequest
    [self base_netRequestCompleted:nil];
    
    DDQWeakObject(self);
    //Refresh
    [self.class foundation_setHeaderWithView:self.base_tableView Stlye:DDQFoundationHeaderStyleNormal Handle:^{
        
        [weakObjc base_netRequestCompleted:^{
            
            [weakObjc.base_tableView foundation_endRefreshing];
            
        }];
    }];
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
    
    [self.base_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header"];
    
    DDQWeakObject(self);
    [self.base_tableView tableView_setFooterHeightConfig:^CGFloat(NSInteger section) {
        
        return (section == 1) ? 115.0 * weakObjc.base_widthRate : 0.0;

    }];
    
    [self.base_tableView tableView_setFooterViewConfig:^__kindof UIView * _Nullable(NSInteger section, DDQFoundationTableView * _Nonnull tableView) {
        
        UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
        
        UIButton *logoutButton = [footerView.contentView viewWithTag:1];
        if (!logoutButton) {
            
            logoutButton = [UIButton buttonChangeFont:DDQFont(15.0) titleColor:footerView.defaultBlueColor image:nil backgroundImage:nil title:@"退出登录" attributeTitle:nil target:weakObjc sel:@selector(base_didSelectLogout)];
            logoutButton.tag = 1;
            [logoutButton view_hanlderLayerWithRadius:3.0 borderWidth:1.0 borderColor:footerView.defaultBlueColor];
            [footerView.contentView addSubview:logoutButton];
        }
        
        [logoutButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.mas_equalTo(UIEdgeInsetsMake(65.0 * weakObjc.base_widthRate, 10.0 * weakObjc.base_widthRate, 0.0, 10.0 * weakObjc.base_widthRate));

        }];
        return footerView;
        
    }];
    
    [self.base_tableView tableView_setRowConfig:^NSInteger(NSInteger section) {
        
        return weakObjc.mine_dataSource[section].count;
        
    }];

    [self.base_tableView tableView_setCellHeightConfig:^CGFloat(NSIndexPath * _Nonnull indexPath) {
        
        return [DDQCell cell_getCellHeightWithModel:weakObjc.mine_dataSource[indexPath.section][indexPath.row]];
        
    }];
    
    [self.base_tableView tableView_setCellConfig:^__kindof UITableViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, DDQFoundationTableView * _Nonnull tableView) {
        
        if (indexPath.section == 0) {
            
            DDQBaseMineFirstSectionCell *firstCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_reuseDataSource[NSStringFromClass([DDQBaseMineFirstSectionCell class])] forIndexPath:indexPath];
            [firstCell cell_updateDataWithModel:weakObjc.mine_dataSource[indexPath.section][indexPath.row]];
            firstCell.delegate = weakObjc;
            return firstCell;

        }
        
        DDQBaseMineSecondSectionCell *secondCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_reuseDataSource[NSStringFromClass([DDQBaseMineSecondSectionCell class])] forIndexPath:indexPath];
        [secondCell cell_updateDataWithModel:weakObjc.mine_dataSource[indexPath.section][indexPath.row]];
        secondCell.delegate = weakObjc;
        
        return secondCell;

    }];
}

- (DDQFoundationTableViewLayout *)base_tableViewLayout {
    
    DDQFoundationTableViewLayout *layout = [super base_tableViewLayout];
    
    DDQFoundationControllerCellIdentifier const DDQFirstSectionCellID = @"first.id";
    DDQFoundationControllerCellIdentifier const DDQSecondSectionCellID = @"second.id";
    
    layout.layout_reuseDataSource = @{NSStringFromClass([DDQBaseMineFirstSectionCell class]):DDQFirstSectionCellID, NSStringFromClass([DDQBaseMineSecondSectionCell class]):DDQSecondSectionCellID};
    layout.layout_sectionCount = self.mine_dataSource.count;
    
    return layout;
    
}

/**
 点击退出登录
 */
- (void)base_didSelectLogout {
    
    DDQWeakObject(self);
    [self base_presentAlertControllerWithTitle:@"提示" message:@"您真的要退出当前账号吗？" style:DDQAlertControllerStyleAlert cancel:nil sure:^{
        
        [weakObjc base_handleUserLogoutCompleted:^{
            
            [DDQNotificationCenter postNotificationName:DDQLogoutSuccessNotification object:nil];
            
        }];
    }];
}

/**
 处理控制器的模态流程
 */
- (void)base_handleControllerPresentWithClass:(Class)class {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self base_handleInitializeWithControllerClass:class FromNib:NO title:nil propertys:nil];
    
}

/**
 网络请求
 */
- (void)base_netRequestCompleted:(void(^)(void))completed {
    
    DDQWeakObject(self);
    NSString *requestUrl = [self.base_url stringByAppendingString:@"UserApi/bpersonal"];
    [self foundation_processNetPOSTRequestWithUrl:requestUrl Param:@{@"uid":self.base_userID} WaitHud:nil ShowHud:NO WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
        
        if (completed) {
            
            completed();
            
        }
        
        if (code == 1) {
            
            [weakObjc base_handleUserInfomationWithData:response];
            
            DDQMineFirstSectionModel *model = weakObjc.mine_dataSource.firstObject.firstObject;
            model.jrxs = weakObjc.base_infomationManager.jrxs;
            model.ljxs = weakObjc.base_infomationManager.ljxs;
            model.wdcf = weakObjc.base_infomationManager.wdcf;
            
            [weakObjc.base_tableView reloadData];
            return NO;
            
        }
        return YES;
        
    } AfterAlert:nil];
}

#pragma mark - Custom Cell Delegate
- (void)first_didSelectToRightCornerButtonWithStyle:(DDQMineFirstSectionCellStyle)style {
    
    if (DDQMineFirstSectionCellStyleBase) {
        
        DDQIssueController *issueC = [self base_initializeControllerClass:[DDQIssueController class] FromNib:NO Title:nil];
        [self presentViewController:issueC animated:YES completion:nil];
        
        DDQWeakObject(self);
        [issueC issue_didSelectBase:^{

            [weakObjc base_handleControllerPresentWithClass:[DDQBaseIssueController class]];
            
        }];
        
        [issueC issue_didSelectActivity:^{
            
            [weakObjc base_handleControllerPresentWithClass:[DDQActivityIssueController class]];

        }];
    }
}

- (void)third_base_didSelectOperation:(DDQMineThirdSection_Base_Operation)operation {
    
    if (operation == DDQMineThirdSection_Base_Operation_Base) {
        
        [self base_handleInitializeWithControllerClass:[DDQBaseManagementController class] FromNib:NO title:nil propertys:nil];
        
    } else if (operation == DDQMineThirdSection_Base_Operation_Activity) {
        
        [self base_handleInitializeWithControllerClass:[DDQActivityManagementController class] FromNib:NO title:nil propertys:nil];

    }
}

@end
