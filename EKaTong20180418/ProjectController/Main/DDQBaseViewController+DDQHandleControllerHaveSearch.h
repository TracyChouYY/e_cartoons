//
//  DDQBaseViewController+DDQHandleControllerHaveSearch.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/8.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQSearchContentType) {
    
    DDQSearchContentTypeActivity,
    DDQSearchContentTypeBase,
};

/**
 处理带搜索功能的控制器，头部Navigation Title的显示
 */
@interface DDQBaseViewController (DDQHandleControllerHaveSearch)

/**
 显示不同的NavigationItem

 @param type 显示的内容
 */
- (void)handle_navigationTitleSearchButtonwWithType:(DDQSearchContentType)type;

/**
 设置一个SearchBar
 */
- (void)handle_navigationTitleWithSearchViewDelegate:(id<DDQSearchBarDelegate>)delegate rightItemSelector:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
