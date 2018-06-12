//
//  DDQSearchNavigationBar.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/4.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^DDQSearchNavigationBarEndEditing)(NSString *text);
/**
 搜索页的NavigationItem
 */
@interface DDQSearchNavigationBar : DDQView

- (void)search_becomeFirstResponder;

- (void)search_responseWhenEndEditing:(DDQSearchNavigationBarEndEditing)end;

@end

NS_ASSUME_NONNULL_END

