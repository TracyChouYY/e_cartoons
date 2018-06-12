//
//  DDQEvaluateStarView.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/2.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQView.h"

NS_ASSUME_NONNULL_BEGIN

/**
 评价的打星星的视图
 */
@interface DDQEvaluateStarView : DDQView

/**
 初始化方法

 @param count 默认是几颗星
 */
- (instancetype)initStarViewWithCount:(NSInteger)count DDQ_DESIGNATED_INITIALIZER;


@end

NS_ASSUME_NONNULL_END

