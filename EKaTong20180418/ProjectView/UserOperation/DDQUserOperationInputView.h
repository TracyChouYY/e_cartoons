//
//  DDQUserOperationInputView.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/18.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQUserOperationInputViewStyle) {
    
    DDQUserOperationInputViewStyleNormal,           //普通样式
    DDQUserOperationInputViewStyleMessageCode,      //发送验证码样式
    DDQUserOperationInputViewStylePassword,         //密码
    DDQUserOperationInputViewStylePhone,            //手机号
};

typedef void(^DDQInputViewSendMessageCodeBlock)(BOOL send);
@protocol DDQUserOperationInputViewDelegate <NSObject>

@optional
- (void)input_didSelectSendMessageCode:(DDQInputViewSendMessageCodeBlock)block;

@end

/**
 用户操作（比如：登录、注册、忘记密码等）时输入框的样式
 */
@interface DDQUserOperationInputView : DDQView

- (instancetype)initInputViewWithStyle:(DDQUserOperationInputViewStyle)style placeholder:(nullable NSString *)placeholder DDQ_DESIGNATED_INITIALIZER;

@property (nonatomic, weak, nullable) id <DDQUserOperationInputViewDelegate> delegate;

@property (nonatomic, strong, readonly) UITextField *input_field;

@property (nonatomic, assign) CGFloat input_estimateHeight;//default 45.0

@end

NS_ASSUME_NONNULL_END
