//
//  DDQIssueController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/3.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQIssueController.h"

@interface DDQIssueController ()

@property (nonatomic, strong) DDQButton *issue_baseButton;
@property (nonatomic, strong) DDQButton *issue_activityButton;
@property (nonatomic, strong) UIButton *issue_closeButton;

@property (nonatomic, copy) DDQIssueDidSelectBase issue_base;
@property (nonatomic, copy) DDQIssueDidSelectActivity issue_activity;

@end

@implementation DDQIssueController

- (void)viewDidLoad {
    
    [super viewDidLoad];
 
    //Subviews
    [self issue_layoutSubviewsConfig];
    
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    autoLayout(self.issue_closeButton).ddq_bottom(self.view.bottom, self.base_safeBottomInset + 30.0 * self.base_widthRate).ddq_centerX(self.view.centerX, 0.0).ddq_size(CGSizeMake(45.0, 45.0));
    
    autoLayout(self.issue_baseButton).ddq_trailing(self.view.centerX, 30.0 * self.base_widthRate).ddq_bottom(self.issue_closeButton.top, 120.0 * self.base_widthRate).ddq_fitSize();
    
    autoLayout(self.issue_activityButton).ddq_leading(self.view.centerX, 30.0 * self.base_widthRate).ddq_centerY(self.issue_baseButton.centerY, 0.0).ddq_fitSize();

}

/**
 布局子视图
 */
- (void)issue_layoutSubviewsConfig {
    
    NSMutableArray *subViews = [NSMutableArray arrayWithCapacity:3];
    int isIssue = self.base_infomationManager.base.intValue;
    NSString *statusString = @"";
    if (isIssue == 1) {
        
        statusString = @"编辑基地";
        
    } else {
        
        statusString = @"发布基地";
        
    }
    
    self.issue_baseButton = [DDQButton ddq_customButtonWithStyle:DDQButtonStyleTopImageView fontSize:15.0 title:statusString image:kSetImage(@"base_base") titleColor:kSetColor(34.0, 34.0, 34.0, 1.0) target:self selector:@selector(issue_didSelectBaseIssue)];
    self.issue_baseButton.control_space = 10.0;
    
    self.issue_activityButton = [DDQButton ddq_customButtonWithStyle:DDQButtonStyleTopImageView fontSize:15.0 title:@"发布活动" image:kSetImage(@"base_activity") titleColor:kSetColor(34.0, 34.0, 34.0, 1.0) target:self selector:@selector(issue_didSelectActivityIssue)];
    self.issue_activityButton.control_space = 10.0;
    [subViews addObjectsFromArray:@[self.issue_baseButton, self.issue_activityButton]];

    self.issue_closeButton = [UIButton buttonChangeFont:nil titleColor:nil image:kSetImage(@"base_close") backgroundImage:nil title:nil attributeTitle:nil target:self sel:@selector(issue_didSelectClose)];
    [subViews addObject:self.issue_closeButton];
    
    [self.view view_configSubviews:subViews];
    
}

/**
 点击发布基地
 */
- (void)issue_didSelectBaseIssue {
    
    if (self.issue_base) {
        
        self.issue_base();
        
    }
}

/**
 点击活动发布
 */
- (void)issue_didSelectActivityIssue {
    
    if (self.issue_activity) {
        
        self.issue_activity();
        
    }
}

/**
 点击关闭按钮
 */
- (void)issue_didSelectClose {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)issue_didSelectBase:(DDQIssueDidSelectBase)base {
    
    if (base) {
        
        self.issue_base = base;
        
    }
}

- (void)issue_didSelectActivity:(DDQIssueDidSelectActivity)activity {
    
    if (activity) {
        
        self.issue_activity = activity;
        
    }
}

@end
