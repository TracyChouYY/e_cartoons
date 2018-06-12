//
//  DDQActivityIssueController.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/3.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQActivityIssueType) {
    
    DDQActivityIssueTypeIssue,      //发布活动
    DDQActivityIssueTypeEdit,       //编辑活动
    
};
/**
 e卡通 - 活动发布
 */
@interface DDQActivityIssueController : DDQBaseViewController

@property (nonatomic, assign) DDQActivityIssueType issue_type;
@property (nonatomic, copy) NSString *issue_activityID;

@end

NS_ASSUME_NONNULL_END

