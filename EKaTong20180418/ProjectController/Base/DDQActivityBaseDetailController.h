//
//  DDQActivityBaseDetailController.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/13.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBaseWebPageController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQActivityBaseDetailType) {

    DDQActivityBaseDetailTypeBase = 1,          //显示基地详情
    DDQActivityBaseDetailTypeActivity,      //显示活动详情
    
};

/**
 e卡通 - 活动和基地详情
 */
@interface DDQActivityBaseDetailController : DDQBaseWebPageController

/**
 基地ID
 */
@property (nonatomic, copy) NSString *detail_abID;

/**
 更新控制器显示的web内容
 */
- (void)detail_updateControllerType:(DDQActivityBaseDetailType)type;//default DDQActivityBaseDetailTypeBase

@end

NS_ASSUME_NONNULL_END

