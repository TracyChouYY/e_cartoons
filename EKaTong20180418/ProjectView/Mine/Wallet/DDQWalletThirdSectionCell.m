//
//  DDQWalletThirdSectionCell.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/26.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQWalletThirdSectionCell.h"

@interface DDQWalletThirdSectionCell ()

@property (nonatomic, strong) DDQButton *third_wayButton;
@property (nonatomic, strong) UIImageView *third_statusImageView;

@end

@implementation DDQWalletThirdSectionCell

- (void)cell_contentViewSubviewsConfig {
    
    [super cell_contentViewSubviewsConfig];
    
    self.third_wayButton = [DDQButton ddq_customButtonWithStyle:DDQButtonStyleLeftImageView fontSize:14.0 title:@"" image:nil titleColor:self.defaultBlackColor target:nil selector:nil];
    self.third_wayButton.control_space = 5.0;
    
    self.third_statusImageView = [UIImageView imageViewChangeImage:kSetImage(@"wallet_normal")];
    
    [self.contentView view_configSubviews:@[self.third_wayButton, self.third_statusImageView]];
    
    self.cell_separatorStyle = DDQTableViewCellSeparatorStyleBottom;
    self.cell_separatorMargin = DDQSeparatorMarginMaker(self.cell_defaultLeftMargin, 0.0);
    self.cell_separatorColor = self.defaultSeparatorColor;
    
}

- (void)cell_updateContentSubviewsFrame {
    
    autoLayout(self.third_wayButton).ddq_leading(self.contentView.leading, self.cell_separatorMargin.leftMargin).ddq_top(self.contentView.top, 15.0 * self.cell_widthRate).ddq_size(CGSizeMake(105.0, 25.0));

    autoLayout(self.third_statusImageView).ddq_trailing(self.contentView.trailing, self.third_wayButton.x).ddq_centerY(self.third_wayButton.centerY, 0.0).ddq_fitSize();
    
    [super cell_updateContentSubviewsFrame];
    
}

- (void)cell_updateDataWithModel:(__kindof DDQBaseCellModel *)model {
    
    DDQWalletWayModel *wayModel = model;
    
    [self.third_wayButton setTitle:wayModel.title forState:UIControlStateNormal];
    [self.third_wayButton setImage:kSetImage(wayModel.image) forState:UIControlStateNormal];
    
    [super cell_updateDataWithModel:model];
    
}

- (UIView *)cell_layoutBottomControl {
    
    return self.third_wayButton;
    
}

- (CGFloat)cell_bottomMargin {
    
    return self.third_wayButton.y;
    
}

@end

@implementation DDQWalletWayModel

@end
