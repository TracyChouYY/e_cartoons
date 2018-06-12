//
//  DDQSettleFourthSectionCell.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/2.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQSettleFourthSectionCell.h"

@interface DDQSettleFourthSectionCell ()

@property (nonatomic, strong) DDQButton *fourth_button;

@end

@implementation DDQSettleFourthSectionCell

- (void)setSelected:(BOOL)selected {
    
    [super setSelected:selected];
    
    [self.fourth_button setImage:(selected) ? kSetImage(@"way_selected") : kSetImage(@"way_normal") forState:UIControlStateNormal];
    
}

- (void)cell_contentViewSubviewsConfig {
    
    [super cell_contentViewSubviewsConfig];
    
    self.fourth_button = [DDQButton ddq_customButtonWithStyle:DDQButtonStyleLeftImageView fontSize:14.0 title:nil image:kSetImage(@"way_normal") titleColor:kSetColor(102.0, 102.0, 102.0, 1.0) target:nil selector:nil];
    self.fourth_button.control_space = 12.0 * self.cell_widthRate;
    
    [self.contentView addSubview:self.fourth_button];
    
    self.cell_separatorColor = self.defaultSeparatorColor;
    self.cell_separatorMargin = DDQSeparatorMarginMaker(self.cell_defaultLeftMargin, 0.0);

}

- (void)cell_updateContentSubviewsFrame {
    
    autoLayout(self.fourth_button).ddq_leading(self.contentView.leading, self.cell_defaultLeftMargin).ddq_top(self.contentView.top, self.cell_defaultLeftMargin).ddq_fitSize();
    
    [super cell_updateContentSubviewsFrame];
    
}

- (void)cell_updateDataWithModel:(__kindof DDQBaseCellModel *)model {
    
    DDQSettleWayModel *wayModel = model;
    
    [self.fourth_button setTitle:wayModel.title forState:UIControlStateNormal];
    
    [super cell_updateDataWithModel:model];
    
}

- (UIView *)cell_layoutBottomControl {
    
    return self.fourth_button;
    
}

- (CGFloat)cell_bottomMargin {
    
    return self.fourth_button.y;
    
}

@end

@implementation DDQSettleWayModel



@end
