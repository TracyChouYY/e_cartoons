//
//  DDQActivityBaseDetailController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/13.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQActivityBaseDetailController.h"

#import "DDQSettleController.h"
#import "DDQShopCarController.h"
#import "DDQDetailShareController.h"

#import <UMSocialCore/UMSocialCore.h>

@interface DDQActivityBaseDetailController ()

@property (nonatomic, assign) BOOL detail_isCollection;
@property (nonatomic, strong) UIButton *detail_collectionButton;
@property (nonatomic, assign) DDQActivityBaseDetailType detail_type;

@end

@implementation DDQActivityBaseDetailController

- (instancetype)init {
    
    self = [super init];
    
    self.detail_type = DDQActivityBaseDetailTypeBase;
    
    return self;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //WePage
    NSString *differentType = (self.detail_type == DDQActivityBaseDetailTypeBase) ? @"Base/detail" : @"Activity/detail";
    self.web_requestUrl = [self.base_url stringByAppendingFormat:@"%@/%@", differentType, self.detail_abID];
    
    DDQWeakObject(self);
    //加入购物车
    [self.web_jsBridge registerHandler:@"js-Objadd" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        //这个不用判断当前是什么类型。因为活动不能加入购物车
        NSString *requestUrl = [weakObjc.base_url stringByAppendingString:@"UserApi/addshop"];
        [weakObjc foundation_processNetPOSTRequestWithUrl:requestUrl Param:@{@"uid":weakObjc.base_userID, @"bid":[weakObjc base_handleFindURLDataWithKey:@"bid" url:data[weakObjc.web_dataKey]]} WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
            
            return YES;
            
        }];
    }];
    
    //立即购买
    [self.web_jsBridge registerHandler:@"js-Objljgm" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        DDQSettleController *settleC = [weakObjc base_handleInitializeWithControllerClass:[DDQSettleController class] FromNib:NO title:nil propertys:nil];
        settleC.settle_type = (weakObjc.detail_type == DDQActivityBaseDetailTypeBase) ? DDQSettleTypeBase : DDQSettleTypeActivity;
        settleC.settle_way = DDQSettleWayPurchase;
        settleC.settle_url = data[weakObjc.web_dataKey];
        
    }];
    
    //查看购物车
    [self.web_jsBridge registerHandler:@"js-Objgwc" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        [weakObjc base_handleInitializeWithControllerClass:[DDQShopCarController class] FromNib:NO title:nil propertys:nil];
        
    }];
    
    [self foundation_setRightItemWithStyle:DDQFoundationBarButtonImage Content:kSetImage(@"detail_collection") Selector:@selector(detail_didSelectCollectionWithButton:)];
    self.detail_collectionButton = [self.navigationItem.rightBarButtonItem customView];
    [self foundation_setRightItemWithStyle:DDQFoundationBarButtonImage Content:kSetImage(@"detail_share") Selector:@selector(detail_didSelectShare)];
    
    //NetRequest
    [self detail_netRequestWithCollectionStatus];
    

}

- (DDQBaseNavigationBarStyle)base_navigationBarStyle {
    
    return DDQBaseNavigationBarStyleClearAndWhitBack;
    
}

/**
 点击收藏
 */
- (void)detail_didSelectCollectionWithButton:(UIButton *)button {
    
    DDQWeakObject(self);
    if (!self.detail_isCollection) {
        
        NSString *requestUrl = [self.base_url stringByAppendingString:@"UserApi/collect"];
        [self foundation_processNetPOSTRequestWithUrl:requestUrl Param:@{@"uid":self.base_userID, @"bid":[self base_handleFindURLDataWithKey:@"id" url:self.detail_abID]} WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
            
            return YES;
            
        } AfterAlert:^(int code) {
            
            if (code == 1) {
                
                [button setImage:kSetImage(@"detail_isCollection") forState:UIControlStateNormal];
                weakObjc.detail_isCollection = YES;
                
            }
        }];
    } else {
        
        NSString *requestUrl = [self.base_url stringByAppendingString:@"UserApi/cdel"];
        [self foundation_processNetPOSTRequestWithUrl:requestUrl Param:@{@"uid":self.base_userID, @"bid":[self base_handleFindURLDataWithKey:@"id" url:self.detail_abID]} WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
            
            return YES;
            
        } AfterAlert:^(int code) {
            
            if (code == 1) {
                
                [button setImage:kSetImage(@"detail_collection") forState:UIControlStateNormal];
                weakObjc.detail_isCollection = NO;
                
            }
        }];
    }
}

/**
 点击分享
 */
- (void)detail_didSelectShare {
    
    DDQDetailShareController *shareC = [[DDQDetailShareController alloc] init];
    [self presentViewController:shareC animated:YES completion:nil];
    DDQWeakObject(self);
    [shareC share_didSelectShareType:^(DDQDetailShareType type) {
        
        UMShareWebpageObject *webObject = [UMShareWebpageObject shareObjectWithTitle:self.navigationItem.title descr:nil thumImage:nil];
        webObject.webpageUrl = weakObjc.web_requestUrl;
        
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObjectWithMediaObject:webObject];
        
        UMSocialPlatformType platformType = (type == DDQDetailShareTypeWX) ? UMSocialPlatformType_WechatSession : UMSocialPlatformType_WechatTimeLine;
        
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id result, NSError *error) {
            
            if (error) {
                
                if (error.code == UMSocialPlatformErrorType_Cancel) {
                    
                    [weakObjc alertHUDWithText:@"分享取消" Delegate:nil];return;
                    
                } else {
                    
                    [weakObjc alertHUDWithText:@"分享失败" Delegate:nil];return;
                    
                }
            } else {
                
                [weakObjc alertHUDWithText:@"分享成功" Delegate:nil];
                
            }
        }];
    }];
}

/**
 请求当前基地是否收藏
 */
- (void)detail_netRequestWithCollectionStatus {
    
    DDQWeakObject(self);
    NSString *requestUrl = [self.base_url stringByAppendingString:@"UserApi/yhsc"];
    NSString *contentKey = self.detail_type == DDQActivityBaseDetailTypeBase ? @"bid" : @"aid";
    [self foundation_processNetPOSTRequestWithUrl:requestUrl Param:@{@"uid":self.base_userID, contentKey:[self base_handleFindURLDataWithKey:@"id" url:self.detail_abID]} WaitHud:nil ShowHud:NO WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
        
        if (code == 1) {
            
            //Cs为2表示未收藏
            NSString *status = [weakObjc base_handleRequestStringIfIllegal:response[@"cs"]];
            weakObjc.detail_isCollection = (status.intValue == 1) ? YES : NO;
            
            UIImage *image = (weakObjc.detail_isCollection) ? kSetImage(@"detail_isCollection") : kSetImage(@"detail_collection");
            [weakObjc.detail_collectionButton setImage:image forState:UIControlStateNormal];
            
        }
        return NO;
        
    } AfterAlert:nil];
}

- (void)detail_updateControllerType:(DDQActivityBaseDetailType)type {
    
    self.detail_type = type;
    
}

@end
