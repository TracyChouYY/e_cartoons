//
//  DDQRootController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/19.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQRootController.h"

#import "DDQMainController.h"
#import "DDQBaseController.h"
#import "DDQMineController.h"
#import "DDQShopCarController.h"

@interface DDQRootController ()

@property (nonatomic, strong) NSMutableDictionary<DDQTabBarItemSourceKey, id> *root_subControllerSource;

@end

@implementation DDQRootController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //SubController
    [self root_subControllerConfig];
    
}

- (void)dealloc {
    
    DDQLog(@"%@", self);
    
}

/**
 子控制器配置
 */
- (void)root_subControllerConfig {
    
    self.root_subControllerSource = [NSMutableDictionary dictionaryWithDictionary:@{DDQTabBarItemSourceNormalColor:kSetColor(57.0, 57.0, 57.0, 1.0), DDQTabBarItemSourceSelectedColor:self.view.defaultBlueColor}];
    
    [self.root_subControllerSource setObject:@"首页" forKey:DDQTabBarItemSourceItemTitle];
    [self.root_subControllerSource setObject:kSetImage(@"main_normal") forKey:DDQTabBarItemSourceNormalImage];
    [self.root_subControllerSource setObject:kSetImage(@"main_selected") forKey:DDQTabBarItemSourceSelectedImage];
    [self tab_managerNavigationControllerRootClass:[DDQMainController class] rootFromXib:NO itemSource:self.root_subControllerSource.copy];
    
    [self.root_subControllerSource setObject:@"基地" forKey:DDQTabBarItemSourceItemTitle];
    [self.root_subControllerSource setObject:kSetImage(@"base_normal") forKey:DDQTabBarItemSourceNormalImage];
    [self.root_subControllerSource setObject:kSetImage(@"base_selected") forKey:DDQTabBarItemSourceSelectedImage];
    [self tab_managerNavigationControllerRootClass:[DDQBaseController class] rootFromXib:NO itemSource:self.root_subControllerSource.copy];
    
    [self.root_subControllerSource setObject:@"购物车" forKey:DDQTabBarItemSourceItemTitle];
    [self.root_subControllerSource setObject:kSetImage(@"car_normal") forKey:DDQTabBarItemSourceNormalImage];
    [self.root_subControllerSource setObject:kSetImage(@"car_selected") forKey:DDQTabBarItemSourceSelectedImage];
    [self tab_managerNavigationControllerRootClass:[DDQShopCarController class] rootFromXib:NO itemSource:self.root_subControllerSource.copy];
    
    [self.root_subControllerSource setObject:@"我的" forKey:DDQTabBarItemSourceItemTitle];
    [self.root_subControllerSource setObject:kSetImage(@"mine_normal") forKey:DDQTabBarItemSourceNormalImage];
    [self.root_subControllerSource setObject:kSetImage(@"mine_selected") forKey:DDQTabBarItemSourceSelectedImage];
    [self tab_managerNavigationControllerRootClass:[DDQMineController class] rootFromXib:NO itemSource:self.root_subControllerSource.copy];

    [self tab_tabBarLayoutItems];
    
    for (DDQBarItem *item in self.tab_tabBar.bar_items) {
        
        item.item_titleLabel.font = DDQFont(10.0);
        
    }
}

@end
