//
//  DDQVoucherCell.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/27.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQVoucherCellStyle) {
    
    DDQVoucherCellStyleUnknown,         //未知
    DDQVoucherCellStyleExamine,         //已检验
    DDQVoucherCellStyleUnexamine,       //未检验
    
};

/**
 观演凭证 - cell的布局
 */
@interface DDQVoucherCell : DDQCell

+ (DDQVoucherCellStyle)voucherCellStyle;

@end

NS_ASSUME_NONNULL_END

