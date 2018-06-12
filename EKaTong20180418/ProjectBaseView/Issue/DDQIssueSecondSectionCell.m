//
//  DDQIssueSecondSectionCell.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/3.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQIssueSecondSectionCell.h"

@interface DDQIssueSecondSectionCell () <DDQContentInputViewDelegate>

@property (nonatomic, strong) DDQContentInputView *content_priceView;
@property (nonatomic, strong) DDQContentInputView *content_startTimeView;
@property (nonatomic, strong) DDQContentInputView *content_endTimeView;
@property (nonatomic, strong) DDQContentInputView *content_locationView;
@property (nonatomic, strong) DDQContentInputView *content_numberView;

@property (nonatomic, strong) DDQContentInputView *content_sortView;
@property (nonatomic, strong) DDQContentInputView *content_stopView;

@end

@implementation DDQIssueSecondSectionCell

- (void)cell_contentViewSubviewsConfig {
    
    [super cell_contentViewSubviewsConfig];
    
    self.content_priceView = [[DDQContentInputView alloc] initInputViewWithStyle:DDQContentInputViewStyleNormal title:@"价格" placeholder:@"￥0"];
    
    self.content_startTimeView = [[DDQContentInputView alloc] initInputViewWithStyle:DDQContentInputViewStylePlaceholder title:@"开始时间" placeholder:@"请选择开始时间"];
    self.content_startTimeView.delegate = self;
    
    self.content_endTimeView = [[DDQContentInputView alloc] initInputViewWithStyle:DDQContentInputViewStylePlaceholder title:@"结束时间" placeholder:@"请选择结束时间"];
    self.content_endTimeView.delegate = self;

    NSMutableArray *subviews = [NSMutableArray arrayWithArray:@[self.content_priceView, self.content_startTimeView, self.content_endTimeView]];
    DDQIssueSecondSectionCellStyle style = [self.class secondSectionCellStyle];
    if (style == DDQIssueSecondSectionCellStyleBase) {
        
        self.content_locationView = [[DDQContentInputView alloc] initInputViewWithStyle:DDQContentInputViewStyleNormal title:@"集合地" placeholder:@"请输入集合地"];
        
        self.content_sortView = [[DDQContentInputView alloc] initInputViewWithStyle:DDQContentInputViewStylePlaceholder title:@"分类" placeholder:@"请选择分类"];
        self.content_sortView.delegate = self;
        
        self.content_stopView = [[DDQContentInputView alloc] initInputViewWithStyle:DDQContentInputViewStylePlaceholder title:@"停车" placeholder:@"请选择停车位"];
        self.content_stopView.delegate = self;

        [subviews addObjectsFromArray:@[self.content_stopView, self.content_sortView, self.content_locationView]];

    } else {
        
        self.content_locationView = [[DDQContentInputView alloc] initInputViewWithStyle:DDQContentInputViewStyleNormal title:@"目的地" placeholder:@"填写目的地"];

        self.content_numberView = [[DDQContentInputView alloc] initInputViewWithStyle:DDQContentInputViewStyleNormal title:@"报名人数" placeholder:@"请填写最多人数"];
        [subviews addObjectsFromArray:@[self.content_locationView, self.content_numberView]];

    }
    
    [self.contentView view_configSubviews:subviews];
    
}

- (void)cell_updateContentSubviewsFrame {
    
    autoLayout(self.content_priceView).ddq_leading(self.contentView.leading, 0.0).ddq_top(self.contentView.top, 0.0).ddq_size(CGSizeMake(self.contentView.width, self.content_priceView.input_estimateHeight));
    
    DDQIssueSecondSectionCellStyle style = [self.class secondSectionCellStyle];
    if (style == DDQIssueSecondSectionCellStyleBase) {
        
        autoLayout(self.content_startTimeView).ddq_leading(self.content_priceView.leading, 0.0).ddq_top(self.content_priceView.bottom, 0.0).ddq_size(CGSizeMake(self.contentView.width, self.content_startTimeView.input_estimateHeight));
        
        autoLayout(self.content_endTimeView).ddq_leading(self.content_startTimeView.leading, 0.0).ddq_top(self.content_startTimeView.bottom, 0.0).ddq_size(CGSizeMake(self.contentView.width, self.content_endTimeView.input_estimateHeight));
        
        autoLayout(self.content_locationView).ddq_leading(self.content_endTimeView.leading, 0.0).ddq_top(self.content_endTimeView.bottom, 0.0).ddq_size(CGSizeMake(self.contentView.width, self.content_locationView.input_estimateHeight));
        
        autoLayout(self.content_sortView).ddq_leading(self.content_locationView.leading, 0.0).ddq_top(self.content_locationView.bottom, 0.0).ddq_size(CGSizeMake(self.contentView.width, self.content_sortView.input_estimateHeight));

        autoLayout(self.content_stopView).ddq_leading(self.content_sortView.leading, 0.0).ddq_top(self.content_sortView.bottom, 0.0).ddq_size(CGSizeMake(self.contentView.width, self.content_stopView.input_estimateHeight));

    } else {
        
        autoLayout(self.content_numberView).ddq_leading(self.content_priceView.leading, 0.0).ddq_top(self.content_priceView.bottom, 0.0).ddq_size(CGSizeMake(self.contentView.width, self.content_numberView.input_estimateHeight));

        autoLayout(self.content_locationView).ddq_leading(self.content_numberView.leading, 0.0).ddq_top(self.content_numberView.bottom, 0.0).ddq_size(CGSizeMake(self.contentView.width, self.content_locationView.input_estimateHeight));

        autoLayout(self.content_startTimeView).ddq_leading(self.content_locationView.leading, 0.0).ddq_top(self.content_locationView.bottom, 0.0).ddq_size(CGSizeMake(self.contentView.width, self.content_startTimeView.input_estimateHeight));

        autoLayout(self.content_endTimeView).ddq_leading(self.content_startTimeView.leading, 0.0).ddq_top(self.content_startTimeView.bottom, 0.0).ddq_size(CGSizeMake(self.contentView.width, self.content_endTimeView.input_estimateHeight));

    }

    [super cell_updateContentSubviewsFrame];

}

- (void)cell_updateDataWithModel:(__kindof DDQBaseCellModel *)model {
    
    DDQIssueSecondSectionModel *secondModel = model;
    DDQIssueSecondSectionCellStyle style = [self.class secondSectionCellStyle];
    if (style == DDQIssueSecondSectionCellStyleBase) {
    
        self.content_priceView.input_textField.text = secondModel.base_price;
        if (secondModel.base_start.length > 0) {
            
            self.content_startTimeView.input_textField.text = [self view_changeTimes:secondModel.base_start format:@"yyyy-MM-dd HH:mm"];
            
        }
        
        if (secondModel.base_end.length > 0) {
            
            self.content_endTimeView.input_textField.text = [self view_changeTimes:secondModel.base_end format:@"yyyy-MM-dd HH:mm"];

        }
        self.content_locationView.input_textField.text = secondModel.base_resort;
        self.content_sortView.input_textField.text = secondModel.type_name;
        
        if (secondModel.base_park.length > 0) {
            
            self.content_stopView.input_textField.text = secondModel.base_park.intValue == 1 ? @"免费停车" : @"收费停车";

        }
    } else {
        
        self.content_priceView.input_textField.text = secondModel.activity_price;
        if (secondModel.activity_start.length > 0) {
            
            self.content_startTimeView.input_textField.text = [self view_changeTimes:secondModel.activity_start format:@"yyyy-MM-dd HH:mm"];
            
        }
        
        if (secondModel.activity_end.length > 0) {
            
            self.content_endTimeView.input_textField.text = [self view_changeTimes:secondModel.activity_end format:@"yyyy-MM-dd HH:mm"];
            
        }
        
        self.content_numberView.input_textField.text = secondModel.activity_number;
        self.content_locationView.input_textField.text = secondModel.activity_destination;
        
    }
    
    [super cell_updateDataWithModel:model];
    
}

- (UIView *)cell_layoutBottomControl {
    
    return ([self.class secondSectionCellStyle] == DDQIssueSecondSectionCellStyleBase) ? self.content_stopView : self.content_endTimeView;
    
}

+ (DDQIssueSecondSectionCellStyle)secondSectionCellStyle {
    
    return DDQIssueSecondSectionCellStyleBase;
    
}

- (NSString *)startTime {
    
    return self.content_startTimeView.input_textField.text;
    
}

- (NSString *)endTime {
    
    return self.content_endTimeView.input_textField.text;
    
}

- (NSString *)parking {
    
    return self.content_stopView.input_textField.text;
    
}

- (NSString *)sort {
    
    return self.content_sortView.input_textField.text;
    
}

- (NSString *)price {
    
    return self.content_priceView.input_textField.text;
    
}

- (NSString *)setLoction {
    
    return self.content_locationView.input_textField.text;
    
}

- (NSString *)number {
    
    return self.content_numberView.input_textField.text;
    
}

#pragma mark - Custom View Delegate
- (void)content_didSelectPlaceholderWithView:(DDQContentInputView *)view {
    
    SEL targetSel = @selector(second_didSelectChoiceStartTimeWithCell:inputView:);
    if (self.content_endTimeView == view) {
        
        targetSel = @selector(second_didSelectChoiceEndTimeWithCell:inputView:);

    } else if (self.content_sortView == view) {
        
        targetSel = @selector(second_didSelectChoiceSortWithCell:inputView:);
        
    } else if (self.content_stopView == view) {
        
        targetSel = @selector(second_didSelectChoiceStopLocationWithCell:inputView:);
        
    }
    
    if (self.delegate && [self.delegate respondsToSelector:targetSel]) {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

        [self.delegate performSelector:targetSel withObject:self withObject:view];
        
#pragma clang diagnostic pop

    }

}

@end

@implementation DDQIssueSecondSectionModel

@end
