//
//  DDQManagerLoginController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/20.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQManagerLoginController.h"

#import "DDQBaseLoginController.h"
#import "DDQPersonalLoginController.h"

#import "DDQLoginView.h"

#import "DDQBaseViewController+DDQLoginControllerHandler.h"

@interface DDQManagerLoginController () <DDQUserOperationDelegate>

@property (nonatomic, strong) DDQLoginView *loginView;

@end

@implementation DDQManagerLoginController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //Subview
    self.loginView = [[DDQLoginView alloc] initLoginViewWithType:DDQLoginViewTypeManager];
    [self.view addSubview:self.loginView];
    self.loginView.delegate = self;
    
    self.view.backgroundColor = [UIColor whiteColor];

}

- (NSString *)base_navigationTitle {
    
    return @"管理员登录";
    
}

#pragma mark - Custom Delegate
- (void)login_didSelectDifferentViewType:(DDQLoginViewType)type loginView:(DDQLoginView *)view {
    
    if (type == view.login_viewType) return;
    
    Class targetClass = [DDQPersonalLoginController class];
    if (type == DDQLoginViewTypeBase) {
        
        targetClass = [DDQBaseLoginController class];
        
    }
    [self base_handleDifferentLoginTypeWithClass:targetClass];
    
}

- (void)login_didSelectLoginWithModel:(DDQUserOperationModel *)model {
    
    [self handler_handleLoginProcessWithType:DDQLoginHandlerTypeManager dataModel:model];

}

@end
