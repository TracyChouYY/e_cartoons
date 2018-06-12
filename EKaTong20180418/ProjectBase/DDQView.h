//
//  DDQView.h
//
//  Copyright © 2018年 WICEP. All rights reserved.


#import <DDQProjectFoundation/DDQFoundationHeader.h>

#import "UIView+DDQAdditionalContent.h"

#import "DDQButton.h"

NS_ASSUME_NONNULL_BEGIN

/**
 工程自定义视图基类
 */
@interface DDQView : DDQBaseView

/**
 默认的水平边距
 */
@property (nonatomic, assign, readonly) DDQViewVHMargin view_defaultControlMargin;

/**
 默认的控件间距
 */
@property (nonatomic, assign, readonly) DDQViewVHSpace view_defaultControlSpace;

/**
 显示的协议文字
 */
@property (nonatomic, readonly) NSString *view_protocolText;


@end

NS_ASSUME_NONNULL_END
