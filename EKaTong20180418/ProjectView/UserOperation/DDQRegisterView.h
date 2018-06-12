//
//  DDQRegisterView.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/18.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQView.h"

#import "DDQUserOperationDelegate.h"

NS_ASSUME_NONNULL_BEGIN

/**
 注册 - 页面布局
 */
@interface DDQRegisterView : DDQView <DDQUserOperationDelegate>

@property (nonatomic, weak, nullable) id <DDQUserOperationDelegate> delegate;

@property (nonatomic, assign) BOOL register_installWX;

@end

NS_ASSUME_NONNULL_END

