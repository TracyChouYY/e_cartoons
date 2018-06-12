//
//  DDQMineSecondSectionCell.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/23.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQCell.h"

#import "DDQMineCellDelegate.h"

NS_ASSUME_NONNULL_BEGIN

/**
 个人中心 - 分区二的cell，个人的个人中心独占，用来显示订单信息
 */
@interface DDQMineSecondSectionCell : DDQCell

@property (nonatomic, weak, nullable) id <DDQMineCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

