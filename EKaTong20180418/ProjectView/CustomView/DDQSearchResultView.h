//
//  DDQSearchResultView.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/6.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQView.h"

NS_ASSUME_NONNULL_BEGIN

/**
 搜索页 - 显示搜索结果
 */
@interface DDQSearchResultView : DDQView

- (instancetype)initResultViewWithData:(nullable NSArray<NSString *> *)data DDQ_DESIGNATED_INITIALIZER;

/**
 显示搜索过的词
 */
@property (nonatomic, copy) NSArray<NSString *> *result_dataSource;

@end

NS_ASSUME_NONNULL_END

