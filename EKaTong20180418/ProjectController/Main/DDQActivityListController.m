//
//  DDQActivityListController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/8.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQActivityListController.h"

#import "DDQActivityBaseDetailController.h"
#import "DDQBaseViewController+DDQHandleControllerHaveSearch.h"

@interface DDQActivityListController ()

@end

@implementation DDQActivityListController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.web_showWebTitle = NO;
    
    //WebPage
    self.web_requestUrl = [self.base_url stringByAppendingString:@"Activity/lists"];
    
    DDQWeakObject(self);
    //活动列表点击事件
    [self.web_jsBridge registerHandler:@"js-Objhd_xq" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        DDQActivityBaseDetailController *detailC = [weakObjc base_handleInitializeWithControllerClass:[DDQActivityBaseDetailController class] FromNib:NO title:nil propertys:nil];
        detailC.detail_abID = data[weakObjc.web_dataKey];
        [detailC detail_updateControllerType:DDQActivityBaseDetailTypeActivity];
        
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self handle_navigationTitleSearchButtonwWithType:DDQSearchContentTypeActivity];

}

@end
