//
//  DDQSuggestionsController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/27.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQSuggestionsController.h"

#import "DDQSuggestionsInputCell.h"

@interface DDQSuggestionsController ()

@end

@implementation DDQSuggestionsController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //TableView
    [self base_tableViewConfig];
    
}

- (NSString *)base_navigationTitle {
    
    return @"投诉建议";
    
}

- (void)base_tableViewConfig {
    
    [super base_tableViewConfig];
    
    self.base_tableView.backgroundColor = self.view.defaultViewBackgroundColor;
    
    [self.base_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"footer"];
    
    DDQWeakObject(self);
    [self.base_tableView tableView_setFooterViewConfig:^__kindof UIView * _Nullable(NSInteger section, DDQFoundationTableView * _Nonnull tableView) {
        
        UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer"];
        
        UIButton *button = [footerView.contentView viewWithTag:1];
        if (!button) {
            
            button = [UIButton buttonChangeFont:DDQFont(14.0) titleColor:[UIColor whiteColor] image:nil backgroundImage:nil title:@"提交" attributeTitle:nil target:weakObjc sel:@selector(suggestion_didSelectSubmit)];
            button.tag = 1;
            [footerView.contentView addSubview:button];
            button.backgroundColor = footerView.defaultBlueColor;
            button.layer.cornerRadius = 5.0;
            
        }
        
        [button mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.mas_equalTo(UIEdgeInsetsMake(0.0, 15.0 * weakObjc.base_widthRate, 0.0, 15.0 * weakObjc.base_widthRate));
        }];
        
        return footerView;
        
    }];
    
    DDQBaseCellModel *model = [DDQBaseCellModel new];
    [self.base_tableView tableView_setCellConfig:^__kindof UITableViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, DDQFoundationTableView * _Nonnull tableView) {
        
        DDQSuggestionsInputCell *inptCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_cellIdentifier];
        [inptCell cell_updateDataWithModel:model];
        tableView.tableView_layout.layout_rowHeight = [DDQSuggestionsInputCell cell_getCellHeightWithModel:model];
        return inptCell;
        
    }];
}

- (DDQFoundationTableViewLayout *)base_tableViewLayout {
    
    DDQFoundationTableViewLayout *layout = [super base_tableViewLayout];
    
    layout.layout_cellClass = [DDQSuggestionsInputCell class];
    layout.layout_rowCount = 1;
    layout.layout_footerHeight = 44.0;
    
    return layout;
    
}

/**
 点击提交按钮
 */
- (void)suggestion_didSelectSubmit {
    
    
}

@end
