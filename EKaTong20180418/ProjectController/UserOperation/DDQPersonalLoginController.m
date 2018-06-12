//
//  DDQPersonalLoginController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/18.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQPersonalLoginController.h"

#import "DDQForgetController.h"
#import "DDQRegisterController.h"
#import "DDQBaseLoginController.h"
#import "DDQBindPhoneController.h"
#import "DDQUserProtocolController.h"
#import "DDQManagerLoginController.h"

#import "DDQLoginView.h"

#import <WXApi.h>
#import <UMSocialCore/UMSocialCore.h>

#import "DDQALLoginTool.h"

#import "DDQBaseViewController+DDQLoginControllerHandler.h"

@interface DDQPersonalLoginController () <DDQUserOperationDelegate>

@property (nonatomic, strong) DDQLoginView *loginView;
@property (nonatomic, strong) dispatch_group_t login_thirdGroup;
@property (nonatomic, strong) dispatch_queue_t login_thirdQueue;

@end

@implementation DDQPersonalLoginController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //Subview
    self.loginView = [[DDQLoginView alloc] initViewWithFrame:CGRectZero];
    [self.view addSubview:self.loginView];
    self.loginView.delegate = self;
    self.loginView.login_installWX = [WXApi isWXAppInstalled];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.login_thirdGroup = dispatch_group_create();
    self.login_thirdQueue = dispatch_queue_create("com.wkt.thirdLoign", DISPATCH_QUEUE_SERIAL);
    
}

- (NSString *)base_navigationTitle {
    
    return @"个人登录";
    
}

- (DDQBaseNavigationBarStyle)base_navigationBarStyle {
    
    return DDQBaseNavigationBarStyleWhite;
    
}

#pragma mark - Custom View Delegate
- (void)login_didSelectForgetPassword {
    
    [self base_handleInitializeWithControllerClass:[DDQForgetController class] FromNib:NO title:nil propertys:nil];
    
}

- (void)login_didSelectToRegister {
    
    [self base_handleInitializeWithControllerClass:[DDQRegisterController class] FromNib:NO title:nil propertys:nil];
    
}

- (void)login_didSelectDifferentViewType:(DDQLoginViewType)type loginView:(nonnull DDQLoginView *)view {
    
    [self base_handleDifferentLoginTypeWithClass:[DDQBaseLoginController class]];

}

- (void)login_didSelectLoginWithModel:(DDQUserOperationModel *)model {

    [self handler_handleLoginProcessWithType:DDQLoginHandlerTypePersonal dataModel:model];
    
}

- (void)login_didSelectDifferentThirdLoginType:(DDQLoginThirdType)type {
    
    DDQWeakObject(self);
    UMSocialManager *socialManager = [UMSocialManager defaultManager];
    if (type == DDQLoginThirdTypeQQ) {//QQ登录
        
        [socialManager getUserInfoWithPlatform:UMSocialPlatformType_QQ currentViewController:self completion:^(id result, NSError *error) {
            
            UMSocialUserInfoResponse *infoResponse = result;
            [weakObjc login_handlerThirdLoginWithInforResponse:infoResponse alInfo:nil type:@"3"];
            
        }];
    } else if (type == DDQLoginThirdTypeWX) {//WX登录
        
        [socialManager getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
            
            UMSocialUserInfoResponse *infoResponse = result;
            [weakObjc login_handlerThirdLoginWithInforResponse:infoResponse alInfo:nil type:@"1"];
            
        }];
    } else if (type == DDQLoginThirdTypeAL) {
        
        DDQALLoginTool *loginTool = [[DDQALLoginTool alloc] initALLoginWithParam:@{DDQALLoginInitializeAppID:DDQALAppID, DDQALLoginInitializePartnerID:DDQALPartnerID, DDQALLoginInitializePrivateKey:DDQALPrivateKey}];
        [loginTool al_awakeALAuth2Completed:^(NSError * _Nullable alError, NSDictionary<DDQALLoginUserDataKey,NSString *> * _Nullable alUserInfo) {
            
            [weakObjc login_handlerThirdLoginWithInforResponse:nil alInfo:alUserInfo type:@"2"];
            
        }];
    }
}

- (void)login_didSelectUserProtocol {
    
    [self base_handleInitializeWithControllerClass:[DDQUserProtocolController class] FromNib:NO title:nil propertys:nil];
    
}

/**
 处理第三方登录的流程。

 @param response 友盟的返回值
 @param type 第三方登录的类型。1微信，2微信，3QQ
 */
- (void)login_handlerThirdLoginWithInforResponse:(nullable UMSocialUserInfoResponse *)response alInfo:(nullable NSDictionary *)info type:(NSString *)type {
    
    MBProgressHUD *waitHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    waitHud.label.text = @"用户信息获取中。。。";
    
    __block NSData *imageData = nil;
    dispatch_group_async(self.login_thirdGroup, self.login_thirdQueue, ^{
        
        NSString *imageUrl = ([type isEqualToString:@"2"]) ? info[DDQALLoginUserDataAvatar] : response.iconurl;
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imageUrl] options:SDWebImageDownloaderHighPriority progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            
            if (finished) {
                
                imageData = data;
                
            }
            dispatch_group_leave(self.login_thirdGroup);
            
        }];
    });
    dispatch_group_enter(self.login_thirdGroup);
    
    dispatch_group_notify(self.login_thirdGroup, self.login_thirdQueue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (!imageData) {
                
                [waitHud hideAnimated:YES];
                [self alertHUDWithText:@"用户信息获取失败" Delegate:nil];return;
                
            }
            
            NSString *sex = @"";
            if ([type isEqualToString:@"2"]) {
                
                sex = [info[DDQALLoginUserDataSex] isEqualToString:@"m"] ? @"1" : @"2";
                
            } else {
            
                sex = [response.gender isEqualToString:@"男"] ? @"1" : @"2";
            
            }
            
            NSString *requestUrl = [self.base_url stringByAppendingString:@"UserApi/third_party"];
            
            NSString *openId = ([type isEqualToString:@"2"]) ? info[DDQALLoginUserDataUserID] : response.uid;
            NSString *nickname = ([type isEqualToString:@"2"]) ? info[DDQALLoginUserDataNickname] : response.name;
            
            NSDictionary *baseParam = @{@"status":type, @"openid":openId, @"nickname":nickname, @"sex":sex, @"pic":[imageData base64EncodedStringWithOptions:0]};
            NSMutableDictionary *requestParam = [NSMutableDictionary dictionaryWithDictionary:baseParam];
            if ([type isEqualToString:@"3"]) {
                
                [requestParam removeObjectForKey:@"openid"];
                [requestParam setObject:openId forKey:@"qqid"];
                
            } else if ([type isEqualToString:@"2"]) {
                
                [requestParam removeObjectForKey:@"openid"];
                [requestParam setObject:openId forKey:@"zfb_id"];
                
            }
            
            //隐藏等待框
            [waitHud hideAnimated:YES];
            
            __block NSString *bind = @"";
            __block NSString *uid = @"";
            DDQWeakObject(self);
            [self foundation_processNetPOSTRequestWithUrl:requestUrl Param:requestParam WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
                
                if (code == 1) {
                    
                    bind = [weakObjc base_handleRequestStringIfIllegal:response[@"bd"]];
                    uid = [weakObjc base_handleRequestStringIfIllegal:response[@"uid"]];
                    if (bind.intValue == 1) {
                        
                        [weakObjc base_handleUserInfomationWithData:response];
                    
                    }
                }
                return YES;
                
            } AfterAlert:^(int code) {
               
                if (code == 1) {
                    
                    if (bind.intValue == 1 && code == 1) {
                        
                        [DDQNotificationCenter postNotificationName:DDQLoginSuccessNotification object:nil];
                        
                    } else {
                        
                        DDQBindPhoneController *bindC = [weakObjc base_handleInitializeWithControllerClass:[DDQBindPhoneController class] FromNib:NO title:nil propertys:nil];
                        bindC.bind_type = type;
                        bindC.bind_uid = uid;
                        
                    }
                }
            }];
        });
    });
}

@end
