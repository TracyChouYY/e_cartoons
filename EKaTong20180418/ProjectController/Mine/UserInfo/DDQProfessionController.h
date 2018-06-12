//
//  DDQProfessionController.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/25.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^DDQSelectProfession)(NSString *profession);
/**
 e卡通 - 职业列表
 */
@interface DDQProfessionController : DDQBaseViewController

- (void)profession_didSelectProfession:(DDQSelectProfession)pro;

@end

NS_ASSUME_NONNULL_END

