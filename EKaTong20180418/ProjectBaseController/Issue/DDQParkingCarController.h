//
//  DDQParkingCarController.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/11.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQParkingCarStatus) {
    
    DDQParkingCarStatusFree,        //免费停车
    DDQParkingCarStatusFee,         //收费停车
    
};
typedef void(^DDQSelectParkingCarStatus)(DDQParkingCarStatus status, NSString *text);


/**
 e卡通 - 停车位选择
 */
@interface DDQParkingCarController : DDQBaseViewController

- (void)parking_didSelectParkingStatus:(DDQSelectParkingCarStatus)status;

@end

NS_ASSUME_NONNULL_END
