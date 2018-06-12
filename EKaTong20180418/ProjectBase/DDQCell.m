//
//  DDQCell.m
//
//  Copyright © 2018年 WICEP. All rights reserved.

#import "DDQCell.h"

@implementation DDQCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.cell_contentViewWidth = [UIScreen mainScreen].bounds.size.width;
    
    return self;
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    self.cell_contentViewWidth = [UIScreen mainScreen].bounds.size.width;
    return self;
    
}

- (void)setFrame:(CGRect)frame {
    
    frame.size.width = self.cell_contentViewWidth;
    [super setFrame:frame];
    
}

+ (BOOL)cell_useBoundRectLayout {
    
    return NO;
    
}

- (void)cell_updateContentSubviewsFrame {
    
    [super cell_updateContentSubviewsFrame];
    
    if ([self respondsToSelector:@selector(cell_layoutBottomControl)]) {
        
        self.cell_model.model_recordHeight = [self cell_layoutBottomControl].frameMaxY;
        
    }
    
    if ([self respondsToSelector:@selector(cell_bottomMargin)]) {
        
        self.cell_model.model_recordHeight += [self cell_bottomMargin];
    }
}

- (DDQViewVHMargin)cell_defaultControlMargin {
    
    return DDQViewVHMarginMaker(15.0 * self.cell_widthRate, 15.0 * self.cell_widthRate);
    
}

- (DDQViewVHSpace)cell_defaultControlSpace {
    
    return DDQViewVHSpaceMaker(15.0 * self.cell_widthRate, 15.0 * self.cell_widthRate);
    
}

- (NSString *)cell_exchangeWithStartTime:(NSString *)start endTime:(NSString *)end {
    
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:start.doubleValue];
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:end.doubleValue];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger sMonth = [calendar component:NSCalendarUnitMonth fromDate:startDate];
    NSInteger sDay = [calendar component:NSCalendarUnitDay fromDate:startDate];
    NSInteger eMonth = [calendar component:NSCalendarUnitMonth fromDate:endDate];
    NSInteger eDay = [calendar component:NSCalendarUnitDay fromDate:endDate];
    NSString *time = [NSString stringWithFormat:@"%ld.%ld-%ld.%ld", sMonth, sDay, eMonth, eDay];
    return time;
    
}

@end
