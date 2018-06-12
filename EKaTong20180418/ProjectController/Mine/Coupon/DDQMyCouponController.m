//
//  DDQMyCouponController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/27.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQMyCouponController.h"

#import "DDQUsedCouponController.h"
#import "DDQUnusedCouponController.h"
#import "DDQExpiredCouponController.h"

#import "DDQOperationBar.h"

@interface DDQMyCouponController () <DDQOperationBarDelegate>

@property (nonatomic, strong) DDQOperationBar *coupon_bar;

@property (nonatomic, strong) DDQUsedCouponController *coupon_usedController;
@property (nonatomic, strong) DDQUnusedCouponController *coupon_unusedController;
@property (nonatomic, strong) DDQExpiredCouponController *coupon_expiredController;

@end

@implementation DDQMyCouponController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //Subviews
    self.coupon_bar = [[DDQOperationBar alloc] initBarWithContainer:@[@"未使用", @"已使用", @"已过期"]];
    [self.view addSubview:self.coupon_bar];
    self.coupon_bar.delegate = self;
    
    //RightItem
    UIButton *rightButton = [self setRightBarButtonItemStyle:DDQFoundationBarButtonText Content:@"优惠券说明"];
    [rightButton setTitleColor:self.view.defaultBlueColor forState:UIControlStateNormal];
    rightButton.titleLabel.font = DDQFont(15.0);
    
    //SubConfig
    [self coupon_subControllerConfig];
    
}

- (NSString *)base_navigationTitle {
    
    return @"我的优惠券";
    
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    autoLayout(self.coupon_bar).ddq_leading(self.view.leading, 0.0).ddq_top(self.view.top, self.base_safeTopInset).ddq_size(CGSizeMake(self.view.width, 44.0));
    
    UIView *controllerView = self.view.subviews.lastObject;
    autoLayout(controllerView).ddq_leading(self.coupon_bar.leading, 0.0).ddq_top(self.coupon_bar.bottom, 0.0).ddq_size(CGSizeMake(self.view.width, self.view.height - self.coupon_bar.frameMaxY - self.base_safeBottomInset));

}

/**
 子控制器配置
 */
- (void)coupon_subControllerConfig {
    
    self.coupon_unusedController = [[DDQUnusedCouponController alloc] init];
    self.coupon_usedController = [[DDQUsedCouponController alloc] init];
    self.coupon_expiredController = [[DDQExpiredCouponController alloc] init];
    
    [self addChildViewController:self.coupon_unusedController];
    [self.view addSubview:self.coupon_unusedController.view];
    
}

/**
 处理自控制器的显示

 @param index 点击的索引
 */
- (__kindof DDQBaseViewController *)coupon_handleChildControllerWithIndex:(NSInteger)index {
    
    DDQBaseViewController *controller = nil;

    switch (index) {
            
        case 0:
            
            controller = self.coupon_unusedController;
            
            break;
            
        case 1:
            
            controller = self.coupon_usedController;
            
            break;
            
        case 2:
            
            controller = self.coupon_expiredController;
            
            break;
            
        default:
            break;
    }
    
    return controller;
    
}

#pragma mark - Custom Bar Delegate
- (void)bar_didSelectWithIndex:(NSInteger)index lastIndex:(NSInteger)lastIndex {
    
    DDQBaseViewController *controller = [self coupon_handleChildControllerWithIndex:index];
    DDQBaseViewController *lastController = [self coupon_handleChildControllerWithIndex:lastIndex];

    [self addChildViewController:controller];
    [lastController removeFromParentViewController];
    [lastController.view removeFromSuperview];
    
    [self.view addSubview:controller.view];

}


@end
