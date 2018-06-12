//
//  DDQMyWalletController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/26.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQMyWalletController.h"

#import "DDQWalletFirstSectionCell.h"
#import "DDQWalletThirdSectionCell.h"
#import "DDQWalletSecondSectionCell.h"

@interface DDQMyWalletController ()

@property (nonatomic, strong) NSMutableArray<NSArray *> *wallet_dataSource;

@end

@implementation DDQMyWalletController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSString *imageKey = @"image";
    NSString *titleKey = @"title";
    NSArray *data = @[
  @[[DDQBaseCellModel new]],
  @[[DDQBaseCellModel new]],
  @[[DDQWalletWayModel mj_objectWithKeyValues:@{imageKey:@"wallet_wx", titleKey:@"微信支付"}],
    [DDQWalletWayModel mj_objectWithKeyValues:@{imageKey:@"wallet_al", titleKey:@"支付宝支付"}]]];
    self.wallet_dataSource = [NSMutableArray arrayWithArray:data];
    
    //TableView
    [self base_tableViewConfig];
    
}

- (NSString *)base_navigationTitle {
    
    return @"我的钱包";

}

- (void)base_tableViewConfig {
    
    [super base_tableViewConfig];
    
    [self.base_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"footer"];
    
    DDQWeakObject(self);
    [self.base_tableView tableView_setRowConfig:^NSInteger(NSInteger section) {
        
        return weakObjc.wallet_dataSource[section].count;
        
    }];
    
    [self.base_tableView tableView_setFooterHeightConfig:^CGFloat(NSInteger section) {
        
        return section == weakObjc.wallet_dataSource.count - 1 ? 80.0 * weakObjc.base_widthRate : 0.0;
        
    }];
    
    [self.base_tableView tableView_setFooterViewConfig:^__kindof UIView * _Nullable(NSInteger section, DDQFoundationTableView * _Nonnull tableView) {
        
        if (section != weakObjc.wallet_dataSource.count - 1) return nil;
        
        UITableViewHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer"];
        
        UIButton *sureButton = [footer.contentView viewWithTag:1];
        if (!sureButton) {
            
            sureButton = [UIButton buttonChangeFont:DDQFont(14.0) titleColor:[UIColor whiteColor] image:nil backgroundImage:nil title:@"确认充值" attributeTitle:nil target:weakObjc sel:@selector(wallet_didSelectSureRecharge)];
            sureButton.tag = 1;
            [footer.contentView addSubview:sureButton];
            sureButton.layer.cornerRadius = 3.0;
            sureButton.backgroundColor = footer.defaultBlueColor;
            
        }
        
        [sureButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.mas_equalTo(UIEdgeInsetsMake(20.0 * weakObjc.base_widthRate, 15.0 * weakObjc.base_widthRate, 15.0 * weakObjc.base_widthRate, 15.0 * weakObjc.base_widthRate));
            
        }];
        
        return footer;
        
    }];
    
    [self.base_tableView tableView_setCellHeightConfig:^CGFloat(NSIndexPath * _Nonnull indexPath) {
        
        return [DDQCell cell_getCellHeightWithModel:weakObjc.wallet_dataSource[indexPath.section][indexPath.row]];
        
    }];
    
    [self.base_tableView tableView_setCellConfig:^__kindof UITableViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, DDQFoundationTableView * _Nonnull tableView) {
       
        if (indexPath.section == 0) {
            
            DDQWalletFirstSectionCell *firstCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_reuseDataSource[NSStringFromClass([DDQWalletFirstSectionCell class])]];
            [firstCell cell_updateDataWithModel:weakObjc.wallet_dataSource[indexPath.section][indexPath.row]];
            return firstCell;
            
        } else if (indexPath.section == 1) {
            
            DDQWalletSecondSectionCell *secondCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_reuseDataSource[NSStringFromClass([DDQWalletSecondSectionCell class])]];
            [secondCell cell_updateDataWithModel:weakObjc.wallet_dataSource[indexPath.section][indexPath.row]];
            
            secondCell.cell_separatorStyle = DDQTableViewCellSeparatorStyleBottom;
            secondCell.cell_separatorMargin = DDQSeparatorMarginMaker(0.0, 0.0);
            secondCell.cell_separatorColor = secondCell.defaultSeparatorColor;
            
            return secondCell;

        }
        
        DDQWalletThirdSectionCell *thirdCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_reuseDataSource[NSStringFromClass([DDQWalletThirdSectionCell class])]];
        [thirdCell cell_updateDataWithModel:weakObjc.wallet_dataSource[indexPath.section][indexPath.row]];
        return thirdCell;
        
    }];
}

- (DDQFoundationTableViewLayout *)base_tableViewLayout {
    
    DDQFoundationTableViewLayout *layout = [super base_tableViewLayout];
    
    DDQFoundationControllerCellIdentifier const FirstSectionID = @"First";
    DDQFoundationControllerCellIdentifier const SecondSectionID = @"Second";
    DDQFoundationControllerCellIdentifier const ThirdSectionID = @"Third";

    layout.layout_reuseDataSource = @{NSStringFromClass([DDQWalletFirstSectionCell class]):FirstSectionID,
                                      NSStringFromClass([DDQWalletSecondSectionCell class]):SecondSectionID,
                                      NSStringFromClass([DDQWalletThirdSectionCell class]):ThirdSectionID
                                      };
    layout.layout_sectionCount = self.wallet_dataSource.count;

    return layout;
    
}

/**
 点击确认充值
 */
- (void)wallet_didSelectSureRecharge {
    
    
}

@end
