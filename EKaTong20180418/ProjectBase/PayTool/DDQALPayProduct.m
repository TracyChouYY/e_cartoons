//
//  DDQALPayProduct.m
//  WeiDuoShiGuang20171106
//
//  Created by 我叫咚咚枪 on 2017/12/30.
//  Copyright © 2017年 我叫咚咚枪. All rights reserved.
//

#import "DDQALPayProduct.h"

@implementation DDQALPayProduct

- (NSString *)description {
    
    NSMutableDictionary *productDic = [NSMutableDictionary dictionary];
    [productDic addEntriesFromDictionary:@{@"subject":_product_subject?:@"",
                                           @"out_trade_no":_product_tradeNo?:@"",
                                           @"total_amount":_product_totalAmount?:@"",
                                           @"seller_id":_product_sellerID?:@"",
                                           @"product_code":_product_code?:@"QUICK_MSECURITY_PAY"}];
    
    if (_product_timeout.length > 0) {
        [productDic setValue:_product_timeout forKey:@"timeout_express"];
    }
    
    if (_product_body.length > 0) {
        [productDic setValue:_product_body forKey:@"body"];
    }
    
    NSData *productData = [NSJSONSerialization dataWithJSONObject:productDic options:0 error:nil];
    return [[NSString alloc] initWithData:productData encoding:NSUTF8StringEncoding];
}

@end

@implementation DDQALPayAuthority

- (NSString *)al_orderInfoEncode:(BOOL)encode {
    
    //appid不能为空
    if (self.al_appID <= 0) return nil;
    
    //支付的一些权限
    NSMutableDictionary *authorityDic = [NSMutableDictionary dictionary];
    [authorityDic addEntriesFromDictionary:@{@"app_id":_al_appID,
                                             @"method":_al_method ? :@"alipay.trade.app.pay",
                                             @"charset":_al_charset ? :@"utf-8",
                                             @"timestamp":_al_timestamp ? :@"",
                                             @"version":_al_version ? :@"1.0",
                                             @"biz_content":_al_product.description ? :@"",
                                             @"sign_type":_al_signType ? :@"RSA"}];
    
    if (_al_notifyUrl.length > 0) {
        [authorityDic setObject:_al_notifyUrl forKey:@"notify_url"];
    }
    
    // NOTE: 排序，得出最终请求字串
    NSArray* sortedKeyArray = [[authorityDic allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSMutableArray *tmpArray = [NSMutableArray array];
    for (NSString* key in sortedKeyArray) {
        NSString* orderItem = [self orderItemWithKey:key andValue:[authorityDic objectForKey:key] encoded:encode];
        if (orderItem.length > 0) {
            [tmpArray addObject:orderItem];
        }
    }
    return [tmpArray componentsJoinedByString:@"&"];
}

- (NSString*)orderItemWithKey:(NSString*)key andValue:(NSString*)value encoded:(BOOL)bEncoded {
    
    if (key.length > 0 && value.length > 0) {
        if (bEncoded) {
            value = [self encodeValue:value];
        }
        return [NSString stringWithFormat:@"%@=%@", key, value];
    }
    return nil;
}

- (NSString*)encodeValue:(NSString*)value {
    
    NSString* encodedValue = value;
    if (value.length > 0) {
        encodedValue = (__bridge_transfer  NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)value, NULL, (__bridge CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
    }
    return encodedValue;
}

@end

