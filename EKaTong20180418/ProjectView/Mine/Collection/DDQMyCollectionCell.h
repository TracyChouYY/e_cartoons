//
//  DDQMyCollectionCell.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/27.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQCell.h"

NS_ASSUME_NONNULL_BEGIN

/**
 我的收藏 - cell布局
 */
@interface DDQMyCollectionCell : DDQCell

@end

@interface DDQMyCollectionModel : DDQBaseCellModel

@property (nonatomic, strong) NSString *end;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *start;

/**
 收藏id
 */
@property (nonatomic, strong) NSString *cid;

/**
 基地id
 */
@property (nonatomic, strong) NSString *bid;

/**
 活动id
 */
@property (nonatomic, strong) NSString *aid;

@end

NS_ASSUME_NONNULL_END

