
//
//  DDQOrderProductInfoView.m
//
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQOrderProductInfoView.h"

#import "DDQOrderSubCell.h"

@interface DDQOrderProductInfoView ()

@property (nonatomic, strong) UILabel *info_titleLabel;
@property (nonatomic, strong) UILabel *info_subTitleLabel;
@property (nonatomic, strong) UIView *info_separator;
@property (nonatomic, copy) DDQOrderProductInfoCompleted info_completed;

@end

@implementation DDQOrderProductInfoView

- (void)view_subviewsConfig {
    
    [super view_subviewsConfig];
    
    self.info_titleLabel = [UILabel labelChangeText:nil font:DDQFont(12.0) textColor:self.defaultGrayColor];
    self.info_titleLabel.textAlignment = NSTextAlignmentLeft;
    
    self.info_subTitleLabel = [UILabel labelChangeText:nil font:DDQFont(12.0) textColor:self.defaultOrangeColor];
    self.info_subTitleLabel.textAlignment = NSTextAlignmentRight;

    self.info_separator = [UIView viewChangeBackgroundColor:self.defaultSeparatorColor];
    [self view_configSubviews:@[self.info_titleLabel, self.info_subTitleLabel, self.info_separator]];
    
    //TableView
    [self view_tableViewConfig];
    
}

- (void)view_updateContentSubviewsFrame {
    
    DDQViewVHMargin margin = DDQViewVHMarginMaker(12.0 * self.view_widthRate, 12.0 * self.view_widthRate);
    
    autoLayout(self.info_subTitleLabel).ddq_trailing(self.trailing, margin.horMargin).ddq_top(self.top, margin.verMargin).ddq_estimateSize(CGSizeMake(self.width * 0.5, 15.0));

    autoLayout(self.info_titleLabel).ddq_leading(self.leading, margin.horMargin).ddq_top(self.info_subTitleLabel.top, 0.0).ddq_estimateSize(CGSizeMake(self.info_subTitleLabel.x - 5.0 - margin.horMargin, 15.0));
    
    autoLayout(self.info_separator).ddq_leading(self.leading, 0.0).ddq_top(self.info_titleLabel.bottom, self.info_titleLabel.y).ddq_size(CGSizeMake(self.width, 1.0));
    
    autoLayout(self.view_subTableView).ddq_leading(self.leading, 0.0).ddq_top(self.info_separator.bottom, 0.0).ddq_size(CGSizeMake(self.width, self.view_subTableViewLayout.layout_rowHeight * self.view_subTableViewLayout.layout_rowCount));
    
    [super view_updateContentSubviewsFrame];
    
}

- (void)view_tableViewConfig {
    
    [super view_tableViewConfig];
    
    DDQWeakObject(self);
    [self.view_subTableView tableView_setCellConfig:^__kindof UITableViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, UITableView * _Nonnull tableView) {
        
        DDQOrderSubCell *subCell = [tableView dequeueReusableCellWithIdentifier:weakObjc.view_subTableViewLayout.layout_cellIdentifier forIndexPath:indexPath];
        DDQOrderSubModel *subModel = [weakObjc.info_dataSource objectAtIndex:indexPath.row];
        [subCell cell_updateDataWithModel:subModel];
        return subCell;
        
    }];
    
    [self.view_subTableView tableView_setDidSelectConfig:^(NSIndexPath * _Nonnull indexPath) {
        
        if (weakObjc.info_completed) {
            
            weakObjc.info_completed();
            
        }
    }];
}

- (DDQFoundationTableViewLayout *)view_tableViewLayout {
    
    DDQFoundationTableViewLayout *layout = [super view_tableViewLayout];
    
    layout.layout_cellClass = [DDQOrderSubCell class];
    //说明：
    //为什么是固定的76乘当前屏幕与6的比呢?原因有2
    //1、按照我的布局，我是将这个cell用于另一cell上的tableview上，cell -> view -> cell如果不把我这个cell固定高度，计算起super cell的高度将很麻烦。
    //2、这个布局写死高度了也没什么关系。
    layout.layout_rowHeight = [DDQOrderSubCell sub_estimateHeight];
    layout.layout_rowCount = 1;
    
    return layout;
    
}

- (void)setTitle:(NSString *)title {
    
    _title = title;
    
    self.info_titleLabel.text = title;
    [self view_updateContentSubviewsFrame];
    
}

- (void)setSubTitle:(NSString *)subTitle {
    
    _subTitle = subTitle;
    
    self.info_subTitleLabel.text = subTitle;
    [self view_updateContentSubviewsFrame];

}

- (void)setInfo_dataSource:(NSArray *)info_dataSource {
    
    _info_dataSource = info_dataSource;
    
    self.view_subTableViewLayout.layout_rowCount = _info_dataSource.count;
    [self.view_subTableView reloadData];
    CGRect originFrame = self.view_subTableView.frame;
    originFrame.size.height = self.view_subTableViewLayout.layout_rowCount * self.view_subTableViewLayout.layout_rowHeight;
    self.view_subTableView.frame = originFrame;
    
}

- (CGFloat)info_estimateHeight {
    
    return self.view_subTableView.frameMaxY;
    
}

- (void)info_didSelectSubCellCompleted:(DDQOrderProductInfoCompleted)completed {
    
    if (completed) {
        
        self.info_completed = completed;
        
    }
}

@end
