//
//  DDQBaseSortController.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/11.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSString *DDQBaseSortDataKey;

typedef void(^DDQSelectBaseSort)(NSDictionary<DDQBaseSortDataKey, NSString *> *data);

/**
 e卡通 - 基地类目
 */
@interface DDQBaseSortController : DDQBaseViewController

- (void)sort_didSelectSort:(DDQSelectBaseSort)sort;

@end

UIKIT_EXTERN DDQBaseSortDataKey const DDQBaseSortDataNameKey;
UIKIT_EXTERN DDQBaseSortDataKey const DDQBaseSortDataIdKey;


NS_ASSUME_NONNULL_END

