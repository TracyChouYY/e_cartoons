//
//  DDQOrderProductInfoView.h
//
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^DDQOrderProductInfoCompleted)(void);

/**
 订单相关 - 订单的商品信息
 */
@interface DDQOrderProductInfoView : DDQView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSArray *info_dataSource;

@property (nonatomic, assign) CGFloat info_estimateHeight;

/**
 点击cell的subCell

 @param completed 回调
 */
- (void)info_didSelectSubCellCompleted:(DDQOrderProductInfoCompleted)completed;

@end

NS_ASSUME_NONNULL_END
