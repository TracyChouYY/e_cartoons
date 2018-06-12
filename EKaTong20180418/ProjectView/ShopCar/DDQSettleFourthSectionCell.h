//
//  DDQSettleFourthSectionCell.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/2.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQFourthSettleWay) {
    
    DDQFourthSettleWayUnknown = 1,
    DDQFourthSettleWayWX,           //微信
    DDQFourthSettleWayAL,           //支付宝
    DDQFourthSettleWayOverage,      //余额
    
};
/**
 结算页 - 分区四的cell，显示支付方式
 */
@interface DDQSettleFourthSectionCell : DDQCell

@end

@interface DDQSettleWayModel : DDQBaseCellModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) DDQFourthSettleWay way;

@end

NS_ASSUME_NONNULL_END

