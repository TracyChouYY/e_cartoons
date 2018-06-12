//
//  DDQCouponCell.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/17.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQCell.h"

NS_ASSUME_NONNULL_BEGIN

/**
 优惠券 - cell的布局
 */
@interface DDQCouponCell : DDQCell

@end

@interface DDQCouponModel : DDQBaseCellModel

@property (nonatomic, copy) NSString *coupon_end;
@property (nonatomic, copy) NSString *coupon_id;
@property (nonatomic, copy) NSString *coupon_image;
@property (nonatomic, copy) NSString *coupon_name;
@property (nonatomic, copy) NSString *coupon_max;
@property (nonatomic, copy) NSString *coupon_price;
@property (nonatomic, copy) NSString *coupon_start;
@property (nonatomic, copy) NSString *coupon_state;

@end

NS_ASSUME_NONNULL_END

