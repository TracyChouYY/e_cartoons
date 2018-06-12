//
//  DDQMineSecondSectionCell.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/23.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQMineSecondSectionCell.h"

@interface DDQMineSecondSectionCell ()<DDQBarItemDelegate>

@property (nonatomic, strong) UIView *second_contentView;
@property (nonatomic, strong) UILabel *second_titleLabel;
@property (nonatomic, strong) DDQButton *second_moreButton;
@property (nonatomic, strong) DDQBarItem *second_payItem;
@property (nonatomic, strong) DDQBarItem *second_paidItem;
@property (nonatomic, strong) DDQBarItem *second_finishedItem;
@property (nonatomic, strong) DDQBarItem *second_evaluateItem;

@end

@implementation DDQMineSecondSectionCell

- (void)cell_contentViewSubviewsConfig {
    
    [super cell_contentViewSubviewsConfig];
    
    self.second_contentView = [UIView viewChangeBackgroundColor:[UIColor clearColor]];
    
    [self.contentView addSubview:self.second_contentView];
    
    self.second_titleLabel = [UILabel labelChangeText:@"我的订单" font:DDQFont(13.0) textColor:[UIColor blackColor]];
    
    self.second_moreButton = [DDQButton ddq_customButtonWithStyle:DDQButtonStyleRightImageView fontSize:13.0 title:@"全部订单" image:kSetImage(@"mine_more") titleColor:self.defaultGrayColor target:self selector:@selector(second_didSelectMore)];
    
    UIFont *itemFont = DDQFont(15.0);
    UIColor *titleColor = kSetColor(44.0, 44.0, 44.0, 1.0);
    self.second_payItem = [[DDQBarItem alloc] initWithNormalImage:kSetImage(@"mine_pay") selectedImage:nil normalTitle:@"未付款"];
    self.second_payItem.item_titleLabel.font = itemFont;
    self.second_payItem.item_titleLabel.textColor = titleColor;
    self.second_payItem.delegate = self;
    
    self.second_paidItem = [[DDQBarItem alloc] initWithNormalImage:kSetImage(@"mine_paid") selectedImage:nil normalTitle:@"已付款"];
    self.second_paidItem.item_titleLabel.font = itemFont;
    self.second_paidItem.item_titleLabel.textColor = titleColor;
    self.second_paidItem.delegate = self;

    self.second_finishedItem = [[DDQBarItem alloc] initWithNormalImage:kSetImage(@"mine_finished") selectedImage:nil normalTitle:@"已完成"];
    self.second_finishedItem.item_titleLabel.font = itemFont;
    self.second_finishedItem.item_titleLabel.textColor = titleColor;
    self.second_finishedItem.delegate = self;

    self.second_evaluateItem = [[DDQBarItem alloc] initWithNormalImage:kSetImage(@"mine_evaluate") selectedImage:nil normalTitle:@"待评价"];
    self.second_evaluateItem.item_titleLabel.font = itemFont;
    self.second_evaluateItem.item_titleLabel.textColor = titleColor;
    self.second_evaluateItem.delegate = self;

    [self.second_contentView view_configSubviews:@[self.second_titleLabel, self.second_moreButton, self.second_payItem, self.second_paidItem, self.second_finishedItem, self.second_evaluateItem]];
    
    self.contentView.backgroundColor = self.defaultViewBackgroundColor;
    
}

- (void)cell_updateContentSubviewsFrame {
    
    CGFloat margin = 10.0 * self.cell_widthRate;
    autoLayout(self.second_contentView).ddq_leading(self.contentView.leading, margin).ddq_top(self.contentView.top, 10.0 * self.cell_widthRate).ddq_width(self.contentView.width - margin * 2.0);
    
    autoLayout(self.second_titleLabel).ddq_leading(self.second_contentView.leading, 15.0 * self.cell_widthRate).ddq_top(self.contentView.top, 0.0).ddq_fitSize();
    
    autoLayout(self.second_moreButton).ddq_trailing(self.second_contentView.trailing, 10.0 * self.cell_widthRate).ddq_centerY(self.second_titleLabel.centerY, 0.0).ddq_fitSize();
    
    CGFloat itemWidth = self.second_contentView.width / 4.0;
    
    autoLayout(self.second_payItem).ddq_leading(self.second_contentView.leading, 0.0).ddq_top(self.second_titleLabel.bottom, 15.0 * self.cell_widthRate).ddq_size(CGSizeMake(itemWidth, 60.0));
    
    autoLayout(self.second_paidItem).ddq_leading(self.second_payItem.trailing, 0.0).ddq_top(self.second_payItem.top, 0.0).ddq_size(self.second_payItem.size);
    
    autoLayout(self.second_finishedItem).ddq_leading(self.second_paidItem.trailing, 0.0).ddq_top(self.second_paidItem.top, 0.0).ddq_size(self.second_paidItem.size);
    
    autoLayout(self.second_evaluateItem).ddq_leading(self.second_finishedItem.trailing, 0.0).ddq_top(self.second_finishedItem.top, 0.0).ddq_size(self.second_finishedItem.size);
    
    autoLayout(self.second_contentView).ddq_height(self.second_evaluateItem.frameMaxY);
    
    [super cell_updateContentSubviewsFrame];
    
}

- (UIView *)cell_layoutBottomControl {
    
    return self.second_contentView;
    
}

- (CGFloat)cell_bottomMargin {
    
    return 20.0 * self.cell_widthRate;
    
}

/**
 点击“更多”按钮
 */
- (void)second_didSelectMore {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(second_didSelctOrderOperation:)]) {
        
        [self.delegate second_didSelctOrderOperation:DDQMineSecondSection_Operation_All];
        
    }
}

#pragma mark - Custom Delegate
- (void)item_didSelectedWithItem:(DDQBarItem *)item {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(second_didSelctOrderOperation:)]) {
        
        DDQMineSecondSection_Operation operation = DDQMineSecondSection_Operation_All;
        if (item == self.second_paidItem) {
            
            operation = DDQMineSecondSection_Operation_Unpaid;
            
        } else if (item == self.second_payItem) {
            
            operation = DDQMineSecondSection_Operation_Paid;
            
        } else if (item == self.second_finishedItem) {
            
            operation = DDQMineSecondSection_Operation_Finished;
            
        } else if (item == self.second_evaluateItem) {
            
            operation = DDQMineSecondSection_Operation_Evaluate;
            
        }
        [self.delegate second_didSelctOrderOperation:operation];
        
    }
}
@end
