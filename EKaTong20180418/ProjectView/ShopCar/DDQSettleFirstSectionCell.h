//
//  DDQSettleFirstSectionCell.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/2.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQSettleFirstSectionCellStyle) {
    
    DDQSettleFirstSectionCellStyleUnknown,      //样式未知
    DDQSettleFirstSectionCellStylePurchase,     //立即购买
    DDQSettleFirstSectionCellStyleJogin,        //参与活动
    
};

/**
 立即购买和填写活动订单 - 分区一的cell，显示一些活动信息
 */
@interface DDQSettleFirstSectionCell : DDQCell

+ (DDQSettleFirstSectionCellStyle)firstSectionCellStyle;

@end

@interface DDQSettleFirstSectionModel : DDQBaseCellModel

@property (nonatomic, copy) NSString *end;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *start;
@property (nonatomic, copy) NSString *aid;
@property (nonatomic, copy) NSString *bid;
@property (nonatomic, copy) NSString *address;

@end

NS_ASSUME_NONNULL_END

