//
//  DDQBaseViewController+DDQLoginControllerHandler.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/8.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBaseViewController+DDQLoginControllerHandler.h"

#import "DDQUserOperationModel.h"

@implementation DDQBaseViewController (DDQLoginControllerHandler)

- (void)handler_handleLoginProcessWithType:(DDQLoginHandlerType)type dataModel:(nonnull DDQUserOperationModel *)model {
    
    NSError *error = nil;
    [self base_handleInputContentType:DDQBaseHandleInputContentTypeAccount text:model.login_phone showHud:YES error:&error];
    if (error) return;
    
    [self base_handleInputContentType:DDQBaseHandleInputContentTypePassword text:model.login_password showHud:YES error:&error];
    if (error) return;
    
    if (!model.login_respectProtocol) {
        
        [self alertHUDWithText:@"请先阅读用户协议！" Delegate:nil];return;
        
    }
    
    NSString *userState = @"";
    if (type == DDQLoginHandlerTypeBase) {
        
        userState = @"2";
        
    } else if (type == DDQLoginHandlerTypePersonal) {
        
        userState = @"1";
        
    } else if (type == DDQLoginHandlerTypeManager) {
        
        userState = @"3";
        
    }
    NSString *requestUrl = [self.base_url stringByAppendingString:@"UserApi/login"];
    NSDictionary *requestParam = @{@"phone":model.login_phone,
                                   @"password":model.login_password,
                                   @"state":userState
                                   };
    DDQWeakObject(self);
    [self foundation_processNetPOSTRequestWithUrl:requestUrl Param:requestParam WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
        
        if (code == 1) {
            
            [weakObjc base_handleUserInfomationWithData:response];
            
        }
        return YES;
        
    } AfterAlert:^(int code) {
        
        if (code == 1) {
            
            [DDQNotificationCenter postNotificationName:DDQLoginSuccessNotification object:nil];
            
        }
    }];
}

@end
