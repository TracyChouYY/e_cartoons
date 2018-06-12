//
//  DDQWalletThirdSectionCell.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/26.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQCell.h"

NS_ASSUME_NONNULL_BEGIN

/**
 钱包 - 分区三的cell，显示充值方式
 */
@interface DDQWalletThirdSectionCell : DDQCell

@end

@interface DDQWalletWayModel : DDQBaseCellModel

@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END

