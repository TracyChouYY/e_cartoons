//
//  DDQWriteEvaluateController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/2.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQWriteEvaluateController.h"

#import "DDQWriteFirstSectionCell.h"
#import "DDQWriteSecondSectionCell.h"

@interface DDQWriteEvaluateController ()

@property (nonatomic, strong) NSMutableArray *write_dataSource;

@end

@implementation DDQWriteEvaluateController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.write_dataSource = [NSMutableArray arrayWithCapacity:2];
    [self.write_dataSource addObject:[DDQBaseCellModel new]];
    [self.write_dataSource addObject:[DDQBaseCellModel new]];

    //TableView
    [self base_tableViewConfig];
    
}

- (NSString *)base_navigationTitle {
    
    return @"发布评价";
    
}

- (void)base_tableViewConfig {
    
    [super base_tableViewConfig];
    
    self.base_tableView.backgroundColor = [UIColor whiteColor];
    [self.base_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"footer"];
    
    DDQWeakObject(self);
    
    [self.base_tableView tableView_setFooterHeightConfig:^CGFloat(NSInteger section) {
        
        return (section == 0) ? 0.0 : 100.0 * weakObjc.base_widthRate;
        
    }];
    
    [self.base_tableView tableView_setFooterViewConfig:^__kindof UIView * _Nullable(NSInteger section, DDQFoundationTableView * _Nonnull tableView) {
        
        if (section == 0) return nil;
        
        UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer"];
        headerView.contentView.backgroundColor = [UIColor whiteColor];
        
        UIButton *button = [headerView.contentView viewWithTag:1];
        if (!button) {
            
            button = [UIButton buttonChangeFont:DDQFont(14.0) titleColor:[UIColor whiteColor] image:nil backgroundImage:nil title:@"提交" attributeTitle:nil target:weakObjc sel:@selector(write_didSelectSubmit)];
            [headerView.contentView addSubview:button];
            button.tag = 1;
            button.backgroundColor = headerView.defaultBlueColor;
            button.layer.cornerRadius = 3.0;
            
        }
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.mas_equalTo(UIEdgeInsetsMake(60.0 * weakObjc.base_widthRate, 15.0 * weakObjc.base_widthRate, 0.0, 15.0 * weakObjc.base_widthRate));
            
        }];
        
        return headerView;
        
    }];
    
    [self.base_tableView tableView_setCellHeightConfig:^CGFloat(NSIndexPath * _Nonnull indexPath) {
        
        return [DDQCell cell_getCellHeightWithModel:weakObjc.write_dataSource[indexPath.section]];
        
    }];
    
    [self.base_tableView tableView_setCellConfig:^__kindof UITableViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, DDQFoundationTableView * _Nonnull tableView) {
        
        if (indexPath.section == 0) {
            
            DDQWriteFirstSectionCell *firstCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_reuseDataSource[NSStringFromClass([DDQWriteFirstSectionCell class])]];
            [firstCell cell_updateDataWithModel:weakObjc.write_dataSource[indexPath.section]];
            firstCell.cell_separatorStyle = DDQTableViewCellSeparatorStyleBottom;
            firstCell.cell_separatorMargin = DDQSeparatorMarginMaker(firstCell.cell_defaultLeftMargin, firstCell.cell_defaultLeftMargin);
            return firstCell;

        }
        
        DDQWriteSecondSectionCell *secondCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_reuseDataSource[NSStringFromClass([DDQWriteSecondSectionCell class])]];
        [secondCell cell_updateDataWithModel:weakObjc.write_dataSource[indexPath.section]];
        return secondCell;

    }];
}

- (DDQFoundationTableViewLayout *)base_tableViewLayout {
    
    DDQFoundationTableViewLayout *layout = [super base_tableViewLayout];
    
    DDQFoundationControllerCellIdentifier const DDQFirstSectionID = @"first.section";
    DDQFoundationControllerCellIdentifier const DDQSecondSectionID = @"second.section";
    layout.layout_reuseDataSource = @{NSStringFromClass([DDQWriteFirstSectionCell class]):DDQFirstSectionID,
                                      NSStringFromClass([DDQWriteSecondSectionCell class]):DDQSecondSectionID
                                      };
    layout.layout_sectionCount = self.write_dataSource.count;
    layout.layout_rowCount = 1;

    return layout;
    
}

/**
 点击提交
 */
- (void)write_didSelectSubmit {
    
    
}

@end
