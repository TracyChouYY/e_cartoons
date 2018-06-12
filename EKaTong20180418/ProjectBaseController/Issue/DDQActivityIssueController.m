//
//  DDQActivityIssueController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/3.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQActivityIssueController.h"

#import "DDQBaseSortController.h"
#import "DDQParkingCarController.h"
#import "DDQBaseDatePickerController.h"

#import "DDQIssueView.h"

#import "DDQIssueFirstSectionCell.h"
#import "DDQIssueSecondSectionCell.h"

typedef void(^DDQActivityCityPickBlock)(NSString *text);
typedef void(^DDQActivityCityPickImageBlock)(UIImage *pickerImage);

@interface DDQActivityIssueController () <DDQIssueViewDelagte, DDQCityPickerControllerDelegate>

@property (nonatomic, strong) DDQIssueView *activity_issueView;
@property (nonatomic, copy) DDQActivityCityPickBlock activity_cityPick;
@property (nonatomic, copy) DDQActivityCityPickImageBlock activity_cityPickImage;

@end

@implementation DDQActivityIssueController

- (instancetype)init {
    
    self = [super init];
    
    self.issue_type = DDQActivityIssueTypeIssue;
    
    return self;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //Subview
    self.activity_issueView = [[DDQIssueView alloc] initIssueViewWithStyle:DDQIssueViewStlyeActivity];
    [self.view addSubview:self.activity_issueView];
    self.activity_issueView.delegate = self;
    
    self.activity_issueView.issue_dataSource = @[@[[DDQIssueFirstSectionModel mj_objectWithKeyValues:@{}]], @[[DDQIssueSecondSectionModel mj_objectWithKeyValues:@{}]]];

    if (self.issue_type == DDQActivityIssueTypeEdit) {
        
        [self issue_netRequest];
        
    }
}

- (NSString *)base_navigationTitle {
    
    return @"活动发布";
    
}

/**
 集中处理时间的处理流程
 */
- (void)issue_handlerDatePickerCompleted:(void(^)(NSString *timeText))comp endTime:(BOOL)end {
    
    DDQBaseDatePickerController *pickerC = [[DDQBaseDatePickerController alloc] init];
    [self presentViewController:pickerC animated:YES completion:nil];
    [pickerC dataPicker_didChoiceTimeCompleted:^(NSDate * _Nonnull dateTime) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        if (comp) {
            
            comp([formatter stringFromDate:dateTime]);
            
        }
    }];
}

/**
 网络请求
 */
- (void)issue_netRequest {
    
    DDQWeakObject(self);
    NSString *requestUrl = [self.base_url stringByAppendingString:@"UserApi/adetail"];
    [self foundation_processNetPOSTRequestWithUrl:requestUrl Param:@{@"aid":self.issue_activityID} WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
        
        if (code == 1) {
            
            NSDictionary *dic = [weakObjc base_handleRequestDataIfLegal:response[@"alist"] targetClass:[NSDictionary class]];
            NSArray *imageArr = [weakObjc base_handleRequestDataIfLegal:response[@"image"] targetClass:[NSArray class]];
            DDQIssueFirstSectionModel *firstModel = [DDQIssueFirstSectionModel mj_objectWithKeyValues:dic];
            
            NSMutableArray *images = [NSMutableArray arrayWithCapacity:imageArr.count];
            for (NSDictionary *dic in imageArr) {
                
                DDQIssueFirstImageModel *imageModel = [DDQIssueFirstImageModel mj_objectWithKeyValues:dic];
                if (imageModel.image_url.length > 0) {//图片路径不为空
                    
                    imageModel.image_url = [weakObjc.base_imageUrl stringByAppendingString:imageModel.image_url];
                    
                }
                [images addObject:imageModel];
                
            }
            firstModel.images = images.copy;
            
            DDQIssueSecondSectionModel *secondModel = [DDQIssueSecondSectionModel mj_objectWithKeyValues:dic];
            weakObjc.activity_issueView.issue_dataSource = @[@[firstModel], @[secondModel]];
                        
            return NO;
            
        }
        return YES;

    }];
}

#pragma mark - Custom View Delegate
- (void)issue_didSelectPickerStartTime:(void (^)(NSString * _Nonnull))startTime {
    
    [self issue_handlerDatePickerCompleted:^(NSString *timeText) {
        
        startTime(timeText);
        
    } endTime:NO];
}

- (void)issue_didSelectContentImage:(void (^)(UIImage * _Nonnull))image {
    
    [self base_presentImagePickerAlertControllerWithDelegate:self];
    
    self.activity_cityPickImage = ^(UIImage *pickerImage) {
    
        image(pickerImage);
        
    };
}

- (void)issue_didSelectPickerEndTime:(void (^)(NSString * _Nonnull))endTime {
    
    [self issue_handlerDatePickerCompleted:^(NSString *timeText) {
        
        endTime(timeText);
        
    } endTime:YES];
}


- (void)issue_didSelectContentPosition:(void (^)(NSString * _Nonnull))position {
    
    DDQCityPickerController *pickerController = [[DDQCityPickerController alloc] init];
    [self presentViewController:pickerController animated:YES completion:nil];
    pickerController.picker_pickerView.backgroundColor = [UIColor whiteColor];
    pickerController.delegate = self;
    
    self.activity_cityPick = ^(NSString *text) {
        
        position(text);
        
    };
}

- (void)issue_didSelectSubmiteWithModel:(DDQIssueDataModel *)model {
    
    if (model.title.length == 0) {
        
        [self alertHUDWithText:@"请填写活动主题！" Delegate:nil];return;
        
    }
    
    if (model.content1.length == 0) {
        
        [self alertHUDWithText:@"请填写活动介绍！" Delegate:nil];return;
        
    }
    
    if (model.content2.length == 0) {
        
        [self alertHUDWithText:@"请填写费用说明！" Delegate:nil];return;
        
    }
    
    if (model.changeImages.count == 0) {

        [self alertHUDWithText:@"请上传活动图片！" Delegate:nil];return;

    }
    
    if (model.position.length == 0) {
        
        [self alertHUDWithText:@"请选择活动位置！" Delegate:nil];return;
        
    }
    
    if (model.number.length == 0) {
        
        [self alertHUDWithText:@"请填写报名人数！" Delegate:nil];return;
        
    }
    
    if (model.startTime.length == 0) {
        
        [self alertHUDWithText:@"请选择开始时间！" Delegate:nil];return;
        
    }
    
    if (model.endTime.length == 0) {
        
        [self alertHUDWithText:@"请选择结束时间！" Delegate:nil];return;
        
    }
    
    if (model.set.length == 0) {
        
        [self alertHUDWithText:@"请输入集合地点！" Delegate:nil];return;
        
    }
    
    NSString *requestUrl = [self.base_url stringByAppendingString:@"UserApi/upactivity"];
        
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:ss"];
    NSDate *startDate = [dateFormatter dateFromString:model.startTime];
    NSDate *endDate = [dateFormatter dateFromString:model.endTime];
    
    NSDictionary *baseParam = @{@"aname":model.title, @"describe":model.content1, @"description":model.content2, @"destination":model.set, @"start":@([startDate timeIntervalSince1970]).stringValue, @"end":@([endDate timeIntervalSince1970]).stringValue, @"uid":self.base_userID, @"price":model.price, @"number":model.number, @"address":model.position};
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionaryWithDictionary:baseParam];
    if (self.issue_type == DDQActivityIssueTypeEdit) {
        
        [requestParam setObject:self.issue_activityID forKey:@"aid"];
        
    }
    
    for (id object in model.changeImages) {
        
        NSInteger index = [model.changeImages indexOfObject:object];
        if ([object isKindOfClass:[UIImage class]]) {
            
            [requestParam setObject:[self base_changeBase64StringWithImage:object] forKey:[NSString stringWithFormat:@"pic%ld", index + 1]];
            
        } else {
            
            NSString *imageUrl = object;
            NSRange hostRange = [imageUrl rangeOfString:self.base_url];
            if (hostRange.location != NSNotFound) {
                
                NSString *pathUrl = [imageUrl substringWithRange:NSMakeRange(hostRange.length + hostRange.location, imageUrl.length - (hostRange.length + hostRange.location))];
                [requestParam setObject:pathUrl forKey:[NSString stringWithFormat:@"pic%ld", index + 1]];
                
            }
        }
    }

    DDQWeakObject(self);
    [self foundation_processNetPOSTRequestWithUrl:requestUrl Param:requestParam WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
        
        return YES;
        
    } AfterAlert:^(int code) {
        
        if (code == 1) {
            
            [weakObjc base_handlePopController];
            
        }
    }];
}

#pragma mark - Custom Delegate
- (void)picker_didSelectSureWithController:(DDQCityPickerController *)controller {
    
    self.activity_cityPick(controller.picker_content);
    
}

- (void)alert_didSelectItem:(DDQAlertItem *)item {
    
    if (item.tag == 3) return;
    
    DDQWeakObject(self);
    [self base_handleImagePickControllerCompleted:^(UIImage * _Nullable scaleImage, NSString * _Nonnull extension) {
        
        weakObjc.activity_cityPickImage(scaleImage);

    } scale:0.5 authorityType:(item.tag == 1) ? DDQFoundationAuthorityPhotoLibary : DDQFoundationAuthorityCamera editing:NO];
}


@end
