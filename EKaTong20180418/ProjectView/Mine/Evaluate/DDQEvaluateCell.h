//
//  DDQEvaluateCell.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/2.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQEvaluateCellStyle) {
    
    DDQEvaluateCellStyleUnknown,    //未知
    DDQEvaluateCellStyleTo,         //待评价
    DDQEvaluateCellStyleHave,       //已评价
    
};
@protocol DDQEvaluateCellDelegate;
/**
 评价页 - cell的基础布局
 */
@interface DDQEvaluateCell : DDQCell

@property (nonatomic, weak, nullable) id <DDQEvaluateCellDelegate> delegate;

+ (DDQEvaluateCellStyle)evaulateCellStyle;

@end

@protocol DDQEvaluateCellDelegate <NSObject>

@optional
- (void)evaluate_didSelectToEvaluateWithCell:(DDQEvaluateCell *)cell;
- (void)evaluate_didSelectSubInfoWithCell:(DDQEvaluateCell *)cell;

@end

NS_ASSUME_NONNULL_END

