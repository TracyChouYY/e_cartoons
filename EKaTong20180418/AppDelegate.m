//
//  AppDelegate.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/18.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "AppDelegate.h"

#import "DDQPersonalLoginController.h"

#import "DDQRootController.h"
#import "DDQBaseMineController.h"
#import "DDQManagerMineController.h"

#import <IQKeyboardManager/IQKeyboardManager.h>
#import <UMSocialCore/UMSocialCore.h>
#import <AlipaySDK/AlipaySDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    //登录状态判断
    DDQBaseViewController *baseController = [[DDQBaseViewController alloc] init];
    DDQWeakObject(self);
    [baseController base_handleUserLoginStatus:^(DDQBaseLoginStatus status) {
        
        DDQStrongObject(weakObjc);
        if (status == DDQBaseLoginStatusLogin) {

            if (baseController.base_type == 2) {
                
                strongObjc.window.rootViewController = [[DDQNavigationController alloc] initWithRootViewControllerClass:[DDQBaseMineController class] FromNib:NO];
                
            } else if (baseController.base_type == 3) {
                
                strongObjc.window.rootViewController = [[DDQNavigationController alloc] initWithRootViewControllerClass:[DDQManagerMineController class] FromNib:NO];
                
            } else {
                
                strongObjc.window.rootViewController = [[DDQRootController alloc] initTabBarControllerUseSystemBar:NO];

            }
        } else if (status == DDQBaseLoginStatusNotLogin) {
            
            strongObjc.window.rootViewController = [[DDQNavigationController alloc] initWithRootViewControllerClass:[DDQPersonalLoginController class] FromNib:NO];

        }
    }];
    
    //登录成功
    [DDQNotificationCenter addObserverForName:DDQLoginSuccessNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        DDQStrongObject(weakObjc);
        if (baseController.base_type == 1) {
            
            strongObjc.window.rootViewController = [[DDQRootController alloc] initTabBarControllerUseSystemBar:NO];
            
        } else if (baseController.base_type == 2) {
            
            strongObjc.window.rootViewController = [[DDQNavigationController alloc] initWithRootViewControllerClass:[DDQBaseMineController class] FromNib:NO];

        } else if (baseController.base_type == 3) {
            
            strongObjc.window.rootViewController = [[DDQNavigationController alloc] initWithRootViewControllerClass:[DDQManagerMineController class] FromNib:NO];

        }
    }];
    
    //退出登录
    [DDQNotificationCenter addObserverForName:DDQLogoutSuccessNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        DDQStrongObject(weakObjc);
        strongObjc.window.rootViewController = [[DDQNavigationController alloc] initWithRootViewControllerClass:[DDQPersonalLoginController class] FromNib:NO];
        
    }];

    //KeyBoardManager
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.shouldResignOnTouchOutside = YES;
    manager.enableAutoToolbar = NO;
    
    //Third Config
    UMSocialManager *socialManager = [UMSocialManager defaultManager];
    [socialManager setUmSocialAppkey:DDQUMAppKey];
    
    [socialManager setPlaform:UMSocialPlatformType_QQ appKey:DDQQQAppID appSecret:DDQQQAppKey redirectURL:nil];
    [socialManager setPlaform:UMSocialPlatformType_WechatSession appKey:DDQWXAppID appSecret:DDQWXAppSecret redirectURL:nil];
    return YES;
    
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            
            DDQLog(@"%@", resultDic);
            
        }];
        return YES;
        
    }
    return [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    
}


@end
