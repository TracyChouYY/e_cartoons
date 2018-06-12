//
//  DDQUserInfoBaseCell.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/24.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQUserInfoBaseCellStyle) {
    
    DDQUserInfoBaseCellStyleUnknown,    //样式未知。默认值
    DDQUserInfoBaseCellStyleNickname,   //输入昵称是一种样式
    DDQUserInfoBaseCellStyleSex,        //性别选择是一种样式
    DDQUserInfoBaseCellStyleChoice,     //其他的都带点击事件
    
};

@class DDQUserInfoBaseCell;

@protocol DDQUserInfoDelegate <NSObject>

@optional

/**
 带点击事件cell的回调

 @param cell 被点击的cell
 */
- (void)userInfo_didSelectChoiceOperationWithCell:(DDQUserInfoBaseCell *)cell;

@end

typedef NS_ENUM(NSUInteger, DDQUserInfoSexType) {
    
    DDQUserInfoSexTypeMan,
    DDQUserInfoSexTypeWoman,
    
};

/**
 个人资料 - 页面多种cell的父类
 */
@interface DDQUserInfoBaseCell : DDQCell

+ (DDQUserInfoBaseCellStyle)userInfoStyle;

@property (nonatomic, readonly, strong) UILabel *info_titleLabel;
@property (nonatomic, strong, readonly) UITextField *info_inputField;
@property (nonatomic, assign, readonly) DDQUserInfoSexType info_sexType;

@property (nonatomic, weak, nullable) id <DDQUserInfoDelegate> delegate;

@end

@interface DDQUserInfoModel : DDQBaseCellModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) DDQUserInfoSexType type;

@end

NS_ASSUME_NONNULL_END

