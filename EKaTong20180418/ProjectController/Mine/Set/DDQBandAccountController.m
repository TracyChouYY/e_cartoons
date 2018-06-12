//
//  DDQBandAccountController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/25.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBandAccountController.h"

@interface DDQBandAccountController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *band_topConstraint;

@end

@implementation DDQBandAccountController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)updateViewConstraints {
    
    [super updateViewConstraints];
    
    self.band_topConstraint.constant += self.base_safeTopInset;

}

- (NSString *)base_navigationTitle {
    
    return @"账号绑定";
    
}

@end
