//
//  DDQBaseController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/20.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBaseController.h"

#import "DDQBaseSearchController.h"
#import "DDQActivityBaseDetailController.h"

#import "DDQBaseViewController+DDQHandleControllerHaveSearch.h"

@interface DDQBaseController ()

@end

@implementation DDQBaseController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.web_showWebTitle = NO;

    //WebPage
    self.web_requestUrl = [self.base_url stringByAppendingString:@"Base/lists"];
 
    DDQWeakObject(self);
    //基地列表点击事件
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
