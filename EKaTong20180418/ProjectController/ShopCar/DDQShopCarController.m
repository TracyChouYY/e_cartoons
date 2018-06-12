//
//  DDQShopCarController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/20.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQShopCarController.h"

#import "DDQSettleController.h"
#import "DDQActivityBaseDetailController.h"

@interface DDQShopCarController ()

@end

@implementation DDQShopCarController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    //WebPage
    self.web_requestUrl = [self.base_url stringByAppendingFormat:@"Shop/car/uid/%@", self.base_userID];
    
#warning 侧滑和点击事件容易冲突
#warning 不需要删除的js且全选有问题
    DDQWeakObject(self);
    //购物车详情js
    [self.web_jsBridge registerHandler:@"js-Objjd_xq" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        //购物车里不会出现活动，所以不用判断了
        DDQActivityBaseDetailController *detailC = [weakObjc base_handleInitializeWithControllerClass:[DDQActivityBaseDetailController class] FromNib:NO title:nil propertys:nil];
        detailC.detail_abID = data[weakObjc.web_dataKey];
        
    }];
     
#warning 一张订单应该不允许出现两个基地
#warning 这里的id和基地活动的格式不一样啊
    //购物车结算
    [self.web_jsBridge registerHandler:@"js-ObjcJs" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        DDQSettleController *settleC = [weakObjc base_handleInitializeWithControllerClass:[DDQSettleController class] FromNib:NO title:nil propertys:nil];
        settleC.settle_url = data[weakObjc.web_dataKey];
        settleC.settle_way = DDQSettleWayShopCar;
        settleC.settle_type = DDQSettleTypeBase;
        
    }];
}

- (DDQBaseNavigationBarStyle)base_navigationBarStyle {
    
    return DDQBaseNavigationBarStyleWhite;
    
}
@end
