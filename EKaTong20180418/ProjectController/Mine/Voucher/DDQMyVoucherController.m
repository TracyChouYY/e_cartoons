//
//  DDQMyVoucherController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/27.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQMyVoucherController.h"

#import "DDQVoucherDetailController.h"

#import "DDQExamineCell.h"
#import "DDQUnexamineCell.h"

@interface DDQMyVoucherController ()

@property (nonatomic, strong) NSMutableArray *voucher_dataSource;

@end

@implementation DDQMyVoucherController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.voucher_dataSource = [NSMutableArray arrayWithArray:@[[DDQBaseCellModel new], [DDQBaseCellModel new]]];
    
    //TableView
    [self base_tableViewConfig];
    
}

- (NSString *)base_navigationTitle {
    
    return @"观演凭证";
    
}

- (void)base_tableViewConfig {
    
    [super base_tableViewConfig];
    
    self.base_tableView.backgroundColor = self.view.defaultViewBackgroundColor;
    
    DDQWeakObject(self);
    [self.base_tableView tableView_setCellHeightConfig:^CGFloat(NSIndexPath * _Nonnull indexPath) {
        
        return [DDQVoucherCell cell_getCellHeightWithModel:weakObjc.voucher_dataSource[indexPath.section]];

    }];
    
    [self.base_tableView tableView_setCellConfig:^__kindof UITableViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, DDQFoundationTableView * _Nonnull tableView) {
        
        if (indexPath.section == 0) {
            
            DDQUnexamineCell *unCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_reuseDataSource[NSStringFromClass([DDQUnexamineCell class])]];
            [unCell cell_updateDataWithModel:weakObjc.voucher_dataSource[indexPath.section]];
            return unCell;

        }
        
        DDQExamineCell *cell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_reuseDataSource[NSStringFromClass([DDQExamineCell class])]];
        [cell cell_updateDataWithModel:weakObjc.voucher_dataSource[indexPath.section]];
        return cell;

    }];
    
    [self.base_tableView tableView_setDidSelectConfig:^(NSIndexPath * _Nonnull indexPath) {
        
        [weakObjc base_handleInitializeWithControllerClass:[DDQVoucherDetailController class] FromNib:NO title:nil propertys:nil];
        
    }];
}

- (DDQFoundationTableViewLayout *)base_tableViewLayout {
    
    DDQFoundationTableViewLayout *layout = [super base_tableViewLayout];
    
    DDQFoundationControllerCellIdentifier const DDQUnexamineID = @"Unexamine";
    DDQFoundationControllerCellIdentifier const DDQExamineID = @"Examine";
    
    layout.layout_reuseDataSource = @{NSStringFromClass([DDQUnexamineCell class]):DDQUnexamineID, NSStringFromClass([DDQExamineCell class]):DDQExamineID};
    layout.layout_sectionCount = self.voucher_dataSource.count;
    layout.layout_rowCount = 1;
    layout.layout_headerHeight = 10.0 * self.base_widthRate;
    
    return layout;
    
}

@end
