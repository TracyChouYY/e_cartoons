//
//  DDQUserOperationHeaderView.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/18.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQUserOperationHeaderView.h"

@interface DDQUserOperationHeaderView ()

@property (nonatomic, assign) DDQUserOperationHeaderViewStyle header_style;

//@property (nonatomic, strong) UIButton *header_personalButton;
//@property (nonatomic, strong) UIButton *header_baseButton;
//@property (nonatomic, strong) UIButton *header_managerButton;
//@property (nonatomic, strong) UIView *header_buttonUnderline;

@property (nonatomic, strong, readwrite) UILabel *header_titleLabel;
@property (nonatomic, copy) DDQUserOperationHeaderSelectCompleted header_completed;
@property (nonatomic, copy) NSDictionary *header_buttonAttributed;

@end

@implementation DDQUserOperationHeaderView

- (void)sizeToFit {
    
    [super sizeToFit];
    
    CGRect frame = self.frame;
    frame.size = CGSizeMake(self.header_titleLabel.frameMaxX, self.header_titleLabel.frameMaxY);
    self.frame = frame;
    
}

- (instancetype)initHeaderViewWithStyle:(DDQUserOperationHeaderViewStyle)style {
    
    self.header_style = style;

    self = [super initViewWithFrame:CGRectZero];
        
    return self;
    
}

- (instancetype)initViewWithFrame:(CGRect)frame {
    
    return [self initHeaderViewWithStyle:DDQUserOperationHeaderViewStyleLogin];
    
}

- (void)view_subviewsConfig {
    
    [super view_subviewsConfig];
    
    NSString *title = @"";
    if (self.header_style == DDQUserOperationHeaderViewStyleLogin) {
        
        title = @"欢迎回来";
        self.header_titleLabel = [UILabel labelChangeText:title font:DDQFont(25.0) textColor:[UIColor blackColor]];
        
        [self addSubview:self.header_titleLabel];

//        self.header_personalButton = [UIButton buttonChangeFont:DDQFont(13.0) titleColor:[UIColor blackColor] image:nil backgroundImage:nil title:@"个人登录" attributeTitle:nil target:self sel:@selector(header_didSelectWithButton:)];
//
//        self.header_buttonUnderline = [UIView viewChangeBackgroundColor:[UIColor blackColor]];
//
//        self.header_baseButton = [UIButton buttonChangeFont:DDQFont(13.0) titleColor:[UIColor blackColor] image:nil backgroundImage:nil title:@"基地登录" attributeTitle:nil target:self sel:@selector(header_didSelectWithButton:)];
//
//        self.header_managerButton = [UIButton buttonChangeFont:DDQFont(13.0) titleColor:[UIColor blackColor] image:nil backgroundImage:nil title:@"管理员登录" attributeTitle:nil target:self sel:@selector(header_didSelectWithButton:)];
//
//        [self view_configSubviews:@[self.header_titleLabel, self.header_personalButton, self.header_baseButton, self.header_managerButton, self.header_buttonUnderline]];

    } else if (self.header_style == DDQUserOperationHeaderViewStyleRegister) {
        
        title = @"欢迎加入";
        self.header_titleLabel = [UILabel labelChangeText:title font:DDQFont(25.0) textColor:[UIColor blackColor]];
        [self addSubview:self.header_titleLabel];

    } else if (self.header_style == DDQUserOperationHeaderViewStyleForget) {
        
        title = @"找回密码";
        self.header_titleLabel = [UILabel labelChangeText:title font:DDQFont(25.0) textColor:[UIColor blackColor]];
        [self addSubview:self.header_titleLabel];

    }
}

- (void)view_updateContentSubviewsFrame {
    
    [super view_updateContentSubviewsFrame];

    if (self.header_style == DDQUserOperationHeaderViewStyleLogin) {
        
//        autoLayout(self.header_personalButton).ddq_leading(self.leading, 0.0).ddq_top(self.top, 0.0).ddq_fitSize();
//
//        autoLayout(self.header_baseButton).ddq_leading(self.header_personalButton.trailing, 15.0 * self.view_widthRate).ddq_top(self.header_personalButton.top, 0.0).ddq_fitSize();
//
//        autoLayout(self.header_managerButton).ddq_leading(self.header_baseButton.trailing, 15.0 * self.view_widthRate).ddq_top(self.header_personalButton.top, 0.0).ddq_fitSize();
        
//        if (self.header_index > 3 || self.header_index < 0) {
//
//            NSException *exception = [NSException exceptionWithName:NSInvalidArgumentException reason:@"header的index设置错误" userInfo:nil];
//            [exception raise];
//
//        }
//
//        UIView *tempView = nil;
//        if (self.header_index == 0) {
//
//            tempView = self.header_personalButton;
//
//        } else if (self.header_index == 1) {
//
//            tempView = self.header_baseButton;
//
//        } else {
//
//            tempView = self.header_managerButton;
//
//        }
//        autoLayout(self.header_buttonUnderline).ddq_leading(tempView.leading, 0.0).ddq_top(tempView.bottom, 0.0).ddq_size(CGSizeMake(tempView.width, 1.0));
        
        autoLayout(self.header_titleLabel).ddq_leading(self.leading, 0.0).ddq_top(self.top, 30.0 * self.view_widthRate).ddq_fitSize();

    } else {
        
        autoLayout(self.header_titleLabel).ddq_leading(self.top, 0.0).ddq_top(self.top, 0.0).ddq_fitSize();

    }
}

/**
 点击不同的登录按钮
 */
- (void)header_didSelectWithButton:(UIButton *)button {
    
    if (self.header_completed) {
        
//        DDQUserOperationHeaderSelectType selectType = DDQUserOperationHeaderSelectTypeToPersonalLogin;
//        if (button == self.header_baseButton) {
//
//            selectType = DDQUserOperationHeaderSelectTypeToBaseLogin;
//
//        } else if (button == self.header_managerButton) {
//
//            selectType = DDQUserOperationHeaderSelectTypeToManageLogin;
//
//        }
//        self.header_completed(selectType);
        
    }
}

- (void)header_didSelectTypeCompleted:(DDQUserOperationHeaderSelectCompleted)completed {
    
    if (completed) {
        
        self.header_completed = completed;
        
    }
}

@end
