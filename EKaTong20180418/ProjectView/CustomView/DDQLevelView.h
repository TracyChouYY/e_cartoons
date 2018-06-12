//
//  DDQLevelView.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/26.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQLevelViewStyle) {
    
    DDQLevelViewStyleNormal,        //普通
    DDQLevelViewStyleIron,          //铁
    DDQLevelViewStyleSilver,        //银
    DDQLevelViewStyleGold,          //金
    
};

/**
 显示用户等级的view
 */
@interface DDQLevelView : DDQView

- (instancetype)initLevelViewWithStyle:(DDQLevelViewStyle)style DDQ_DESIGNATED_INITIALIZER;

- (void)level_updateViewWithStyle:(DDQLevelViewStyle)style;

@end

NS_ASSUME_NONNULL_END

