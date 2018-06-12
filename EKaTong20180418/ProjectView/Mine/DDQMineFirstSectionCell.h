//
//  DDQMineFirstSectionCell.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/23.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQCell.h"

#import "DDQMineCellDelegate.h"

NS_ASSUME_NONNULL_BEGIN
/**
 个人中心 - 分区一cell的布局
 */
@interface DDQMineFirstSectionCell : DDQCell 

+ (DDQMineFirstSectionCellStyle)mineFirstSectionStyle;//default DDQMineFirstSectionCellStylePersonal

@property (nonatomic, weak, nullable) id <DDQMineCellDelegate> delegate;

@end

@interface DDQMineFirstSectionModel : DDQBaseCellModel

@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *nickname;

/**
 今日收入
 */
@property (nonatomic, copy) NSString *jrxs;

/**
 累计收入
 */
@property (nonatomic, copy) NSString *ljxs;

/**
 我的财富
 */
@property (nonatomic, copy) NSString *wdcf;


@end

NS_ASSUME_NONNULL_END
