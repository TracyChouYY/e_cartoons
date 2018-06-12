//
//  DDQBaseDatePickerController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/10.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBaseDatePickerController.h"

@interface DDQBaseDatePickerController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *base_datePikcerView;

@property (nonatomic, copy) DDQDatePickerChoiceCompleted completed;

@end

@implementation DDQBaseDatePickerController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.base_datePikcerView.timeZone = [NSTimeZone systemTimeZone];
    [self.base_datePikcerView setDate:[NSDate date] animated:YES];
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.base_datePikcerView.backgroundColor = [UIColor whiteColor];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];

}

/**
 点击取消
 */
- (IBAction)picker_didSelectCancel {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}

/**
 点击完成
 */
- (IBAction)picker_didSelectFinished {
    
    if (self.completed) {
       
        self.completed(self.base_datePikcerView.date);
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        
    }
}

- (void)dataPicker_didChoiceTimeCompleted:(DDQDatePickerChoiceCompleted)completed {
    
    if (completed) {
        
        self.completed = completed;
        
    }
}

@end
