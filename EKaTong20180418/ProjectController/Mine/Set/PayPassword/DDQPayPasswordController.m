
//
//  DDQPayPasswordController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/12.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQPayPasswordController.h"

#import "DDQSetPayPasswordController.h"
#import "DDQEditPayPasswordController.h"
#import "DDQGetBackPayPasswordController.h"

@interface UIButton (DDQPayOperation)

@property (nonatomic, assign) BOOL isSetPayPassword;

@end

@implementation UIButton (DDQPayOperation)

static const char *Operation = "Operation";
- (void)setIsSetPayPassword:(BOOL)isSetPayPassword {
    
    objc_setAssociatedObject(self, Operation, @(isSetPayPassword), OBJC_ASSOCIATION_RETAIN);
    
}

- (BOOL)isSetPayPassword {
    
    return [objc_getAssociatedObject(self, Operation) boolValue];
    
}

@end

@interface DDQPayPasswordController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *first_top;
@property (weak, nonatomic) IBOutlet UIButton *pay_firstButton;

@end

@implementation DDQPayPasswordController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self pay_handleButtonOperation];

}

- (void)base_handleWhenInformationKeyValueChange:(DDQUserInformationManager *)manager {
    
    if ([manager.information_changeKeys containsObject:@"zfpwd"]) {
        
        [self pay_handleButtonOperation];
        
    }
}

- (NSString *)base_navigationTitle {
    
    return @"支付设置";
    
}

- (void)updateViewConstraints {
    
    [super updateViewConstraints];
    
    self.first_top.constant = self.base_safeTopInset;
    
}

/**
 两个按钮的点击事件

 @param sender 按钮
 
 */
- (IBAction)pay_didSelectOperationWithButton:(UIButton *)sender {

    if (sender == self.pay_firstButton) {
        
        Class controllerClass = sender.isSetPayPassword ? [DDQSetPayPasswordController class] : [DDQEditPayPasswordController class];
        [self base_handleInitializeWithControllerClass:controllerClass FromNib:NO title:nil propertys:nil];

    } else {
        
        [self base_handleInitializeWithControllerClass:[DDQGetBackPayPasswordController class] FromNib:NO title:nil propertys:nil];
        
    }
}

/**
 处理当前按钮的显示文字
 */
- (void)pay_handleButtonOperation {
    
    int passwordStatus = self.base_infomationManager.zfpwd.intValue;
    [self.pay_firstButton setTitle:(passwordStatus == 1) ? @"修改支付密码" : @"设置支付密码"  forState:UIControlStateNormal];
    self.pay_firstButton.isSetPayPassword = (passwordStatus == 1) ? NO : YES;
    
}

@end
