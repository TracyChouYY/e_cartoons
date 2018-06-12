//
//  DDQDetailShareController.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/12.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQDetailShareType) {
    
    DDQDetailShareTypeWX,
    DDQDetailShareTypeFirend,
    
};

typedef void(^DDQSelectShareType)(DDQDetailShareType type);
/**
 e卡通 - 分享
 */
@interface DDQDetailShareController : DDQBaseViewController

- (void)share_didSelectShareType:(DDQSelectShareType)type;

@end

typedef void(^DDQSelectDetailShareView)(void);

@interface DDQDetailShareView : DDQBaseView

- (instancetype)initShareViewWithType:(DDQDetailShareType)type;

- (void)detail_didSelectShareView:(DDQSelectDetailShareView)share;

@end

NS_ASSUME_NONNULL_END

