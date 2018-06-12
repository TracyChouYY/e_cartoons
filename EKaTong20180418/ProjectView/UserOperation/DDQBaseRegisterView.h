//
//  DDQBaseRegisterView.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/20.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQView.h"

#import "DDQUserOperationDelegate.h"

NS_ASSUME_NONNULL_BEGIN

/**
 基地注册 - 页面布局
 */
@interface DDQBaseRegisterView : DDQView

@property (nonatomic, weak, nullable) id <DDQUserOperationDelegate> delegate;

@end

typedef NS_ENUM(NSUInteger, DDQRegisterPickerImageViewStyle) {
    
    DDQRegisterPickerImageViewStyleContract,        //拍合同
    DDQRegisterPickerImageViewStyleLicence,         //拍营业执照
    
};
@class DDQRegisterPickerImageView;
@protocol DDQRegisterPickerImageViewDelegate <NSObject>

@optional
- (void)picker_didSelectPickerImage:(void(^)(UIImage *image))picker view:(DDQRegisterPickerImageView *)view;

@end

@interface DDQRegisterPickerImageView : DDQView

- (instancetype)initPickerImageViewWithStyle:(DDQRegisterPickerImageViewStyle)style DDQ_DESIGNATED_INITIALIZER;

@property (nonatomic, weak, nullable) id <DDQRegisterPickerImageViewDelegate> delegate;
/**
 选择的图片
 */
@property (nonatomic, strong) UIImage *picker_image;

@property (nonatomic, assign) CGFloat picker_estimateHeight;

@end

NS_ASSUME_NONNULL_END
