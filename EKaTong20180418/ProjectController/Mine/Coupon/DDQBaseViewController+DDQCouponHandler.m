//
//  DDQBaseViewController+DDQCouponHandler.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/17.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBaseViewController+DDQCouponHandler.h"

@implementation DDQBaseViewController (DDQCouponHandler)

- (void)handler_requestCouponDataWithType:(NSString *)type completed:(DDQCouponRequestCompleted)completed {
    
    DDQWeakObject(self);
    NSString *requestUrl = [self.base_url stringByAppendingString:@"UserApi/ylist"];
    NSDictionary *requestParam = @{@"uid":self.base_userID, @"type":type};
    [self foundation_processNetPOSTRequestWithUrl:requestUrl Param:requestParam WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
        
        if (code == 1) {
            
            NSArray *listArr = [weakObjc base_handleRequestDataIfLegal:response[@"ylist"] targetClass:[NSArray class]];
            NSMutableArray *data = [NSMutableArray arrayWithCapacity:listArr.count];
            for (NSDictionary *dic in listArr) {
                
                DDQCouponModel *model = [DDQCouponModel mj_objectWithKeyValues:dic];
                model.coupon_image = [weakObjc.base_imageUrl stringByAppendingString:model.coupon_image];
                [data addObject:model];
                
            }
            
            if (completed) {
                
                completed(data.copy);
                
            }
            return NO;
            
        }
        return YES;
        
    }];
}


@end
