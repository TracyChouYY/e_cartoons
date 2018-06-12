//
//  DDQSettleController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/2.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQSettleController.h"

#import "DDQSettleBottomView.h"

#import "DDQJoinCell.h"
#import "DDQPurchaseCell.h"
#import "DDQSettleThirdSectionCell.h"
#import "DDQSettleFourthSectionCell.h"
#import "DDQSettleSecondSectionCell.h"

@interface DDQSettleController () <DDQSettleBottomViewDelegate>

@property (nonatomic, strong) DDQSettleBottomView *settle_bottomView;
@property (nonatomic, strong) NSMutableArray<NSArray *> *settle_dataSource;
@property (nonatomic, assign) DDQFourthSettleWay settle_select_way;

@end

@implementation DDQSettleController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.settle_dataSource = [NSMutableArray arrayWithCapacity:4];
    [self.settle_dataSource addObject:@[[DDQSettleFirstSectionModel new]]];
    [self.settle_dataSource addObject:@[[DDQBaseCellModel new]]];
    [self.settle_dataSource addObject:@[[DDQBaseCellModel new]]];
    NSString *titleKey = @"title";
    NSString *wayKey = @"way";
    [self.settle_dataSource addObject:@[[DDQSettleWayModel mj_objectWithKeyValues:@{titleKey:@"支付宝支付", wayKey:@(DDQFourthSettleWayAL)}],
                                        [DDQSettleWayModel mj_objectWithKeyValues:@{titleKey:@"微信支付", wayKey:@(DDQFourthSettleWayWX)}],
                                        [DDQSettleWayModel mj_objectWithKeyValues:@{titleKey:@"余额支付", wayKey:@(DDQFourthSettleWayOverage)}]
                                        ]];
    self.settle_select_way = DDQFourthSettleWayUnknown;
    
    //TableView
    [self base_tableViewConfig];
    
    //NetRequest
    [self settle_netRequest];
    
}

- (NSString *)base_navigationTitle {
    
    return @"订单信息";
    
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    self.settle_bottomView.frame = CGRectMake(0.0, self.view.height - self.base_safeBottomInset - 49.0, self.view.width, 49.0);
    self.base_tableView.frame = CGRectMake(0.0, self.base_safeTopInset, self.view.width, self.settle_bottomView.y - self.base_safeTopInset);
    
}

- (void)base_tableViewConfig {
    
    [super base_tableViewConfig];
    
    self.base_tableView.view_autoLayout = NO;
    self.settle_bottomView = [[DDQSettleBottomView alloc] initBottomViewWithButtonTitle:@"提交订单"];
    [self.view addSubview:self.settle_bottomView];
    self.settle_bottomView.delegate = self;
    
    [self.base_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"header"];
    
    DDQWeakObject(self);
    [self.base_tableView tableView_setHeaderHeightConfig:^CGFloat(NSInteger section) {
        
        return (section == weakObjc.settle_dataSource.count - 1) ? 45.0 * weakObjc.base_widthRate : 0.0;
        
    }];
    
    [self.base_tableView tableView_setHeaderViewConfig:^__kindof UIView * _Nullable(NSInteger section, DDQFoundationTableView * _Nonnull tableView) {
        
        if (section != weakObjc.settle_dataSource.count - 1) return nil;
        
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
        headerView.contentView.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [headerView.contentView viewWithTag:1];
        if (!label) {
            
            label = [UILabel labelChangeText:@"支付方式" font:DDQFont(14.0) textColor:headerView.defaultBlackColor];
            [headerView.contentView addSubview:label];
            label.tag = 1;
            
        }
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(headerView.contentView.mas_left).offset(15.0 * weakObjc.base_widthRate);
            make.centerY.equalTo(headerView.contentView.mas_centerY);
            
        }];
        
        return headerView;
        
    }];
    
    [self.base_tableView tableView_setRowConfig:^NSInteger(NSInteger section) {
        
        return weakObjc.settle_dataSource[section].count;

    }];
    
    [self.base_tableView tableView_setCellHeightConfig:^CGFloat(NSIndexPath * _Nonnull indexPath) {
        
        return [DDQCell cell_getCellHeightWithModel:weakObjc.settle_dataSource[indexPath.section][indexPath.row]];
        
    }];

    [self.base_tableView tableView_setCellConfig:^__kindof UITableViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, DDQFoundationTableView * _Nonnull tableView) {
        
        if (indexPath.section == 0) {
            
            NSString *className = weakObjc.settle_type == DDQSettleTypeBase ? NSStringFromClass([DDQPurchaseCell class]) : NSStringFromClass([DDQJoinCell class]);
            DDQSettleFirstSectionCell *firstCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_reuseDataSource[className] forIndexPath:indexPath];
            [firstCell cell_updateDataWithModel:weakObjc.settle_dataSource[indexPath.section][indexPath.row]];
            return firstCell;

        } else if (indexPath.section == 1) {
            
            DDQSettleSecondSectionCell *secondCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_reuseDataSource[NSStringFromClass([DDQSettleSecondSectionCell class])]];
            [secondCell cell_updateDataWithModel:weakObjc.settle_dataSource[indexPath.section][indexPath.row]];
            [secondCell second_notificationWhenNumberChange:^(NSInteger number) {
                
                weakObjc.settle_bottomView.bottom_totalPrice = weakObjc.settle_bottomView.bottom_price * number;
                weakObjc.settle_bottomView.bottom_number = number;
                
            }];
            return secondCell;

        } else if (indexPath.section == 2) {
            
            DDQSettleThirdSectionCell *thirdCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_reuseDataSource[NSStringFromClass([DDQSettleThirdSectionCell class])]];
            [thirdCell cell_updateDataWithModel:weakObjc.settle_dataSource[indexPath.section][indexPath.row]];
            return thirdCell;

        }
        
        DDQSettleFourthSectionCell *fourthCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_reuseDataSource[NSStringFromClass([DDQSettleFourthSectionCell class])]];
        [fourthCell cell_updateDataWithModel:weakObjc.settle_dataSource[indexPath.section][indexPath.row]];
        
        if (indexPath.row == 0) {
            
            fourthCell.cell_separatorStyle = DDQTableViewCellSeparatorStyleTop;
            fourthCell.cell_separatorMargin = DDQSeparatorMarginZero;
            
        } else if (indexPath.row == weakObjc.settle_dataSource[indexPath.section].count - 1) {
            
            fourthCell.cell_separatorStyle = DDQTableViewCellSeparatorStyleNone;
            
        } else {
            
            fourthCell.cell_separatorStyle = DDQTableViewCellSeparatorStyleTopAndBottom;
            
        }
        return fourthCell;

    }];
    
    [self.base_tableView tableView_setDidSelectConfig:^(NSIndexPath * _Nonnull indexPath) {
        
        if (indexPath.section != weakObjc.settle_dataSource.count - 1) return;
        
        DDQSettleFourthSectionCell *cell = [weakObjc.base_tableView cellForRowAtIndexPath:indexPath];
        DDQSettleWayModel *model = cell.cell_model;
        weakObjc.settle_select_way = model.way;
        [cell setSelected:YES];
        
    }];
    
    [self.base_tableView tableView_setDidDeselectConfig:^(NSIndexPath * _Nonnull indexPath) {
        
        if (indexPath.section != weakObjc.settle_dataSource.count - 1) return;
        
        DDQSettleFourthSectionCell *cell = [weakObjc.base_tableView cellForRowAtIndexPath:indexPath];
        [cell setSelected:NO];

    }];
}

- (DDQFoundationTableViewLayout *)base_tableViewLayout {
    
    DDQFoundationTableViewLayout *layout = [super base_tableViewLayout];
    
    DDQFoundationControllerCellIdentifier const DDQFirstSectionCellID = @"first.id";
    DDQFoundationControllerCellIdentifier const DDQSecondSectionCellID = @"second.id";
    DDQFoundationControllerCellIdentifier const DDQThirdSectionCellID = @"third.id";
    DDQFoundationControllerCellIdentifier const DDQFourthSectionCellID = @"fourth.id";
    
    NSString *firsCellClass = (self.settle_type == DDQSettleTypeBase) ? NSStringFromClass([DDQPurchaseCell class]) : NSStringFromClass([DDQJoinCell class]);
    layout.layout_reuseDataSource = @{firsCellClass:DDQFirstSectionCellID,
                                      NSStringFromClass([DDQSettleSecondSectionCell class]):DDQSecondSectionCellID,
                                      NSStringFromClass([DDQSettleThirdSectionCell class]):DDQThirdSectionCellID,
                                      NSStringFromClass([DDQSettleFourthSectionCell class]):DDQFourthSectionCellID
                                      };
    layout.layout_sectionCount = self.settle_dataSource.count;
    layout.layout_footerHeight = 10.0;
    
    return layout;
    
}

/**
 网络请求
 */
- (void)settle_netRequest {
    
    DDQWeakObject(self);
    NSString *requestUrl = [self.base_url stringByAppendingString:@"UserApi/orderhd"];
    NSString *paramKey = (self.settle_type == DDQSettleTypeBase) ? @"bid" : @"aid";
    NSString *paramValue = [self base_handleFindURLDataWithKey:paramKey url:self.settle_url];
    [self foundation_processNetPOSTRequestWithUrl:requestUrl Param:@{paramKey:paramValue, @"uid":self.base_userID} WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
        
        if (code == 1) {
            
            NSDictionary *listDic = [weakObjc base_handleRequestDataIfLegal:[response valueForKey:@"list"] targetClass:[NSDictionary class]];
            DDQSettleFirstSectionModel *model = [DDQSettleFirstSectionModel mj_objectWithKeyValues:listDic];
            model.image = [weakObjc.base_imageUrl stringByAppendingString:model.image];
            [weakObjc.settle_dataSource replaceObjectAtIndex:0 withObject:@[model]];
            [weakObjc base_reloadTableViewWithSection:0];
            
            weakObjc.settle_bottomView.bottom_price = model.price.floatValue;
            weakObjc.settle_bottomView.bottom_totalPrice = model.price.floatValue;
            return NO;
        }
        return YES;
        
    }];
}

#pragma mark - Bottom View Delegate
- (void)settle_didSelectSureWithView:(DDQSettleBottomView *)view {
    
    if (self.settle_select_way == DDQFourthSettleWayUnknown) {
        
        [self alertHUDWithText:@"请选择支付方式！" Delegate:nil];return;
        
    }
    
#warning 优惠券不应该是必填项
    NSString *requestUrl = [self.base_url stringByAppendingString:@"UserApi/order"];
    NSString *wayText = nil;
    if (self.settle_select_way == DDQFourthSettleWayAL) {
        
        wayText = @"1";
        
    } else if (self.settle_select_way == DDQFourthSettleWayWX) {
        
        wayText = @"2";
        
    } else {
        
        wayText = @"3";
        
    }
    
    NSString *paramKey = (self.settle_type == DDQSettleTypeBase) ? @"bid" : @"aid";
    NSString *paramValue = [self base_handleFindURLDataWithKey:paramKey url:self.settle_url];
    NSDictionary *requestParam = @{@"uid":self.base_userID, @"num":@(self.settle_bottomView.bottom_number).stringValue, @"total":@(self.settle_bottomView.bottom_totalPrice), @"pay":wayText, paramKey:paramValue, @"cid":@""};
    [self foundation_processNetPOSTRequestWithUrl:requestUrl Param:requestParam WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
        
        return YES;
        
    }];
}

@end
