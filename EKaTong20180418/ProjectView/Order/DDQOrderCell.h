//
//  DDQOrderCell.h
//
//  Copyright © 2017年 我叫咚咚枪. All rights reserved.
//

#import "DDQCell.h"

#import "DDQOrderOperationBar.h"

NS_ASSUME_NONNULL_BEGIN

@class DDQOrderSubModel;
@protocol DDQOrderCellDelegate;

/**
 我的订单 - Cell布局
 鉴于我需要试验自己的layout，所以这个cell的布局我重新写。
 
 */
@interface DDQOrderCell : DDQCell

@property (nonatomic, weak, nullable) id <DDQOrderCellDelegate> delegate;

@end

@protocol DDQOrderCellDelegate <NSObject>

@optional
- (void)order_didSelectFunctionWithType:(DDQOrderOperationType)type cell:(DDQOrderCell *)cell;
- (void)order_didSelectSubOrderCellWithCell:(DDQOrderCell *)cell;

@end

@interface DDQOrderModel : DDQBaseCellModel

/** 订单总价 */
@property (nonatomic, copy, nullable) NSString *allmoney;
/** 订单号 */
@property (nonatomic, copy, nullable) NSString *order_number;
/** 订单商品 */
@property (nonatomic, copy, nullable) NSArray<DDQOrderSubModel *> *order_content;
/** 订单状态 */
@property (nonatomic, copy, nullable) NSString *state;
/** 使用状态 */
@property (nonatomic, copy, nullable) NSString *status;
/** 订单ID */
@property (nonatomic, copy, nullable) NSString *order_id;

#pragma mark - 这个工程中的submodel需要自己创建
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


//下面的两个属性用在详情页
/** 商品总价 */
//@property (nonatomic, copy, nullable) NSString *yprices;
/** 订单总价 */
//@property (nonatomic, copy, nullable) NSString *zprices;

/** 快递单号 */
//@property (nonatomic, copy, nullable) NSString *invoice_no;
/** 快递公司 */
//@property (nonatomic, copy, nullable) NSString *wlname;

/** 订单状态对应的功能名称（这是自定义字段，用来记录这个model也就是这个订单所允许的功能） */
@property (nonatomic, copy, nullable) NSArray<NSString *> *functions;

/** 订单状态对应的描述（用来记录订单对应的状态，同样也是自定义字段） */
@property (nonatomic, copy, nullable) NSString *stateName;

@end

NS_ASSUME_NONNULL_END
