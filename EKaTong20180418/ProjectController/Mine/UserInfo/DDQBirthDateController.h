//
//  DDQBirthDateController.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/12.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^DDQSelectBirthDate)(NSString *date);

/**
 e卡通 - 出生年月选择
 */
@interface DDQBirthDateController : DDQBaseViewController

- (void)birth_didSelectBirthDate:(DDQSelectBirthDate)date;

@end

NS_ASSUME_NONNULL_END

