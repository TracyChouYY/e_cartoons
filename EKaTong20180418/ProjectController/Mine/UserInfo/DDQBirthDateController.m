//
//  DDQBirthDateController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/12.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBirthDateController.h"

@interface DDQBirthDateController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *birth_datePickerView;
@property (nonatomic, copy) DDQSelectBirthDate birth_date;

@end

@implementation DDQBirthDateController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.birth_datePickerView.datePickerMode = UIDatePickerModeDate;
    self.birth_datePickerView.maximumDate = [NSDate date];
    self.birth_datePickerView.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];

}

/**
 点击确定
 */
- (IBAction)birth_didSelectSure {
    
    if (self.birth_date) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        self.birth_date([formatter stringFromDate:self.birth_datePickerView.date]);
        
    }
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];

}

/**
 点击取消
 */
- (IBAction)birth_didSelectCancel {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)birth_didSelectBirthDate:(DDQSelectBirthDate)date {
    
    if (date) {
        
        self.birth_date = date;
        
    }
}

@end
