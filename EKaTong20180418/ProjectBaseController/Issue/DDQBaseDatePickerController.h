//
//  DDQBaseDatePickerController.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/10.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^DDQDatePickerChoiceCompleted)(NSDate *dateTime);
/**
 e卡通 - 发布时间选择器
 */
@interface DDQBaseDatePickerController : DDQBaseViewController

/**
 选择完时间了

 @param completed 选择时间的回调
 */
- (void)dataPicker_didChoiceTimeCompleted:(DDQDatePickerChoiceCompleted)completed;

@end

NS_ASSUME_NONNULL_END
