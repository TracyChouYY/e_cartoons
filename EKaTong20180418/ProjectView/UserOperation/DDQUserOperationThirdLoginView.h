//
//  DDQUserOperationThirdLoginView.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/18.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQView.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, DDQUserOperationThirdLoginType) {
    
    DDQUserOperationThirdLoginTypeQQ,
    DDQUserOperationThirdLoginTypeWX,
    DDQUserOperationThirdLoginTypeAL,
    
};

@protocol DDQUserOperationThirdLoginViewDelegate <NSObject>

@optional
- (void)third_didSelectUserProtocol;
- (void)third_didSelectThirdLoginWithType:(DDQUserOperationThirdLoginType)type;

@end

/**
 用户操作（注册，登录）,显示第三方登录和使用协议
 */
@interface DDQUserOperationThirdLoginView : DDQView

@property (nonatomic, weak, nullable) id <DDQUserOperationThirdLoginViewDelegate> delegate;
@property (nonatomic, assign, readonly) BOOL login_respectProtocol;
@property (nonatomic, assign) BOOL login_installWechat;

@end

NS_ASSUME_NONNULL_END
