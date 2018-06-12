//
//  DDQSettleSecondSectionCell.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/2.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQSettleSecondSectionCell.h"

@interface DDQSettleSecondSectionCell ()

@property (nonatomic, strong) UILabel *second_titleLabel;
@property (nonatomic, strong) UIButton *second_deleteButton;
@property (nonatomic, strong) UIButton *second_countButton;
@property (nonatomic, strong) UIButton *second_addButton;
@property (nonatomic, copy) DDQSettleSelectNumberCompleted second_completed;

@end

@implementation DDQSettleSecondSectionCell

- (void)cell_contentViewSubviewsConfig {
    
    [super cell_contentViewSubviewsConfig];
    
    self.second_titleLabel = [UILabel labelChangeText:@"购买数量" font:DDQFont(14.0) textColor:self.defaultBlackColor];
    
    self.second_deleteButton = [UIButton buttonChangeFont:nil titleColor:nil image:kSetImage(@"settle_deleteGray") backgroundImage:nil title:nil attributeTitle:nil target:self sel:@selector(second_didSelectDeletWithButton:)];
    
    self.second_addButton = [UIButton buttonChangeFont:nil titleColor:nil image:kSetImage(@"settle_add") backgroundImage:nil title:nil attributeTitle:nil target:self sel:@selector(second_didSelectAdd)];
    
    self.second_countButton = [UIButton buttonChangeFont:DDQFont(10.0) titleColor:self.defaultBlackColor image:nil backgroundImage:nil title:@"1" attributeTitle:nil target:nil sel:nil];
    self.second_countButton.layer.borderWidth = 0.5;
    self.second_countButton.layer.borderColor = kSetColor(90.0, 169.0, 243.0, 1.0).CGColor;
    
    [self.contentView view_configSubviews:@[self.second_titleLabel, self.second_deleteButton, self.second_countButton, self.second_addButton]];
    
}

- (void)cell_updateContentSubviewsFrame {
    
    autoLayout(self.second_titleLabel).ddq_leading(self.contentView.leading, self.cell_defaultLeftMargin).ddq_top(self.contentView.top, 20.0 * self.cell_widthRate).ddq_fitSize();
    
    autoLayout(self.second_addButton).ddq_trailing(self.contentView.trailing, self.cell_defaultLeftMargin).ddq_centerY(self.second_titleLabel.centerY, 0.0).ddq_fitSize();
    
    autoLayout(self.second_countButton).ddq_trailing(self.second_addButton.leading, 0.0).ddq_centerY(self.second_addButton.centerY, 0.0).ddq_size(CGSizeMake(45.0 * self.cell_widthRate, self.second_addButton.height));
    
    autoLayout(self.second_deleteButton).ddq_trailing(self.second_countButton.leading, 0.0).ddq_centerY(self.second_countButton.centerY, 0.0).ddq_fitSize();
    
    [super cell_updateContentSubviewsFrame];
    
}

- (UIView *)cell_layoutBottomControl {
    
    return self.second_titleLabel;
    
}

- (CGFloat)cell_bottomMargin {
    
    return self.second_titleLabel.y;
    
}

/**
 点击减号
 */
- (void)second_didSelectDeletWithButton:(UIButton *)button {
    
    NSString *count = [self.second_countButton titleForState:UIControlStateNormal];
    NSInteger number = count.integerValue;
    if (number == 1) {
        
        return;
        
    }

    number--;
    if (self.second_completed) {
        
        self.second_completed(number);
        
    }

    if (number == 1) {
        
        [button setImage:kSetImage(@"settle_deleteGray") forState:UIControlStateNormal];

    }
    [self.second_countButton setTitle:@(number).stringValue forState:UIControlStateNormal];

}

/**
 点击加号
 */
- (void)second_didSelectAdd {
    
    NSString *count = [self.second_countButton titleForState:UIControlStateNormal];
    NSInteger number = count.integerValue;
    number++;
    
    if (self.second_completed) {
        
        self.second_completed(number);
        
    }
    [self.second_deleteButton setImage:kSetImage(@"settle_deleteBlue") forState:UIControlStateNormal];
    [self.second_countButton setTitle:@(number).stringValue forState:UIControlStateNormal];
    
}

- (void)second_notificationWhenNumberChange:(DDQSettleSelectNumberCompleted)completed {
    
    if (completed) {
        
        self.second_completed = completed;
        
    }
}

@end
