//
//  DDQDailyBonusController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/27.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQDailyBonusController.h"

@interface DDQDailyBonusController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *db_contentViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *db_contentViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *db_labelLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *db_lineTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *db_lineHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *db_buttonBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *db_buttonHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *db_buttonWidth;

@property (weak, nonatomic) IBOutlet UIView *db_contentView;
@property (weak, nonatomic) IBOutlet UIButton *db_signButton;

@property (weak, nonatomic) IBOutlet UILabel *db_firstDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *db_secondDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *db_thirdDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *db_fourthDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *db_fifthDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *db_sixthDayLabel;
@property (nonatomic, copy) NSArray<UILabel *> *db_dayLabels;

/**
 为什么要写这么两个呢，因为contentView我masksToBounds为YES，视图就被切了。
 手写的话我的父视图就不再是contentView，而是self.view。
 */
@property (nonatomic, strong) UIButton *db_closeButton;
@property (nonatomic, strong) UILabel *db_dayCountLabel;

@end

@implementation DDQDailyBonusController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    //Subview Config
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.db_dayLabels = @[self.db_firstDayLabel, self.db_secondDayLabel, self.db_thirdDayLabel, self.db_fourthDayLabel, self.db_fifthDayLabel, self.db_sixthDayLabel];
    
    self.db_closeButton = [UIButton buttonChangeFont:nil titleColor:nil image:kSetImage(@"signIn_close") backgroundImage:nil title:nil attributeTitle:nil target:self sel:@selector(db_didSelectClose)];
    [self.view addSubview:self.db_closeButton];
    self.db_contentView.layer.masksToBounds = YES;

    self.db_dayCountLabel = [UILabel labelChangeText:@"0" font:DDQFont(45.0) textColor:self.view.defaultBlueColor];
    [self.view addSubview:self.db_dayCountLabel];
    self.db_dayCountLabel.backgroundColor = [UIColor whiteColor];
    self.db_dayCountLabel.layer.masksToBounds = YES;

}

- (void)updateViewConstraints {
    
    [super updateViewConstraints];
    
    self.db_contentView.layer.cornerRadius = 10.0;
    
    self.db_signButton.layer.cornerRadius = self.db_signButton.height * 0.5;
    for (UILabel *label in self.db_dayLabels) {
        
        label.layer.cornerRadius = label.height * 0.5;
        label.layer.masksToBounds = YES;
        
    }
    
    self.db_contentViewWidth.constant = 280.0 * self.base_widthRate;
    self.db_contentViewHeight.constant = 400.0 * self.base_widthRate;
    self.db_labelLeft.constant = 70.0 * self.base_widthRate;
    self.db_lineTop.constant = 50.0 * self.base_widthRate;
    self.db_lineHeight.constant = 70.0 * self.base_widthRate;
    self.db_buttonWidth.constant = 200.0 * self.base_widthRate;
    self.db_buttonHeight.constant = 50.0 * self.base_widthRate;
    self.db_buttonBottom.constant = 30.0 * self.base_widthRate;
    
    [self.db_closeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.db_contentView.mas_right);
        make.centerY.equalTo(self.db_contentView.mas_top);
        
    }];
    
    [self.db_dayCountLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.db_contentView.mas_centerX);
        make.centerY.equalTo(self.db_contentView.mas_top);
        make.width.mas_equalTo(47.0);
        
    }];
    self.db_dayCountLabel.layer.cornerRadius = 5.0;
    
}

- (UIModalPresentationStyle)modalPresentationStyle {
    
    return UIModalPresentationOverFullScreen;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}

/**
 点击关闭按钮
 */
- (void)db_didSelectClose {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];

}

@end
