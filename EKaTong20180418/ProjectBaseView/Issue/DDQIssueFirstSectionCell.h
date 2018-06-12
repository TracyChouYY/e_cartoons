//
//  DDQIssueFirstSectionCell.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/3.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQIssueFirstSectionCellStyle) {
    
    DDQIssueFirstSectionCellStyleBase,          //发布基地
    DDQIssueFirstSectionCellStyleActivity,      //发布活动
    
};
@protocol DDQIssueFirstSectionCellDelegate;

/**
 发布 - 分区一的cell，显示输入的内容和选择的图片
 */
@interface DDQIssueFirstSectionCell : DDQCell

- (void)first_updateCellStyle:(DDQIssueFirstSectionCellStyle)style;

@property (nonatomic, weak, nullable) id <DDQIssueFirstSectionCellDelegate> delegate;

/**
 当前位置
 */
@property (nonatomic, copy) NSString *first_position;

/**
 选择的图片
 */
- (void)first_replaceImage:(UIImage *)image index:(NSInteger)index;

/**
 对应索引上发生过改变的图片
 */
@property (nonatomic, readonly) NSArray *first_changeImages;
@property (nonatomic, readonly) NSString *first_title;
@property (nonatomic, readonly) NSString *first_content1;
@property (nonatomic, readonly) NSString *first_content2;

@end

@class DDQIssueFirstImageModel;

@interface DDQIssueFirstSectionModel : DDQBaseCellModel

@property (nonatomic, copy) NSArray<DDQIssueFirstImageModel *> *images;

/**
 发布基地分区一的字段
 */
@property (nonatomic, copy) NSString *base_name;
@property (nonatomic, copy) NSString *base_scenic;
@property (nonatomic, copy) NSString *base_notice;
@property (nonatomic, copy) NSString *base_address;

/**
 发布活动分区一的字段
 */
@property (nonatomic, copy) NSString *activity_address;

/**
 活动介绍
 */
@property (nonatomic, copy) NSString *activity_describe;

/**
 费用描述
 */
@property (nonatomic, copy) NSString *activity_description;
@property (nonatomic, copy) NSString *activity_name;


@end

@interface DDQIssueFirstImageModel : DDQFoundationModel

@property (nonatomic, copy) NSString *image_url;
@property (nonatomic, copy) NSString *image_num;

@end

@protocol DDQIssueFirstSectionCellDelegate <NSObject>

@optional

/**
 点击选择活动或基地地址
 */
- (void)first_didSelectLocationWithCell:(DDQIssueFirstSectionCell *)cell;


/**
 点击上传图片

 @param cell 点击的cell
 @param sIndexPath 被点击item的索引
 @param dIndexPath 上一次点击item的索引
 */
- (void)first_didSelectPickerImageWithCell:(DDQIssueFirstSectionCell *)cell selectIndexPath:(NSIndexPath *)sIndexPath deselectIndexPath:(nullable NSIndexPath *)dIndexPath defaultImage:(BOOL)isDefault;

/**
 取消索引对应的图片
 */
- (void)first_didSelectCloseImageWithIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END

