//
//  DDQSetCell.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/25.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQSetCellStyle) {
    
    DDQSetCellStyleNormal = 0,       //普通样式
    DDQSetCellStyleCache,            //缓存
};

/**
 设置 - cell的布局
 */
@interface DDQSetCell : DDQCell

+ (DDQSetCellStyle)setCellStyle;

@end

@interface DDQSetModel : DDQBaseCellModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *size;

@end

NS_ASSUME_NONNULL_END

