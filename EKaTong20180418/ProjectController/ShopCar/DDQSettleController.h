//
//  DDQSettleController.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/2.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQSettleType) {
    
    DDQSettleTypeActivity = 1,      //支付活动
    DDQSettleTypeBase,              //支付基地
    
};

typedef NS_ENUM(NSUInteger, DDQSettleWay) {
    
    DDQSettleWayPurchase = 1,       //立即购买
    DDQSettleWayShopCar,            //购物车

};

/**
 e卡通 - 结算页
 */
@interface DDQSettleController : DDQBaseViewController

#warning 关于我们，基地二维码做成网页
@property (nonatomic, copy) NSString *settle_url;
@property (nonatomic, assign) DDQSettleType settle_type;
@property (nonatomic, assign) DDQSettleWay settle_way;

@end

NS_ASSUME_NONNULL_END

