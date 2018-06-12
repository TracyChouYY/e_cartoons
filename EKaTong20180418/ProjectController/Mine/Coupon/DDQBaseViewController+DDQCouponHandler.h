//
//  DDQBaseViewController+DDQCouponHandler.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/17.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBaseViewController.h"

#import "DDQCouponCell.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^DDQCouponRequestCompleted)(NSArray<DDQCouponModel *> *dataSource);
/**
 优惠券处理类
 */
@interface DDQBaseViewController (DDQCouponHandler)

/**
 请求不同状态下的优惠券数据
 */
- (void)handler_requestCouponDataWithType:(NSString *)type completed:(DDQCouponRequestCompleted)completed;

@end

NS_ASSUME_NONNULL_END
