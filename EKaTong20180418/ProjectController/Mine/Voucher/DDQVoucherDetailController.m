//
//  DDQVoucherDetailController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/28.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQVoucherDetailController.h"

#import "DDQVoucherDetailView.h"

@interface DDQVoucherDetailController ()

@property (nonatomic, strong) DDQVoucherDetailView *detail_view;

@end

@implementation DDQVoucherDetailController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.detail_view = [[DDQVoucherDetailView alloc] initViewWithFrame:CGRectZero];
    [self.view addSubview:self.detail_view];
    
}

@end
