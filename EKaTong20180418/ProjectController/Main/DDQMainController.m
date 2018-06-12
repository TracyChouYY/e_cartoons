//
//  DDQMainController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/20.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQMainController.h"

#import "DDQBaseController.h"
#import "DDQActivityListController.h"
#import "DDQActivityBaseDetailController.h"

#import "DDQBaseViewController+DDQHandleControllerHaveSearch.h"

@interface DDQMainController ()

@end

@implementation DDQMainController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.web_showWebTitle = NO;
    [self handle_navigationTitleSearchButtonwWithType:DDQSearchContentTypeBase];
    
    //WebPage
    self.web_requestUrl = self.base_url;
    
    DDQWeakObject(self);
    //基地点击事件
    [self.web_jsBridge registerHandler:@"js-Objjd" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        weakObjc.base_tabBarController.selectedIndex = 1;

    }];
    
    //活动点击事件
    [self.web_jsBridge registerHandler:@"js-Objhd" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        [weakObjc base_handleInitializeWithControllerClass:[DDQActivityListController class] FromNib:NO title:nil propertys:nil];

    }];
    
    //下面的基地点击事件
    [self.web_jsBridge registerHandler:@"js-Objjd_xq" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        DDQActivityBaseDetailController *detailC = [weakObjc base_handleInitializeWithControllerClass:[DDQActivityBaseDetailController class] FromNib:NO title:nil propertys:nil];
        detailC.detail_abID = data[weakObjc.web_dataKey];
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self handle_navigationTitleSearchButtonwWithType:DDQSearchContentTypeBase];
    
}

- (DDQBaseNavigationBarStyle)base_navigationBarStyle {
    
    return DDQBaseNavigationBarStyleWhite;
    
}

@end
