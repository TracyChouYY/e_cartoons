//
//  DDQUserInfoBaseCell.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/24.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQUserInfoBaseCell.h"

typedef NS_ENUM(NSUInteger, DDQUserInfoButtonStatus) {
    
    DDQUserInfoButtonStatusSelected,
    DDQUserInfoButtonStatusNormal,
    
};

@interface DDQUserInfoBaseCell ()

@property (nonatomic, readwrite, strong) UILabel *info_titleLabel;

@property (nonatomic, strong, readwrite) UITextField *info_inputField;

@property (nonatomic, strong) UIButton *info_manButton;
@property (nonatomic, strong) UIButton *info_womanButton;
@property (nonatomic, strong) UIButton *info_tempButton;

@property (nonatomic, strong) UIButton *info_selectButton;
@property (nonatomic, strong) UIImageView *info_arrowImageView;

@end

@implementation DDQUserInfoBaseCell

- (void)cell_contentViewSubviewsConfig {
    
    [super cell_contentViewSubviewsConfig];
    
    DDQUserInfoBaseCellStyle style = [self.class userInfoStyle];
    if (style == DDQUserInfoBaseCellStyleUnknown) return;
    
    self.info_titleLabel = [UILabel labelChangeText:@"" font:DDQFont(16.0) textColor:[UIColor blackColor]];
    
    NSMutableArray *subviews = [NSMutableArray arrayWithObject:self.info_titleLabel];
    
    if (style == DDQUserInfoBaseCellStyleNickname) {
        
        self.info_inputField = [UITextField fieldChangeFont:DDQFont(15.0) textColor:[UIColor blackColor] placeholder:@" " attributePlaceholder:nil];
        [subviews addObject:self.info_inputField];
        
    } else if (style == DDQUserInfoBaseCellStyleSex) {
        
        self.info_manButton = [UIButton buttonChangeFont:DDQFont(13.0) titleColor:kSetColor(24.0, 24.0, 24.0, 1.0) image:kSetImage(@"mine_manSelected") backgroundImage:nil title:@"我是男生" attributeTitle:nil target:self sel:@selector(base_didSelectSexWithButton:)];
        [self.info_manButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 5.0)];
        self.info_tempButton = self.info_manButton;
        [self.info_manButton setSelected:YES];
        
        self.info_womanButton = [UIButton buttonChangeFont:DDQFont(13.0) titleColor:kSetColor(203.0, 203.0, 203.0, 1.0) image:kSetImage(@"mine_womenNormal") backgroundImage:nil title:@"我是女生" attributeTitle:nil target:self sel:@selector(base_didSelectSexWithButton:)];
        [self.info_womanButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0, 0.0, 5.0)];

        [subviews addObjectsFromArray:@[self.info_manButton, self.info_womanButton]];
        
    } else if (style == DDQUserInfoBaseCellStyleChoice) {
        
        self.info_inputField = [UITextField fieldChangeFont:DDQFont(15.0) textColor:[UIColor blackColor] placeholder:@"请选择" attributePlaceholder:nil];

        self.info_selectButton = [UIButton buttonChangeFont:DDQFont(16.0) titleColor:kSetColor(204.0, 204.0, 204.0, 1.0) image:nil backgroundImage:nil title:@" " attributeTitle:nil target:self sel:@selector(base_didSelectChoice)];
        self.info_selectButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        self.info_arrowImageView = [UIImageView imageViewChangeImage:kSetImage(@"mine_more")];
        
        [subviews addObjectsFromArray:@[self.info_inputField, self.info_selectButton, self.info_arrowImageView]];

    }
    
    [self.contentView view_configSubviews:subviews];
    
    self.cell_separatorStyle = DDQTableViewCellSeparatorStyleBottom;
    self.cell_separatorMargin = DDQSeparatorMarginMaker(self.cell_defaultLeftMargin, 0.0);
    self.cell_separatorColor = self.defaultSeparatorColor;
    
}

- (void)cell_updateContentSubviewsFrame {
    
    DDQUserInfoBaseCellStyle style = [self.class userInfoStyle];
    if (style == DDQUserInfoBaseCellStyleUnknown) return;

    CGFloat maxLeftMargin = 100.0 * self.cell_widthRate;
    CGFloat rightMargin = 15.0 * self.cell_widthRate;
    autoLayout(self.info_titleLabel).ddq_leading(self.contentView.leading, self.cell_defaultLeftMargin).ddq_top(self.contentView.top, 20.0 * self.cell_widthRate).ddq_fitSize();
    if (style == DDQUserInfoBaseCellStyleNickname) {
        
        autoLayout(self.info_inputField).ddq_leading(self.contentView.leading, maxLeftMargin).ddq_top(self.contentView.top, 0.0).ddq_size(CGSizeMake(self.contentView.width - self.info_inputField.x, self.info_titleLabel.frameMaxY + self.info_titleLabel.y));
        
    } else if (style == DDQUserInfoBaseCellStyleSex) {
        
        autoLayout(self.info_manButton).ddq_leading(self.contentView.leading, maxLeftMargin).ddq_centerY(self.info_titleLabel.centerY, 0.0).ddq_size(CGSizeMake(90.0 * self.cell_widthRate, 30.0 * self.cell_widthRate));
        [self.info_manButton view_hanlderLayerWithRadius:self.info_manButton.height * 0.5 borderWidth:1.0 borderColor:kSetColor(222.0, 222.0, 222.0, 1.0)];
//        self.info_tempButton = self.info_manButton;
        
        autoLayout(self.info_womanButton).ddq_leading(self.info_manButton.trailing, 20.0 * self.cell_widthRate).ddq_centerY(self.info_manButton.centerY, 0.0).ddq_size(self.info_manButton.size);
        [self.info_womanButton view_hanlderLayerWithRadius:self.info_womanButton.height * 0.5 borderWidth:1.0 borderColor:kSetColor(222.0, 222.0, 222.0, 1.0)];

    } else if (style == DDQUserInfoBaseCellStyleChoice) {
        
        autoLayout(self.info_arrowImageView).ddq_trailing(self.contentView.trailing, rightMargin).ddq_centerY(self.info_titleLabel.centerY, 0.0).ddq_fitSize();
        
        autoLayout(self.info_inputField).ddq_leading(self.contentView.leading, maxLeftMargin).ddq_top(self.contentView.top, 0.0).ddq_size(CGSizeMake(self.info_arrowImageView.x - 5.0 - self.info_selectButton.x, self.info_titleLabel.frameMaxY + self.info_titleLabel.y));

        autoLayout(self.info_selectButton).ddq_leading(self.info_inputField.leading, 0.0).ddq_top(self.info_inputField.top, 0.0).ddq_size(self.info_inputField.size);
        
    }
    
    [super cell_updateContentSubviewsFrame];
    
}

- (void)cell_updateDataWithModel:(__kindof DDQBaseCellModel *)model {
    
    DDQUserInfoModel *infoModel = model;

    self.info_titleLabel.text = infoModel.title;

    if ([self.class userInfoStyle] != DDQUserInfoBaseCellStyleSex) {//姓名不用管
        
        if (infoModel.placeholder.length > 0) {
            
            self.info_inputField.placeholder = infoModel.placeholder;
            
        } else if (infoModel.text.length > 0) {
            
            self.info_inputField.text = infoModel.text;
            
        }
    }
    
    if ([self.class userInfoStyle] == DDQUserInfoBaseCellStyleSex) {
        
        UIButton *button = infoModel.type == DDQUserInfoSexTypeMan ? self.info_manButton : self.info_womanButton;
        [self base_didSelectSexWithButton:button];
        
    }
    [super cell_updateDataWithModel:model];
    
}

- (UIView *)cell_layoutBottomControl {
    
    return self.info_titleLabel;
    
}

- (CGFloat)cell_bottomMargin {
    
    return self.info_titleLabel.y;
    
}

+ (DDQUserInfoBaseCellStyle)userInfoStyle {
    
    return DDQUserInfoBaseCellStyleUnknown;
    
}

/**
 点击了不同的性别
 */
- (void)base_didSelectSexWithButton:(UIButton *)button {
    
    if (button == self.info_tempButton) return;//点击了同一个按钮
    
    [self base_handleButtonWithStatus:DDQUserInfoButtonStatusSelected button:button];
    [self base_handleButtonWithStatus:DDQUserInfoButtonStatusNormal button:self.info_tempButton];
    [self.info_tempButton setSelected:NO];
    [button setSelected:YES];
    self.info_tempButton = button;
    
}

/**
 处理不同状态下的按钮显示
 */
- (void)base_handleButtonWithStatus:(DDQUserInfoButtonStatus)status button:(UIButton *)button {
    
    UIColor *color = (status == DDQUserInfoButtonStatusSelected) ? kSetColor(24.0, 24.0, 24.0, 1.0) : kSetColor(203.0, 203.0, 203.0, 1.0);
    UIImage *image = nil;
    if (button == self.info_manButton) {
        
        image = (status == DDQUserInfoButtonStatusNormal) ? kSetImage(@"mine_manNormal") : kSetImage(@"mine_manSelected");
        
    } else {
        
        image = (status == DDQUserInfoButtonStatusNormal) ? kSetImage(@"mine_womenNormal") : kSetImage(@"mine_womenSelected");
        
    }
    [button setImage:image forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    
}

/**
 点击选择
 */
- (void)base_didSelectChoice {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(userInfo_didSelectChoiceOperationWithCell:)]) {
        
        [self.delegate userInfo_didSelectChoiceOperationWithCell:self];
        
    }
}

- (DDQUserInfoSexType)info_sexType {
    
    return (self.info_womanButton.selected) ? DDQUserInfoSexTypeWoman : DDQUserInfoSexTypeMan;
    
}

@end

@implementation DDQUserInfoModel

- (NSArray *)model_handlerIgnoredProperty {
    
    return @[@"image"];
    
}

+ (NSArray *)mj_ignoredPropertyNames {
    
    return @[@"image"];
    
}

@end
