//
//  DDQMineFirstSectionCell.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/23.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQMineFirstSectionCell.h"

#import "DDQLabelItem.h"
#import "DDQLevelView.h"

@interface DDQMineFirstSectionCell () <DDQBarItemDelegate>

@property (nonatomic, strong) UIButton *first_functionButton;
@property (nonatomic, strong) UIButton *first_userIconButton;
@property (nonatomic, strong) UILabel *first_nameLabel;
@property (nonatomic, strong) UIButton *first_levelButton;
@property (nonatomic, strong) UIImageView *first_backgroundImageView;
@property (nonatomic, strong) UIView *first_contentView;

//适用于基地管理的三个item
@property (nonatomic, strong) DDQLabelItem *first_todayItem;
@property (nonatomic, strong) DDQLabelItem *first_cumulateItem;
@property (nonatomic, strong) DDQLabelItem *first_totalItem;

//适用于个人用户中心的两个Item一个等级视图
@property (nonatomic, strong) DDQBarItem *first_memberItem;
@property (nonatomic, strong) DDQBarItem *first_walletItem;
@property (nonatomic, strong) DDQLevelView *first_levelView;

@end

@implementation DDQMineFirstSectionCell

- (void)cell_contentViewSubviewsConfig {
    
    [super cell_contentViewSubviewsConfig];
    
    self.first_backgroundImageView = [UIImageView imageViewChangeImage:kSetImage(@"mine_bg")];
    
    self.first_contentView = [UIView viewChangeBackgroundColor:[UIColor whiteColor]];
    self.first_contentView.layer.shadowColor = kSetColor(240.0, 240.0, 240.0, 1.0).CGColor;
    self.first_contentView.layer.shadowOffset = CGSizeMake(0.0, 10.0 * self.cell_widthRate);
    self.first_contentView.layer.shadowRadius = 3.0;
    self.first_contentView.layer.shadowOpacity = 1.0;
    NSMutableArray *cellContentSubviews = [NSMutableArray arrayWithArray:@[self.first_backgroundImageView, self.first_contentView]];

    self.first_userIconButton = [UIButton buttonChangeFont:nil titleColor:nil image:nil backgroundImage:nil title:nil attributeTitle:nil target:self sel:@selector(mine_didSelectUserIcon)];
    
    self.first_nameLabel = [UILabel labelChangeText:@" " font:DDQFont(18.0) textColor:kSetColor(57.0, 57.0, 57.0, 1.0)];
    NSMutableArray *customContentSubviews = [NSMutableArray arrayWithArray:@[self.first_userIconButton, self.first_nameLabel]];
    
    DDQMineFirstSectionCellStyle style = [self.class mineFirstSectionStyle];
    if (style == DDQMineFirstSectionCellStyleBase) {//基地个人中心
        
        self.first_functionButton = [UIButton buttonChangeFont:nil titleColor:nil image:kSetImage(@"mine_issue") backgroundImage:nil title:nil attributeTitle:nil target:self sel:@selector(mine_didSelectFunction)];
        
        self.first_todayItem = [[DDQLabelItem alloc] initLableItemWithStyle:DDQLabelItemStyleUD title:@"0" subTitle:@"今日销售"];
        
        self.first_cumulateItem = [[DDQLabelItem alloc] initLableItemWithStyle:DDQLabelItemStyleUD title:@"0" subTitle:@"累计销售"];
        
        self.first_totalItem = [[DDQLabelItem alloc] initLableItemWithStyle:DDQLabelItemStyleUD title:@"0" subTitle:@"我的财富"];
        self.first_totalItem.item_titleLabel.textColor = self.defaultBlueColor;
        
        [cellContentSubviews addObject:self.first_functionButton];
        [customContentSubviews addObjectsFromArray:@[self.first_todayItem, self.first_cumulateItem, self.first_totalItem]];

    } else if (style == DDQMineFirstSectionCellStylePersonal) {//个人中心
        
        self.first_functionButton = [UIButton buttonChangeFont:nil titleColor:nil image:kSetImage(@"mine_set") backgroundImage:nil title:nil attributeTitle:nil target:self sel:@selector(mine_didSelectFunction)];
        
        [cellContentSubviews addObject:self.first_functionButton];
        
        self.first_memberItem = [[DDQBarItem alloc] initWithNormalImage:kSetImage(@"mine_member") selectedImage:nil normalTitle:@"会员中心"];
        self.first_memberItem.item_titleLabel.font = DDQFont(15.0);
        self.first_memberItem.item_titleLabel.textColor = kSetColor(95.0, 95.0, 96.0, 1.0);
        self.first_memberItem.item_imageOffsetY = self.first_memberItem.item_imageView.image.size.height;
        self.first_memberItem.delegate = self;
        
        self.first_walletItem = [[DDQBarItem alloc] initWithNormalImage:kSetImage(@"mine_wallet") selectedImage:nil normalTitle:@"我的钱包"];
        self.first_walletItem.item_titleLabel.font = DDQFont(15.0);
        self.first_walletItem.item_titleLabel.textColor = kSetColor(95.0, 95.0, 96.0, 1.0);
        self.first_walletItem.item_imageOffsetY = self.first_walletItem.item_imageView.image.size.height;
        self.first_walletItem.delegate = self;

        self.first_levelView = [[DDQLevelView alloc] initLevelViewWithStyle:DDQLevelViewStyleNormal];

        [customContentSubviews addObjectsFromArray:@[self.first_memberItem, self.first_walletItem, self.first_levelView]];
        
    } else {
        
        //管理员个人中心，没有其他的特殊控件
        
    }
    [self.contentView view_configSubviews:cellContentSubviews.copy];
    [self.first_contentView view_configSubviews:customContentSubviews.copy];

}

- (void)cell_updateContentSubviewsFrame {
    
    autoLayout(self.first_backgroundImageView).ddq_leading(self.contentView.leading, 0.0).ddq_top(self.contentView.top, 0.0).ddq_fitScaleSize(self.cell_widthRate);
    
    autoLayout(self.first_contentView).ddq_centerX(self.first_backgroundImageView.centerX, 0.0).ddq_top(self.first_backgroundImageView.top, 100.0 * self.cell_widthRate).ddq_size(CGSizeMake(self.contentView.width - 20.0 * self.cell_widthRate, 150.0 * self.cell_widthRate));
    
    autoLayout(self.first_userIconButton).ddq_centerX(self.first_contentView.centerX, 0.0).ddq_centerY(self.first_contentView.top, 0.0).ddq_size(CGSizeMake(65.0 * self.cell_widthRate, 65.0 * self.cell_widthRate));
    [self.first_userIconButton view_hanlderLayerWithRadius:self.first_userIconButton.height * 0.5 borderWidth:2.0 borderColor:[UIColor whiteColor]];

    autoLayout(self.first_nameLabel).ddq_centerX(self.first_userIconButton.centerX, 0.0).ddq_top(self.first_userIconButton.bottom, 10.0 * self.cell_widthRate).ddq_estimateSize(CGSizeMake(self.first_contentView.width, 20.0));
    
    DDQMineFirstSectionCellStyle style = [self.class mineFirstSectionStyle];
    if (style == DDQMineFirstSectionCellStyleBase) {
        
        autoLayout(self.first_functionButton).ddq_trailing(self.first_contentView.trailing, 0.0).ddq_top(self.contentView.top, 35.0 * self.cell_widthRate).ddq_fitSize();
        CGFloat leftMargin = 30.0 * self.cell_widthRate;
        CGFloat controlSpace = 20.0 * self.cell_widthRate;
        CGFloat itemWidth = (self.first_contentView.width - leftMargin * 2.0 - controlSpace * 2.0) / 3.0;
        
        self.first_todayItem.item_width = self.first_cumulateItem.item_width = self.first_totalItem.item_width = itemWidth;
        
        autoLayout(self.first_todayItem).ddq_leading(self.first_contentView.leading, leftMargin).ddq_top(self.first_nameLabel.bottom, 25.0 * self.cell_widthRate).ddq_size(CGSizeMake(itemWidth, self.first_todayItem.item_estimateHeight));

        autoLayout(self.first_cumulateItem).ddq_leading(self.first_todayItem.trailing, controlSpace).ddq_centerY(self.first_todayItem.centerY, 0.0).ddq_size(CGSizeMake(itemWidth, self.first_cumulateItem.item_estimateHeight));
        
        autoLayout(self.first_totalItem).ddq_leading(self.first_cumulateItem.trailing, controlSpace).ddq_centerY(self.first_cumulateItem.centerY, 0.0).ddq_size(CGSizeMake(itemWidth, self.first_cumulateItem.item_estimateHeight));
        
    } else if (style == DDQMineFirstSectionCellStylePersonal) {
        
        autoLayout(self.first_functionButton).ddq_trailing(self.first_contentView.trailing, 0.0).ddq_top(self.contentView.top, 35.0 * self.cell_widthRate).ddq_fitSize();
        
        autoLayout(self.first_nameLabel).ddq_trailing(self.first_contentView.centerX, -10.0). ddq_top(self.first_userIconButton.bottom, 10.0 * self.cell_widthRate).ddq_estimateSize(CGSizeMake(self.first_contentView.width * 0.5 + 10.0, 20.0));
        
        autoLayout(self.first_memberItem).ddq_leading(self.first_contentView.leading, 0.0).ddq_top(self.first_nameLabel.bottom, 25.0 * self.cell_widthRate).ddq_size(CGSizeMake(self.first_contentView.width * 0.5, self.first_contentView.height - self.first_memberItem.y));
        
        autoLayout(self.first_walletItem).ddq_leading(self.first_memberItem.trailing, 0.0).ddq_top(self.first_memberItem.top, 0.0).ddq_size(self.first_memberItem.size);
        
        autoLayout(self.first_levelView).ddq_leading(self.first_nameLabel.trailing, 5.0).ddq_centerY(self.first_nameLabel.centerY, 0.0).ddq_fitSize();

    }

    [super cell_updateContentSubviewsFrame];
    
}

- (void)cell_updateDataWithModel:(__kindof DDQBaseCellModel *)model {
    
    DDQMineFirstSectionCellStyle style = [self.class mineFirstSectionStyle];
    DDQMineFirstSectionModel *firstModel = model;
    
    [self.first_userIconButton sd_setBackgroundImageWithURL:[NSURL URLWithString:firstModel.image] forState:UIControlStateNormal placeholderImage:kSetImage(@"icon_placeholder")];
    self.first_nameLabel.text = firstModel.nickname;

    if (style == DDQMineFirstSectionCellStylePersonal) {
        
        
    } else if (style == DDQMineFirstSectionCellStyleBase) {
        
        self.first_todayItem.item_titleLabel.text = firstModel.jrxs.length == 0 ? @"0" : firstModel.jrxs;
        self.first_cumulateItem.item_titleLabel.text = firstModel.ljxs.length == 0 ? @"0" : firstModel.ljxs;
        self.first_totalItem.item_titleLabel.text = firstModel.wdcf.length == 0 ? @"0" : firstModel.wdcf;
        
    }
    
    [super cell_updateDataWithModel:model];
    
}

- (UIView *)cell_layoutBottomControl {
    
    return self.first_contentView;
    
}

- (CGFloat)cell_bottomMargin {
    
    return self.first_contentView.layer.shadowOffset.height;
    
}

+ (DDQMineFirstSectionCellStyle)mineFirstSectionStyle {
    
    return DDQMineFirstSectionCellStylePersonal;
    
}

/**
 点击右上角的功能按钮
 */
- (void)mine_didSelectFunction {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(first_didSelectToRightCornerButtonWithStyle:)]) {
        
        [self.delegate first_didSelectToRightCornerButtonWithStyle:[self.class mineFirstSectionStyle]];
        
    }
}

/**
 点击用户的头像
 */
- (void)mine_didSelectUserIcon {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(first_didSelectUserIconWithStyle:)]) {
        
        [self.delegate first_didSelectUserIconWithStyle:[self.class mineFirstSectionStyle]];
        
    }
}

#pragma mark - BarItem Delegate
- (void)item_didSelectedWithItem:(DDQBarItem *)item {
    
    if (item == self.first_memberItem) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(first_didSelectMemberCenter)]) {
            
            [self.delegate first_didSelectMemberCenter];
            
        }
    } else if (item == self.first_walletItem) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(first_didSelectWallet)]) {
            
            [self.delegate first_didSelectWallet];
            
        }
    }
}

@end

@implementation DDQMineFirstSectionModel

@end
