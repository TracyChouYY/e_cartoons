//
//  DDQBaseIssueController.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/3.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

/**
 e卡通 - 基地发布
 基地只会有一个所以不用那么麻烦
 */
@interface DDQBaseIssueController : DDQBaseViewController

/**
 基地的id。默认为informationmanage的bid
 */
@property (nonatomic, copy) NSString *base_id;

@end

NS_ASSUME_NONNULL_END

