//
//  DDQOrderContainerController.m
//
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQOrderContainerController.h"

#import "DDQAllOderController.h"
#import "DDQFinishOrderController.h"
#import "DDQOrderDetailController.h"

#import "DDQOperationBar.h"

@interface DDQOrderContainerController ()

@property (nonatomic, strong) DDQOperationBar *order_operationBar;

@property (nonatomic, strong) DDQAllOderController *order_allController;
@property (nonatomic, strong) DDQFinishOrderController *order_finishedController;

@end

@implementation DDQOrderContainerController

- (instancetype)init {
    
    self = [super init];
    
    self.order_status = DDQOrderContainerStatusAll;
    
    return self;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    //Subview
    self.order_operationBar = [[DDQOperationBar alloc] initBarWithContainer:@[@"全部", @"未付款", @"已付款", @"已完成"]];
    [self.view addSubview:self.order_operationBar];
    self.order_operationBar.bar_underLineFill = NO;
    
    NSInteger selectIndex;
    switch (self.order_status) {
            
        case DDQOrderContainerStatusAll:
            selectIndex = 0;
            break;
            
        case DDQOrderContainerStatusPaid:
            selectIndex = 2;
            break;

        case DDQOrderContainerStatusUnpaid:
            selectIndex = 1;
            break;

        case DDQOrderContainerStatusFinished:
            selectIndex = 3;
            break;

        default:
            break;
    }
    self.order_operationBar.bar_index = selectIndex;
    
    //SubController
    [self container_subControllerConfig];
    
    //Handler
    [self.base_handler handler_responseTarget:self selector:@selector(container_handleWhenSubControllerOperationWithData:)];
    
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    self.order_operationBar.frame = CGRectMake(0.0, self.base_safeTopInset, self.view.width, 40.0);

    CGRect subControllerViewRect = CGRectMake(0.0, self.order_operationBar.frameMaxY, self.order_operationBar.width, self.view.height - self.order_operationBar.frameMaxY - self.base_safeBottomInset);
    self.view.subviews.lastObject.frame = subControllerViewRect;
    
}

- (NSString *)base_navigationTitle {
    
    return @"我的订单";
    
}

/**
 子控制器配置
 */
- (void)container_subControllerConfig {
    
    self.order_allController = [[DDQAllOderController alloc] init];
    self.order_finishedController = [[DDQFinishOrderController alloc] init];
    
    [self addChildViewController:self.order_allController];
    
    [self.view addSubview:self.order_allController.view];
    
}

/**
 当自控制器发生了时间响应后的集中处理

 @param data 传值
 */
- (void)container_handleWhenSubControllerOperationWithData:(id)data {
    
    NSLog(@"%@", data);
    [self base_handleInitializeWithControllerClass:[DDQOrderDetailController class] FromNib:NO title:nil propertys:nil];
//    id cellData = (data[DDQHandlerResultModel]) ? data[DDQHandlerResultModel] : data[DDQHandlerResultData];
//    if (cellData) {
//
//
//    }
}

@end
