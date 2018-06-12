//
//  DDQBaseViewController+DDQLoginControllerHandler.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/8.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQLoginHandlerType) {
    
    DDQLoginHandlerTypePersonal,
    DDQLoginHandlerTypeBase,
    DDQLoginHandlerTypeManager,
    
};
@class DDQUserOperationModel;
/**
 集中处理登录的流程
 */
@interface DDQBaseViewController (DDQLoginControllerHandler)

- (void)handler_handleLoginProcessWithType:(DDQLoginHandlerType)type dataModel:(DDQUserOperationModel *)model;

@end

NS_ASSUME_NONNULL_END

