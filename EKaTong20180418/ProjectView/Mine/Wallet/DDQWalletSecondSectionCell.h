//
//  DDQWalletSecondSectionCell.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/26.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQCell.h"

NS_ASSUME_NONNULL_BEGIN
@class DDQWalletPackageView;
/**
 钱包 - 分区二的cell，显示充值套餐
 */
@interface DDQWalletSecondSectionCell : DDQCell

@end

typedef NS_ENUM(NSUInteger, DDQWalletPackageViewStyle) {
    
    DDQWalletPackageViewStyleSilver,        //银套餐
    DDQWalletPackageViewStyleGold,          //金套餐
    DDQWalletPackageViewStyleDiamond,       //钻石套餐
};

@protocol DDQWalletPackageViewDelegate <NSObject>

@optional
- (void)package_didSelectPackageView:(DDQWalletPackageView *)view;

@end

@interface DDQWalletPackageView : DDQBaseView

- (instancetype)initPackageViewWithStyle:(DDQWalletPackageViewStyle)style DDQ_DESIGNATED_INITIALIZER;

@property (nonatomic, weak, nullable) id <DDQWalletPackageViewDelegate> delegate;

@property (nonatomic, assign) BOOL view_selected;

/**
 返回当前套餐下的金额
 */
@property (nonatomic, assign) CGFloat price;

@end

NS_ASSUME_NONNULL_END

