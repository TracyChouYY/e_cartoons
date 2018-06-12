//
//  DDQForgetView.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/19.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQView.h"

#import "DDQUserOperationDelegate.h"

NS_ASSUME_NONNULL_BEGIN

/**
 找回密码 - 页面布局
 */
@interface DDQForgetView : DDQView

@property (nonatomic, weak, nullable) id <DDQUserOperationDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

