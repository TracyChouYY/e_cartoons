//
//  DDQBaseLoginController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/20.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBaseLoginController.h"

#import "DDQForgetController.h"
#import "DDQBaseRegisterController.h"
#import "DDQUserProtocolController.h"
#import "DDQManagerLoginController.h"
#import "DDQPersonalLoginController.h"

#import "DDQLoginView.h"

#import "DDQBaseViewController+DDQLoginControllerHandler.h"

@interface DDQBaseLoginController () <DDQUserOperationDelegate>

@property (nonatomic, strong) DDQLoginView *loginView;

@end

@implementation DDQBaseLoginController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //Subview
    self.loginView = [[DDQLoginView alloc] initLoginViewWithType:DDQLoginViewTypeBase];
    [self.view addSubview:self.loginView];
    self.loginView.delegate = self;
 
    self.view.backgroundColor = [UIColor whiteColor];

}

- (NSString *)base_navigationTitle {
    
    return @"基地登录";
    
}

#pragma mark - Custom Delegate
- (void)login_didSelectDifferentViewType:(DDQLoginViewType)type loginView:(DDQLoginView *)view {
    
    [self base_handleDifferentLoginTypeWithClass:[DDQManagerLoginController class]];

}

- (void)login_didSelectToRegister {
    
    [self base_handleInitializeWithControllerClass:[DDQBaseRegisterController class] FromNib:NO title:nil propertys:nil];
    
}

- (void)login_didSelectForgetPassword {
    
    [self base_handleInitializeWithControllerClass:[DDQForgetController class] FromNib:NO title:nil propertys:nil];
    
}

- (void)login_didSelectLoginWithModel:(DDQUserOperationModel *)model {
    
    [self handler_handleLoginProcessWithType:DDQLoginHandlerTypeBase dataModel:model];

}

- (void)login_base_didSelectUserProtocol {
    
    [self base_handleInitializeWithControllerClass:[DDQUserProtocolController class] FromNib:NO title:nil propertys:nil];
    
}

@end
