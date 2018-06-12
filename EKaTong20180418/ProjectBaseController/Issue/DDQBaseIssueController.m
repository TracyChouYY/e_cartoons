//
//  DDQBaseIssueController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/3.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBaseIssueController.h"

#import "DDQBaseSortController.h"
#import "DDQParkingCarController.h"
#import "DDQBaseDatePickerController.h"

#import "DDQIssueView.h"

#import "DDQIssueFirstSectionCell.h"
#import "DDQIssueSecondSectionCell.h"

typedef void(^DDQBaseCityPickBlock)(NSString *text);
typedef void(^DDQBaseCityPickImageBlock)(UIImage *pickerImage);

@interface DDQBaseIssueController () <DDQIssueViewDelagte, DDQCityPickerControllerDelegate>

@property (nonatomic, strong) DDQIssueView *base_issueView;
@property (nonatomic, copy) DDQBaseCityPickBlock base_cityPick;
@property (nonatomic, copy) DDQBaseCityPickImageBlock base_cityPickImage;
@property (nonatomic, copy) NSString *base_sortId;
@property (nonatomic, copy) NSString *base_parking;

@end

@implementation DDQBaseIssueController

- (instancetype)init {
    
    self = [super init];
    
    self.base_id = self.base_infomationManager.bid;
    
    return self;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.base_parking = @"";
    self.base_sortId = @"";
    
    //Subview
    self.base_issueView = [[DDQIssueView alloc] initIssueViewWithStyle:DDQIssueViewStyleBase];
    [self.view addSubview:self.base_issueView];
    self.base_issueView.delegate = self;
    
    //Net Request
    if (self.base_infomationManager.base.intValue > 0) {
        
        [self issue_netRequest];

    } else {
        
        [self.base_issueView setIssue_dataSource:@[@[[DDQIssueFirstSectionModel mj_objectWithKeyValues:@{}]],
                                                   @[[DDQIssueSecondSectionModel mj_objectWithKeyValues:@{}]]
                                                   ]];
         
    }
}

- (UIView *)foundation_HUDSuperView {
    
    return self.view;
    
}

- (NSString *)base_navigationTitle {
    
    return @"基地发布";
    
}

- (void)setBase_id:(NSString *)base_id {
    
    if (base_id.length > 0) {
        
        _base_id = base_id;
        
    } else {
        
        _base_id = self.base_infomationManager.bid;
        
    }
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
    NSString *requestUrl = [self.base_url stringByAppendingString:@"UserApi/bdetail"];
    [self foundation_processNetPOSTRequestWithUrl:requestUrl Param:@{@"bid":self.base_infomationManager.bid} WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
        
        if (code == 1) {
            
            NSDictionary *dic = [weakObjc base_handleRequestDataIfLegal:response[@"list"] targetClass:[NSDictionary class]];
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
            weakObjc.base_issueView.issue_dataSource = @[@[firstModel], @[secondModel]];
            
            weakObjc.base_sortId = secondModel.base_type;
            weakObjc.base_parking = secondModel.base_park;
            
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
    
    self.base_cityPickImage = ^(UIImage *pickerImage) {
        
        image(pickerImage);
        
    };
}

- (void)issue_didSelectPickerEndTime:(void (^)(NSString * _Nonnull))endTime {
    
    [self issue_handlerDatePickerCompleted:^(NSString *timeText) {
        
        endTime(timeText);
        
    } endTime:YES];
}

- (void)issue_didSelectSort:(void (^)(NSString * _Nonnull))sort {
    
    DDQWeakObject(self);
    DDQBaseSortController *sortC = [self base_handleInitializeWithControllerClass:[DDQBaseSortController class] FromNib:NO title:nil propertys:nil];
    [sortC sort_didSelectSort:^(NSDictionary<DDQBaseSortDataKey,NSString *> * _Nonnull data) {
        
        sort(data[DDQBaseSortDataNameKey]);
        weakObjc.base_sortId = data[DDQBaseSortDataIdKey];
        
    }];
}

- (void)issue_didSelectStopLocation:(void (^)(NSString * _Nonnull))location {
    
    DDQWeakObject(self);
    DDQParkingCarController *parkingC = [self base_handleInitializeWithControllerClass:[DDQParkingCarController class] FromNib:YES title:nil propertys:nil];
    [parkingC parking_didSelectParkingStatus:^(DDQParkingCarStatus status, NSString * _Nonnull text) {
        
        location(text);
        weakObjc.base_parking = (status == DDQParkingCarStatusFee) ? @"2" : @"1";
        
    }];
}

- (void)issue_didSelectContentPosition:(void (^)(NSString * _Nonnull))position {
    
    DDQCityPickerController *pickerController = [[DDQCityPickerController alloc] init];
    [self presentViewController:pickerController animated:YES completion:nil];
    pickerController.picker_pickerView.backgroundColor = [UIColor whiteColor];
    pickerController.delegate = self;
    
    self.base_cityPick = ^(NSString *text) {
        
        position(text);
        
    };
}

- (void)issue_didSelectSubmiteWithModel:(DDQIssueDataModel *)model {
    
    int status = self.base_infomationManager.base.intValue;

    if (model.title.length == 0) {
        
        [self alertHUDWithText:@"请填写基地名称！" Delegate:nil];return;
        
    }
    
    if (model.content1.length == 0) {
        
        [self alertHUDWithText:@"请填写景区特色！" Delegate:nil];return;
        
    }
    
    if (model.content2.length == 0) {
        
        [self alertHUDWithText:@"请填写门票须知！" Delegate:nil];return;
        
    }

    if (model.changeImages.count == 0) {
        
        [self alertHUDWithText:@"请上传基地图片！" Delegate:nil];return;

    }

    if (model.position.length == 0) {
        
        [self alertHUDWithText:@"请选择基地位置！" Delegate:nil];return;

    }
    
    if (model.price.length == 0) {
        
        [self alertHUDWithText:@"请输入价格！" Delegate:nil];return;
        
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

    if (model.sort.length == 0) {
        
        [self alertHUDWithText:@"请选择分类！" Delegate:nil];return;
        
    }

    if (model.parking.length == 0) {
        
        [self alertHUDWithText:@"请选择停车状态！" Delegate:nil];return;
        
    }
    
    NSString *requestUrl = [self.base_url stringByAppendingString:@"UserApi/upbase"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:ss"];
    NSDate *startDate = [dateFormatter dateFromString:model.startTime];
    NSDate *endDate = [dateFormatter dateFromString:model.endTime];

    NSDictionary *baseParam = @{@"bname":model.title, @"type":self.base_sortId, @"park":self.base_parking, @"scenic":model.content1, @"notice":model.content2, @"price":model.price, @"address":model.position, @"start":@([startDate timeIntervalSince1970]).stringValue, @"end":@([endDate timeIntervalSince1970]).stringValue, @"uid":self.base_userID, @"resort":model.set};
    NSMutableDictionary *requestParam = [NSMutableDictionary dictionaryWithDictionary:baseParam];
    if (status == 1) {//编辑不需要传UID
        
        [requestParam removeObjectForKey:@"uid"];
        [requestParam setObject:self.base_id forKey:@"bid"];
        
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
       
        if (code == 1) {
            
            //手动改成1，表示已提交
            weakObjc.base_infomationManager.base = @"1";
            weakObjc.base_infomationManager.bid = [weakObjc base_handleRequestStringIfIllegal:response[@"bid"]];
            
        }
        return YES;
        
    } AfterAlert:^(int code) {
        
        if (code == 1) {
            
            [weakObjc base_handlePopController];
            
        }
    }];
}

#pragma mark - Custom Delegate
- (void)picker_didSelectSureWithController:(DDQCityPickerController *)controller {
    
    self.base_cityPick(controller.picker_content);
    
}

- (void)alert_didSelectItem:(DDQAlertItem *)item {
    
    if (item.tag == 3) return;
    
    DDQWeakObject(self);
    [self base_handleImagePickControllerCompleted:^(UIImage * _Nullable scaleImage, NSString * _Nonnull extension) {
        
        weakObjc.base_cityPickImage(scaleImage);
        
    } scale:0.1 authorityType:(item.tag == 1) ? DDQFoundationAuthorityPhotoLibary : DDQFoundationAuthorityCamera editing:NO];
}


@end
