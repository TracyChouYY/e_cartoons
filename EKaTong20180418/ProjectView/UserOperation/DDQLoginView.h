//
//  DDQLoginView.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/18.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQView.h"

#import "DDQUserOperationDelegate.h"

NS_ASSUME_NONNULL_BEGIN

/**
 登录 - 视图布局
 */
@interface DDQLoginView : DDQView

- (instancetype)initLoginViewWithType:(DDQLoginViewType)type DDQ_DESIGNATED_INITIALIZER;

@property (nonatomic, assign, readonly) DDQLoginViewType login_viewType;

@property (nonatomic, weak, nullable) id <DDQUserOperationDelegate> delegate;

@property (nonatomic, assign) BOOL login_installWX;

@end

NS_ASSUME_NONNULL_END

