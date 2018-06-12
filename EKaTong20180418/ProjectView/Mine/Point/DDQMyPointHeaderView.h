//
//  DDQMyPointHeaderView.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/25.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^DDQMyPointHeaderOperation)(void);

/**
 我的积分 - TableView的HeaderView用来显示积分信息
 */
@interface DDQMyPointHeaderView : DDQView

@property (nonatomic, readonly) CGFloat header_estimateHeight;

- (void)header_didSelectSignIn:(DDQMyPointHeaderOperation)operation;

@end

NS_ASSUME_NONNULL_END

