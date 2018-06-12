//
//  DDQOrderDetailController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/1.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQOrderDetailController.h"

#import "DDQOrderDetailFirstSectionCell.h"
#import "DDQOrderDetailThirdSectionCell.h"
#import "DDQOrderDetailSecondSectionCell.h"

#import "DDQOrderDetailHeaderView.h"

@interface DDQOrderDetailController () {
    
    NSString *_titleKey;
    NSString *_modelKey;
}

@property (nonatomic, strong) NSMutableArray<NSArray *> *detail_headerDataSource;

@end

@implementation DDQOrderDetailController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    _titleKey = @"title";
    _modelKey = @"model";
    self.detail_headerDataSource = [NSMutableArray arrayWithCapacity:4];
    [self.detail_headerDataSource addObject:@[]];
    [self.detail_headerDataSource addObject:@[@{_titleKey:@"订单信息", _modelKey:[DDQBaseCellModel new]}]];
    [self.detail_headerDataSource addObject:@[@{_titleKey:@"出行信息", _modelKey:[DDQBaseCellModel new]}]];
    [self.detail_headerDataSource addObject:@[@{_titleKey:@"支付信息", _modelKey:[DDQBaseCellModel new]}]];
    
    //TableView
    [self base_tableViewConfig];
    
    self.view.backgroundColor = self.view.defaultViewBackgroundColor;
    
}

- (NSString *)base_navigationTitle {
    
    return @"订单详情";
    
}

- (void)base_tableViewConfig {
    
    [super base_tableViewConfig];
    
    NSString *normalID = @"normalHeader";
    NSString *infoID = @"infoHeader";
    [self.base_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:normalID];
    [self.base_tableView registerClass:[DDQOrderDetailHeaderView class] forHeaderFooterViewReuseIdentifier:infoID];
    
    DDQWeakObject(self);
    [self.base_tableView tableView_setHeaderHeightConfig:^CGFloat(NSInteger section) {
        
        return ((section == 0) ? 70.0 : 40.0) * weakObjc.base_widthRate;
        
    }];
    
    [self.base_tableView tableView_setHeaderViewConfig:^__kindof UIView * _Nullable(NSInteger section, DDQFoundationTableView * _Nonnull tableView) {
        
        if (section == 0) {
            
            UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:normalID];
            
            UIButton *button = [headerView.contentView viewWithTag:1];
            UIView *separator = [headerView.contentView viewWithTag:2];
            if (!button) {
                
                button = [UIButton buttonChangeFont:DDQFont(17.0) titleColor:headerView.defaultBlueColor image:nil backgroundImage:nil title:@"小书法家爱哦是否含水电费" attributeTitle:nil target:nil sel:nil];
                button.tag = 1;
                [headerView.contentView addSubview:button];
                button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [button setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 15.0 * weakObjc.base_widthRate, 0.0, 0.0)];
                button.backgroundColor = [UIColor whiteColor];
                
            }
            
            if (!separator) {
                
                separator = [UIView viewChangeBackgroundColor:headerView.defaultBlueColor];
                separator.tag = 2;
                [headerView.contentView addSubview:separator];
                
            }
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.edges.mas_equalTo(UIEdgeInsetsMake(11.0, 0.0, 0.0, 0.0));
                
            }];
            
            [separator mas_makeConstraints:^(MASConstraintMaker *make) {
            
                make.bottom.equalTo(button.mas_top);
                make.width.equalTo(headerView.contentView.mas_width);
                make.height.mas_equalTo(1.0);
                make.left.equalTo(headerView.contentView.mas_left);
                
            }];
            return headerView;
            
        }
        
        NSDictionary *data = weakObjc.detail_headerDataSource[section].firstObject;
        DDQOrderDetailHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:infoID];
        headerView.header_title = data[_titleKey];
        return headerView;
        
    }];
    
    [self.base_tableView tableView_setRowConfig:^NSInteger(NSInteger section) {
        
        return weakObjc.detail_headerDataSource[section].count;
        
    }];
    
    [self.base_tableView tableView_setCellHeightConfig:^CGFloat(NSIndexPath * _Nonnull indexPath) {
        
        if (indexPath.section == 0 ) return 0.0;
        
        return [DDQCell cell_getCellHeightWithModel:weakObjc.detail_headerDataSource[indexPath.section][indexPath.row][_modelKey]];
        
    }];
    
    [self.base_tableView tableView_setCellConfig:^__kindof UITableViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, DDQFoundationTableView * _Nonnull tableView) {
        
        if (indexPath.section == 0) return nil;
        
        NSDictionary *data = weakObjc.detail_headerDataSource[indexPath.section][indexPath.row];
        
        if (indexPath.section == 1) {
            
            DDQOrderDetailFirstSectionCell *firstCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_reuseDataSource[NSStringFromClass([DDQOrderDetailFirstSectionCell class])] forIndexPath:indexPath];
            [firstCell cell_updateDataWithModel:data[_modelKey]];
            return firstCell;
            
        } else if (indexPath.section == 2) {
            
            DDQOrderDetailSecondSectionCell *secondCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_reuseDataSource[NSStringFromClass([DDQOrderDetailSecondSectionCell class])] forIndexPath:indexPath];
            [secondCell cell_updateDataWithModel:data[_modelKey]];
            return secondCell;
            
        } else {
            
            DDQOrderDetailThirdSectionCell *thirdCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_reuseDataSource[NSStringFromClass([DDQOrderDetailThirdSectionCell class])] forIndexPath:indexPath];
            [thirdCell cell_updateDataWithModel:data[_modelKey]];
            return thirdCell;

        }
    }];
}

- (DDQFoundationTableViewLayout *)base_tableViewLayout {
    
    DDQFoundationTableViewLayout *layout = [super base_tableViewLayout];
    
    DDQFoundationControllerCellIdentifier const DDQDetailFirstID = @"first.id";
    DDQFoundationControllerCellIdentifier const DDQDetailSecondID = @"second.id";
    DDQFoundationControllerCellIdentifier const DDQDetailThirdID = @"third.id";
    layout.layout_reuseDataSource = @{NSStringFromClass([DDQOrderDetailFirstSectionCell class]):DDQDetailFirstID,
                                      NSStringFromClass([DDQOrderDetailSecondSectionCell class]):DDQDetailSecondID,
                                      NSStringFromClass([DDQOrderDetailThirdSectionCell class]):DDQDetailThirdID
                                      };
    layout.layout_sectionCount = self.detail_headerDataSource.count;
    layout.layout_footerHeight = 10.0;
    
    return layout;
    
}

@end
