//
//  DDQEvaluateContainerController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/2.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQEvaluateContainerController.h"

#import "DDQToEvaluatedController.h"
#import "DDQHaveEvaluatedController.h"

#import "DDQOperationBar.h"

@interface DDQEvaluateContainerController () <DDQOperationBarDelegate>

@property (nonatomic, strong) DDQOperationBar *container_bar;
@property (nonatomic, strong) DDQToEvaluatedController *container_toController;
@property (nonatomic, strong) DDQHaveEvaluatedController *container_haveController;
@property (nonatomic, strong) NSMutableArray<__kindof DDQBaseViewController *> *container_dataSource;

@end

@implementation DDQEvaluateContainerController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //Subview
    self.container_bar = [[DDQOperationBar alloc] initBarWithContainer:@[@"待评价", @"已评价"]];
    [self.view addSubview:self.container_bar];
    self.container_bar.delegate = self;
    
    //SubController
    self.container_dataSource = [NSMutableArray arrayWithCapacity:2];
    [self evaulate_subControllerConfig];
    
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    self.container_bar.frame = CGRectMake(0.0, self.base_safeTopInset, self.view.width, 40.0);
    
    autoLayout(self.view.subviews.lastObject).ddq_leading(self.container_bar.leading, 0.0).ddq_top(self.container_bar.bottom, 0.0).ddq_size(CGSizeMake(self.container_bar.width, self.view.height - self.base_safeTopInset - self.base_safeBottomInset - self.container_bar.frameMaxY));
    
}

- (NSString *)base_navigationTitle {
    
    return @"评价中心";
    
}

/**
 评价中心的自控制器
 */
- (void)evaulate_subControllerConfig {
    
    DDQToEvaluatedController *toEvaluatedC = [[DDQToEvaluatedController alloc] init];
    DDQHaveEvaluatedController *haveEvaluatedC = [[DDQHaveEvaluatedController alloc] init];
    
    [self.container_dataSource addObjectsFromArray:@[toEvaluatedC, haveEvaluatedC]];
    
    [self addChildViewController:toEvaluatedC];
    [self.view addSubview:toEvaluatedC.view];

}

#pragma mark - Custom Bar Delegate
- (void)bar_didSelectWithIndex:(NSInteger)index lastIndex:(NSInteger)lastIndex {
    
    DDQBaseViewController *fromC = [self.container_dataSource objectAtIndex:lastIndex];
    DDQBaseViewController *toC = [self.container_dataSource objectAtIndex:index];
    
    [fromC removeFromParentViewController];
    [fromC.view removeFromSuperview];
    
    [self addChildViewController:toC];
    [self.view addSubview:toC.view];
    
}

@end
