//
//  DDQParkingCarController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/11.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQParkingCarController.h"

@interface DDQParkingCarController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *parking_contentTop;
@property (nonatomic, copy) DDQSelectParkingCarStatus parking_status;

@end

@implementation DDQParkingCarController

- (NSString *)base_navigationTitle {
    
    return @"停车位";
    
}

- (void)updateViewConstraints {
    
    [super updateViewConstraints];
    
    self.parking_contentTop.constant = self.base_safeTopInset;
    
}

/**
 点击收费停车
 */
- (IBAction)parking_didSelectFee:(UIButton *)button {
    
    if (self.parking_status) {
        
        self.parking_status(DDQParkingCarStatusFee, [button titleForState:UIControlStateNormal]);
        [self base_handlePopController];

    }
}

/**
 点击免费停车
 */
- (IBAction)parking_didSelectFree:(UIButton *)button {
    
    if (self.parking_status) {
        
        self.parking_status(DDQParkingCarStatusFree, [button titleForState:UIControlStateNormal]);
        [self base_handlePopController];
        
    }
}


- (void)parking_didSelectParkingStatus:(DDQSelectParkingCarStatus)status {
    
    if (status) {
        
        self.parking_status = status;
        
    }
}

@end
