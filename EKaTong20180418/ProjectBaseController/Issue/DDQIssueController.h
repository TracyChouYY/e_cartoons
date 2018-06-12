//
//  DDQIssueController.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/3.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^DDQIssueDidSelectBase)(void);
typedef void(^DDQIssueDidSelectActivity)(void);

/**
 e卡通 - 基地（基地和活动）发布
 */
@interface DDQIssueController : DDQBaseViewController

- (void)issue_didSelectBase:(DDQIssueDidSelectBase)base;

- (void)issue_didSelectActivity:(DDQIssueDidSelectActivity)activity;

@end

NS_ASSUME_NONNULL_END

