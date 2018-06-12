//
//  DDQManagerReviewCell.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/3.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQManagerReviewCellStyle) {
    
    DDQManagerReviewCellStyleRegister,      //default value
    DDQManagerReviewCellStyleBase,
    DDQManagerReviewCellStyleActivity,
    
};

/**
 管理员审核页（活动、基地、注册），cell布局
 */
@interface DDQManagerReviewCell : DDQCell

+ (DDQManagerReviewCellStyle)reviewCellStyle;

@end

NS_ASSUME_NONNULL_END

