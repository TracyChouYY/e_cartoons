//
//  DDQLevelView.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/26.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQLevelView.h"

@interface DDQLevelView ()

@property (nonatomic, strong) UILabel *level_label;
@property (nonatomic, strong) UIImageView *level_backgroundImgeView;

@end

@implementation DDQLevelView

- (instancetype)initLevelViewWithStyle:(DDQLevelViewStyle)style {
    
    self = [super initViewWithFrame:CGRectZero];
    
    self.level_backgroundImgeView = [UIImageView imageViewChangeImage:kSetImage(@"mine_levelContent")];
    
    NSString *levelString = @"";
    if (style == DDQLevelViewStyleNormal) {
        
        levelString = @"普通会员";
        
    } else if (style == DDQLevelViewStyleIron) {
        
        levelString = @"铁牌会员";
        
    } else if (style == DDQLevelViewStyleSilver) {
        
        levelString = @"银牌会员";
        
    } else {
        
        levelString = @"钻石会员";
        
    }
    self.level_label = [UILabel labelChangeText:levelString font:DDQFont(9.0) textColor:[UIColor whiteColor]];
    
    [self view_configSubviews:@[self.level_backgroundImgeView, self.level_label]];
    
    return self;
    
}

- (instancetype)initViewWithFrame:(CGRect)frame {
    
    return [self initLevelViewWithStyle:DDQLevelViewStyleIron];
    
}

- (void)sizeToFit {
    
    [super sizeToFit];
    
    CGRect frame = self.frame;
    frame.size = self.level_backgroundImgeView.size;
    self.frame = frame;
    
}

+ (BOOL)requiresConstraintBasedLayout {
    
    return YES;
    
}

- (void)updateConstraints {
    
    [self.level_backgroundImgeView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        
    }];
    
    [self.level_label mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.level_backgroundImgeView.mas_left).offset(15.0);
        make.centerY.equalTo(self.mas_centerY);
        make.height.lessThanOrEqualTo(self.level_backgroundImgeView.mas_height);
        make.right.equalTo(self.level_backgroundImgeView.mas_right).offset(-5.0);
        
    }];
    
    [super updateConstraints];
    
}

- (void)level_updateViewWithStyle:(DDQLevelViewStyle)style {
    
    
}

@end
