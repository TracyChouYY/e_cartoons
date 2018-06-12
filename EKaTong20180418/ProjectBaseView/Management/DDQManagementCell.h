//
//  DDQManagementCell.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/4.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQCell.h"

NS_ASSUME_NONNULL_BEGIN
@protocol DDQManagementCellDelegate;
/**
 管理页 - cell的布局,包括基地和活动
 */
@interface DDQManagementCell : DDQCell

@property (nonatomic, weak, nullable) id <DDQManagementCellDelegate> delegate;

@end

@interface DDQManagementModel : DDQBaseCellModel

@property (nonatomic, copy) NSString *base_address;
@property (nonatomic, copy) NSString *base_end;
@property (nonatomic, copy) NSString *base_id;
@property (nonatomic, copy) NSString *base_image;
@property (nonatomic, copy) NSString *base_name;
@property (nonatomic, copy) NSString *base_notice;
@property (nonatomic, copy) NSString *base_park;
@property (nonatomic, copy) NSString *base_price;
@property (nonatomic, copy) NSString *base_recommend;
@property (nonatomic, copy) NSString *base_scenic;
@property (nonatomic, copy) NSString *base_start;
@property (nonatomic, copy) NSString *base_state;
@property (nonatomic, copy) NSString *base_type;

@end

@interface DDQActivityModel : DDQBaseCellModel

@property (nonatomic, copy) NSString *activity_address;
@property (nonatomic, copy) NSString *activity_describe;
@property (nonatomic, copy) NSString *activity_description;
@property (nonatomic, copy) NSString *activity_destination;
@property (nonatomic, copy) NSString *activity_end;
@property (nonatomic, copy) NSString *activity_id;
@property (nonatomic, copy) NSString *activity_image;
@property (nonatomic, copy) NSString *activity_name;
@property (nonatomic, copy) NSString *activity_number;
@property (nonatomic, copy) NSString *activity_price;
@property (nonatomic, copy) NSString *activity_resort;
@property (nonatomic, copy) NSString *activity_start;
@property (nonatomic, copy) NSString *activity_state;

@end

@protocol DDQManagementCellDelegate <NSObject>

@optional
- (void)management_didSelectEditWithModel:(__kindof DDQBaseCellModel *)model;

@end


NS_ASSUME_NONNULL_END

