//
//  DDQWriteFirstSectionCell.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/2.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQWriteFirstSectionCell.h"

#import "DDQOrderSubCell.h"
#import "DDQEvaluateStarView.h"

@interface DDQWriteFirstSectionCell ()

@property (nonatomic, strong) DDQEvaluateStarView *first_starView;
@property (nonatomic, strong) UILabel *first_titleLabel;
@property (nonatomic, strong) DDQFoundationTableView *first_tableView;

@end

@implementation DDQWriteFirstSectionCell

- (void)cell_contentViewSubviewsConfig {
    
    [super cell_contentViewSubviewsConfig];
    
    self.first_tableView = [[DDQFoundationTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    DDQFoundationTableViewLayout *layout = [DDQFoundationTableViewLayout layoutWithTableView:self.first_tableView];
    layout.layout_sectionCount = 1;
    layout.layout_rowCount = 1;
    layout.layout_cellClass = [DDQOrderSubCell class];
    layout.layout_rowHeight = [DDQOrderSubCell sub_estimateHeight];
    [self.first_tableView tableView_configLayout:layout];
    self.first_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self first_tableViewConfig];
    
    self.first_starView = [[DDQEvaluateStarView alloc] initViewWithFrame:CGRectZero];
    
    self.first_titleLabel = [UILabel labelChangeText:@"总体评价" font:DDQFont(15.0) textColor:self.defaultBlackColor];
    
    [self.contentView view_configSubviews:@[self.first_tableView, self.first_starView, self.first_titleLabel]];
    
    self.cell_separatorMargin = DDQSeparatorMarginMaker(self.cell_defaultLeftMargin, 0.0);
    self.cell_separatorColor = self.defaultSeparatorColor;
    
}

- (void)cell_updateContentSubviewsFrame {
    
    autoLayout(self.first_tableView).ddq_leading(self.contentView.leading, 0.0).ddq_top(self.contentView.top, 0.0).ddq_size(CGSizeMake(self.contentView.width, self.first_tableView.tableView_layout.layout_rowHeight * self.first_tableView.tableView_layout.layout_rowCount));
    
    autoLayout(self.first_titleLabel).ddq_leading(self.contentView.leading, self.cell_defaultLeftMargin).ddq_top(self.first_tableView.bottom, 12.0).ddq_fitSize();
    
    autoLayout(self.first_starView).ddq_leading(self.first_titleLabel.trailing, 20.0 * self.cell_widthRate).ddq_centerY(self.first_titleLabel.centerY, 0.0).ddq_fitSize();
    
    [super cell_updateContentSubviewsFrame];
    
}

- (UIView *)cell_layoutBottomControl {
    
    return self.first_starView;
    
}

- (CGFloat)cell_bottomMargin {
    
    return 10.0 * self.cell_widthRate;
    
}

/**
 tableView的配置
 */
- (void)first_tableViewConfig {
    
    [self.first_tableView tableView_setCellConfig:^__kindof UITableViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, DDQFoundationTableView * _Nonnull tableView) {
        
        DDQOrderSubCell *subCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_cellIdentifier];
        subCell.cell_separatorMargin = DDQSeparatorMarginMaker(subCell.cell_defaultLeftMargin, subCell.cell_defaultLeftMargin);
        return subCell;
        
    }];
}

@end
