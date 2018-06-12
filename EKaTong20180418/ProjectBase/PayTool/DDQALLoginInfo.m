//
//  DDQALLoginInfo.m
//  WeiDuoShiGuang20171106
//
//  Created by 我叫咚咚枪 on 2018/1/3.
//  Copyright © 2018年 我叫咚咚枪. All rights reserved.
//

#import "DDQALLoginInfo.h"

@implementation DDQALLoginInfo

- (NSString *)description {
    
    if (self.appID.length != 16||self.pid.length != 16) {
        return nil;
    }
    
    // NOTE: 增加不变部分数据
    NSMutableDictionary *tmpDict = [NSMutableDictionary dictionary];
    [tmpDict addEntriesFromDictionary:@{@"app_id":_appID,
                                        @"pid":_pid,
                                        @"apiname":@"com.alipay.account.auth",
                                        @"method":@"alipay.open.auth.sdk.code.get",
                                        @"app_name":@"mc",
                                        @"biz_type":@"openservice",
                                        @"product_id":@"APP_FAST_LOGIN",
                                        @"scope":@"kuaijie",
                                        @"target_id":(_targetID?:[self info_createTargetID]),
                                        @"auth_type":(_authType?:@"AUTHACCOUNT")}];
    
    // NOTE: 排序，得出最终请求字串
    NSArray* sortedKeyArray = [[tmpDict allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        return [obj1 compare:obj2];
    }];
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    for (NSString* key in sortedKeyArray) {
        
        NSString* orderItem = [self itemWithKey:key andValue:[tmpDict objectForKey:key]];
        if (orderItem.length > 0) {
            
            [tmpArray addObject:orderItem];
        }
    }
    return [tmpArray componentsJoinedByString:@"&"];
}

- (NSString*)itemWithKey:(NSString*)key andValue:(NSString*)value {
    
    if (key.length > 0 && value.length > 0) {
        
        return [NSString stringWithFormat:@"%@=%@", key, value];
    }
    return nil;
}

/** 随机生成TargetID */
- (NSString *)info_createTargetID {
    
    NSString *rand = @(arc4random()%100000 + 1).stringValue;
    return rand;
}

@end
