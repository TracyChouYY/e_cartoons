//
//  DDQContentInputView.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/3.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQContentInputViewStyle) {
    
    DDQContentInputViewStyleNormal,             //普通样式，左边文字，右边输入框。default value
    DDQContentInputViewStylePlaceholder,        //占位样式，右边会多一个占位的按钮，用以做点击事件。
};
@protocol DDQContentInputViewDelegate;
/**
 用于内容输入的视图布局
 */
@interface DDQContentInputView : DDQView

- (instancetype)initInputViewWithStyle:(DDQContentInputViewStyle)style title:(nullable NSString *)title placeholder:(nullable NSString *)placeholder DDQ_DESIGNATED_INITIALIZER;

@property (nonatomic, assign, readonly) CGFloat input_estimateHeight;

@property (nonatomic, strong, readonly) UILabel *input_titleLabel;
@property (nonatomic, strong, readonly) UITextField *input_textField;
@property (nonatomic, strong, readonly) UIButton *input_placeholderButton;

@property (nonatomic, weak, nullable) id <DDQContentInputViewDelegate> delegate;

@end

@protocol DDQContentInputViewDelegate <NSObject>

@optional

/**
 点击了占位的按钮，用来显示相关的流程
 */
- (void)content_didSelectPlaceholderWithView:(DDQContentInputView *)view;

@end

NS_ASSUME_NONNULL_END

