//
//  DDQSettleSecondSectionCell.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/2.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^DDQSettleSelectNumberCompleted)(NSInteger number);

/**
 结算页 - 分区二的cell，显示购买数量
 */
@interface DDQSettleSecondSectionCell : DDQCell

/**
 当数量发生变化时回调
 */
- (void)second_notificationWhenNumberChange:(DDQSettleSelectNumberCompleted)completed;

@end

NS_ASSUME_NONNULL_END

