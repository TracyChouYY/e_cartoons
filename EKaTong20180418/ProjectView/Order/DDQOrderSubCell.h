//
//  DDQOrderSubCell.h
//
//  Copyright © 2017年 我叫咚咚枪. All rights reserved.
//

#import "DDQCell.h"

NS_ASSUME_NONNULL_BEGIN

/**
 我的订单 - 订单商品信息cell
 */
@interface DDQOrderSubCell : DDQCell

+ (CGFloat)sub_estimateHeight;

@end

@interface DDQOrderSubModel : DDQBaseCellModel

/**
 商品名
 */
@property (nonatomic, copy, nullable) NSString *name;

/**
 商品图片
 */
@property (nonatomic, copy, nullable) NSString *image;

/**
 商品单价
 */
@property (nonatomic, copy, nullable) NSString *price;

/**
 购买数量
 */
@property (nonatomic, copy, nullable) NSString *num;

/**
 时间
 */
@property (nonatomic, copy, nullable) NSString *time;

@end

NS_ASSUME_NONNULL_END
