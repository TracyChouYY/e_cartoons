//
//  DDQVerifiedController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/25.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQVerifiedController.h"

@interface DDQVerifiedController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verified_topConstant;

@end

@implementation DDQVerifiedController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //RightItem
    UIButton *rightButton = [self setRightBarButtonItemStyle:DDQFoundationBarButtonText Content:@"确定"];
    [rightButton setTitleColor:kSetColor(20.0, 26.0, 36.0, 1.0) forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(verified_didSelectRightItem) forControlEvents:UIControlEventTouchUpInside];

}

- (void)updateViewConstraints {
    
    [super updateViewConstraints];
    
    //Upadte Constraint
    self.verified_topConstant.constant += self.base_safeTopInset;
    
}


- (NSString *)base_navigationTitle {
    
    return @"实名认证";
    
}

/**
 点击右上角的确定按钮
 */
- (void)verified_didSelectRightItem {
    
    
}

@end
