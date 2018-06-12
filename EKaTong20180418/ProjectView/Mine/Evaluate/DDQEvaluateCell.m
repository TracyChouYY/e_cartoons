//
//  DDQEvaluateCell.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/2.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQEvaluateCell.h"

#import "DDQOrderSubCell.h"

#import "DDQOrderOperationBar.h"

@interface DDQEvaluateCell () <DDQOrderOperationBarDelegate>

@property (nonatomic, strong) DDQOrderOperationBar *evaluate_operationBar;
@property (nonatomic, strong) DDQFoundationTableView *evaluate_tableView;

@end

@implementation DDQEvaluateCell

- (void)cell_contentViewSubviewsConfig {
    
    [super cell_contentViewSubviewsConfig];
    
    DDQEvaluateCellStyle style = [self.class evaulateCellStyle];
    if (style == DDQEvaluateCellStyleUnknown) return;

    NSMutableArray *subviews = [NSMutableArray arrayWithCapacity:2];
    
    self.evaluate_tableView = [[DDQFoundationTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    DDQFoundationTableViewLayout *layout = [DDQFoundationTableViewLayout layoutWithTableView:self.evaluate_tableView];
    layout.layout_sectionCount = 1;
    layout.layout_rowCount = 1;
    layout.layout_cellClass = [DDQOrderSubCell class];
    layout.layout_rowHeight = [DDQOrderSubCell sub_estimateHeight];
    [self.evaluate_tableView tableView_configLayout:layout];
    [subviews addObject:self.evaluate_tableView];
    self.evaluate_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self evaluate_tableViewConfig];
    
    if (style == DDQEvaluateCellStyleTo) {
        
        self.evaluate_operationBar = [[DDQOrderOperationBar alloc] initViewWithFrame:CGRectZero];
        self.evaluate_operationBar.bar_functionTextContainer = @[@"去评价"];
        self.evaluate_operationBar.delegate = self;
        [subviews addObject:self.evaluate_operationBar];
        
    }

    [self.contentView view_configSubviews:subviews];
    
}

- (void)cell_updateContentSubviewsFrame {
    
    DDQEvaluateCellStyle style = [self.class evaulateCellStyle];
    if (style == DDQEvaluateCellStyleUnknown) return;
    
    autoLayout(self.evaluate_tableView).ddq_leading(self.contentView.leading, 0.0).ddq_top(self.contentView.top, 0.0).ddq_width(self.contentView.width);
    autoLayout(self.evaluate_tableView).ddq_height(self.evaluate_tableView.tableView_layout.layout_rowHeight * self.evaluate_tableView.tableView_layout.layout_rowCount);
    
    if (style == DDQEvaluateCellStyleTo) {
        
        autoLayout(self.evaluate_operationBar).ddq_leading(self.evaluate_tableView.leading, 0.0).ddq_top(self.evaluate_tableView.bottom, 0.0).ddq_size(CGSizeMake(self.evaluate_tableView.width, 44.0));

    }
    
    [super cell_updateContentSubviewsFrame];
    
}

- (UIView *)cell_layoutBottomControl {
    
    DDQEvaluateCellStyle style = [self.class evaulateCellStyle];
    if (style == DDQEvaluateCellStyleUnknown) return nil;
    
    return (style == DDQEvaluateCellStyleTo) ? self.evaluate_operationBar : self.evaluate_tableView;
    
}

+ (DDQEvaluateCellStyle)evaulateCellStyle {
    
    return DDQEvaluateCellStyleUnknown;
    
}

/**
 tableView的配置
 */
- (void)evaluate_tableViewConfig {

    DDQWeakObject(self);
    [self.evaluate_tableView tableView_setCellConfig:^__kindof UITableViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, DDQFoundationTableView * _Nonnull tableView) {
        
        DDQOrderSubCell *subCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_cellIdentifier];
        return subCell;
        
    }];
    
    [self.evaluate_tableView tableView_setDidSelectConfig:^(NSIndexPath * _Nonnull indexPath) {
        
        if (weakObjc.delegate && [weakObjc.delegate respondsToSelector:@selector(evaluate_didSelectSubInfoWithCell:)]) {
            
            [weakObjc.delegate evaluate_didSelectSubInfoWithCell:weakObjc];
            
        }
    }];
}

#pragma mark - Custom Bar Delegate
- (void)operation_didSelectWithType:(DDQOrderOperationType)type {
    
    if (type == DDQOrderOperationTypeEvaluate) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(evaluate_didSelectToEvaluateWithCell:)]) {
            
            [self.delegate evaluate_didSelectToEvaluateWithCell:self];
            
        }
    }
}

@end
