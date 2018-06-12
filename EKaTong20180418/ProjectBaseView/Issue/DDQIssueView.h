//
//  DDQIssueView.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/3.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DDQIssueViewDelagte;
typedef NS_ENUM(NSUInteger, DDQIssueViewStlye) {
    
    DDQIssueViewStyleBase,
    DDQIssueViewStlyeActivity,

};

typedef NSString *DDQIssueImageDataKey;
/**
 基地（基地和活动）发布的布局
 */
@interface DDQIssueView : DDQView

- (instancetype)initIssueViewWithStyle:(DDQIssueViewStlye)style DDQ_DESIGNATED_INITIALIZER;

@property (nonatomic, weak, nullable) id <DDQIssueViewDelagte> delegate;

@property (nonatomic, copy) NSArray<NSArray <DDQBaseCellModel *> *> *issue_dataSource;

@end

UIKIT_EXTERN DDQIssueImageDataKey const DDQIssueImageDataIndexKey;
UIKIT_EXTERN DDQIssueImageDataKey const DDQIssueImageDataImageKey;

@interface DDQIssueDataModel : DDQFoundationModel

//公有的
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content1;
@property (nonatomic, copy) NSString *content2;
/**
 我以点击图片的索引+1为键（因为所传图片的索引从1开始）。
 而取值的时候需要注意，可能为字符串也可能为图片。为什么呢？
 图片就不说了，就是用户选择的图片。
 而出现字符串的话，则是这个图片的url的路径，因为后台需要根据这个去判断是否替换对应位置的图片。当字符串为空时，则会删除这个位置上的图片。
 总的来说，这个属性不会为空
 
 算了，不那么麻烦了。
 */
@property (nonatomic, copy) NSArray *changeImages;
@property (nonatomic, copy) NSString *position;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;

/**
 集合地
 */
@property (nonatomic, copy) NSString *set;

//提交基地所需
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *parking;

//提交活动所需
@property (nonatomic, copy) NSString *number;

@end

@protocol DDQIssueViewDelagte <NSObject>

@optional

/**
 点击选择开始时间
 */
- (void)issue_didSelectPickerStartTime:(void(^)(NSString *time))startTime;

/**
 点击选择结束时间
 */
- (void)issue_didSelectPickerEndTime:(void(^)(NSString *time))endTime;

/**
 选择的停车位置
 */
- (void)issue_didSelectStopLocation:(void(^)(NSString *location))location;

/**
 选择分类
 */
- (void)issue_didSelectSort:(void(^)(NSString *sortType))sort;

/**
 选择活动或者基地的位置
 */
- (void)issue_didSelectContentPosition:(void(^)(NSString *position))position;

/**
 选择活动或基地的图片
 */
- (void)issue_didSelectContentImage:(void(^)(UIImage *image))image;


/**
 点击提交
 */
- (void)issue_didSelectSubmiteWithModel:(DDQIssueDataModel *)model;

@end

NS_ASSUME_NONNULL_END

