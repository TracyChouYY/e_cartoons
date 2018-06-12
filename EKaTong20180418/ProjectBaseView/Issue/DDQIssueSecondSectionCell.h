//
//  DDQIssueSecondSectionCell.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/3.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQCell.h"

#import "DDQContentInputView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQIssueSecondSectionCellStyle) {
    
    DDQIssueSecondSectionCellStyleBase,         //发布基地所需要的信息,default value
    DDQIssueSecondSectionCellStyleActivity,     //发布活动所需要的信息
    
};
@protocol DDQIssueSecondSectionCellDelegate;

/**
 发布页 - 分区二的cell，显示信息
 */
@interface DDQIssueSecondSectionCell : DDQCell

+ (DDQIssueSecondSectionCellStyle)secondSectionCellStyle;

@property (nonatomic, weak, nullable) id <DDQIssueSecondSectionCellDelegate> delegate;
@property (nonatomic, readonly) NSString *startTime;
@property (nonatomic, readonly) NSString *endTime;
@property (nonatomic, readonly) NSString *sort;
@property (nonatomic, readonly) NSString *price;
@property (nonatomic, readonly) NSString *parking;
@property (nonatomic, readonly) NSString *setLoction;
@property (nonatomic, readonly) NSString *number;

@end

@interface DDQIssueSecondSectionModel : DDQBaseCellModel

/**
 基地分区一的字段
 */
@property (nonatomic, copy) NSString *base_resort;
@property (nonatomic, copy) NSString *base_price;
@property (nonatomic, copy) NSString *base_park;
@property (nonatomic, copy) NSString *type_name;
@property (nonatomic, copy) NSString *base_type;
@property (nonatomic, copy) NSString *base_end;
@property (nonatomic, copy) NSString *base_start;

/**
 活动分区
 */
@property (nonatomic, copy) NSString *activity_number;
@property (nonatomic, copy) NSString *activity_price;
@property (nonatomic, copy) NSString *activity_destination;
@property (nonatomic, copy) NSString *activity_start;
@property (nonatomic, copy) NSString *activity_end;

@end

@protocol DDQIssueSecondSectionCellDelegate <NSObject>

@optional

/**
 选择开始时间

 @param cell 对应显示的cell
 */
- (void)second_didSelectChoiceStartTimeWithCell:(DDQIssueSecondSectionCell *)cell inputView:(DDQContentInputView *)view;

/**
 选择结束的时间

 @param cell 对应显示的cell
 */
- (void)second_didSelectChoiceEndTimeWithCell:(DDQIssueSecondSectionCell *)cell inputView:(DDQContentInputView *)view;

/**
 选择分类

 @param cell 对应显示的cell
 */
- (void)second_didSelectChoiceSortWithCell:(DDQIssueSecondSectionCell *)cell inputView:(DDQContentInputView *)view;

/**
 选择停车位

 @param cell 对应显示的cell
 */
- (void)second_didSelectChoiceStopLocationWithCell:(DDQIssueSecondSectionCell *)cell inputView:(DDQContentInputView *)view;

@end

NS_ASSUME_NONNULL_END

