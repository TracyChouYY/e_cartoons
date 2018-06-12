//
//  DDQButton.h
//
//  Copyright © 2018年 WICEP. All rights reserved.

#import <UIKit/UIKit.h>
#import <DDQProjectFoundation/DDQFoundationDefine.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQButtonStyle) {
    
    DDQButtonStyleLeftImageView = 0,        //图片在左边，那么文字就在右边,下同。is default value
    DDQButtonStyleTopImageView,
    DDQButtonStyleRightImageView,
    DDQButtonStyleBottomImageView,
    
};
/**
 自定义按钮
 */
@interface DDQButton : UIButton

- (instancetype)initButtonWithStyle:(DDQButtonStyle)style DDQ_DESIGNATED_INITIALIZER;

@property (nonatomic, assign) CGFloat control_space;


@end

NS_ASSUME_NONNULL_END

