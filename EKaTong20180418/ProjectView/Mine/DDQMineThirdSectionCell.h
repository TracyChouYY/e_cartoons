//
//  DDQMineThirdSectionCell.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/23.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQCell.h"

#import "DDQMineCellDelegate.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQMineThirdSectionCellStyle) {
    
    DDQMineThirdSectionCellStylePersonal,
    DDQMineThirdSectionCellStyleBase,
    DDQMineThirdSectionCellStyleManager,
    
};

/**
 个人中心 - 分区三的cell。
 基地和管理员的个人中心对应是分区二。显示更多的功能
 */
@interface DDQMineThirdSectionCell : DDQCell

+ (DDQMineThirdSectionCellStyle)mineThirdSectionStyle;

@property (nonatomic, weak, nullable) id <DDQMineCellDelegate> delegate;

@end


#pragma mark - Subviews
@class DDQMineFunctionModel;
@interface DDQMineFunctionItem : UICollectionViewCell

@property (nonatomic, strong) DDQMineFunctionModel *mineModel;

@end

@interface DDQMineFunctionModel : DDQFoundationModel

@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) DDQMineThirdSection_Personal_Operation pOperation;
@property (nonatomic, assign) DDQMineThirdSection_Manager_Operation mOperation;
@property (nonatomic, assign) DDQMineThirdSection_Base_Operation bOperation;

@end

NS_ASSUME_NONNULL_END

