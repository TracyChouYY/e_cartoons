//
//  UIView+DDQAdditionalContent.h
//
//  Copyright © 2018年 WICEP. All rights reserved.

#import <UIKit/UIKit.h>
#import <DDQProjectFoundation/DDQAutoLayout.h>

#import "DDQButton.h"

#define DDQException(condition, name, ...)\
if (__builtin_expect((condition), 0)) {\
[NSException raise:name format:__VA_ARGS__];\
}

#define DDQFont(size) [UIFont systemFontOfSize:size]

NS_ASSUME_NONNULL_BEGIN

/**
 工程自定义视图扩展的api
 */
@interface UIView (DDQAdditionalContent)

@property (nonatomic, readonly) DDQAutoLayout *auto_layout;

/**
 分割线的颜色
 */
- (UIColor *)defaultSeparatorColor;

/**
 工程里用的比较多的灰色
 */
- (UIColor *)defaultGrayColor;

/**
 工程里用的比较多的橙色
 */
- (UIColor *)defaultOrangeColor;

/**
 工程里用的比较多的蓝色
 */
- (UIColor *)defaultBlueColor;

/**
 工程里cell上文字的颜色
 */
- (UIColor *)defaultCellTextColor;

/**
 工程视图的背景颜色
 */
- (UIColor *)defaultViewBackgroundColor;

/**
 工程里用的比较多的黑色
 */
- (UIColor *)defaultBlackColor;

/**
 默认的输入框字体大小
 */
- (UIFont *)defaultFieldFont;

/**
 和密码相关页（支付密码、修改密码等）按钮的背景色
 */
- (UIColor *)default_password_buttonBackgroundColor;

/**
 和密码相关页（支付密码、修改密码等）按钮的文字颜色
 */
- (UIColor *)default_password_buttonTitleColor;

/**
 默认的按钮字体大小
 */
- (UIFont *)defaultButtonFont;

/**
 设置带属性的字符串

 @param string 字符串
 @param font 字符串的字体大小
 @param color 字符串的文字颜色
 */
- (NSAttributedString *)setAttributeStringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color;

/**
 初始化一个我自定的按钮

 @param style 按钮样式
 @param fSize 字体大小
 @param title 按钮标题
 @param image 按钮图片
 @param tColor 字体颜色
 @param target 触发器
 @param sel 方法
 */
+ (DDQButton *)ddq_customButtonWithStyle:(DDQButtonStyle)style fontSize:(CGFloat)fSize title:(nullable NSString *)title image:(nullable UIImage *)image titleColor:(nullable UIColor *)tColor target:(nullable id)target selector:(nullable SEL)sel;

@end

NS_ASSUME_NONNULL_END
