//
//  DDQMineCellDelegate.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/24.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQMineFirstSectionCellStyle) {
    
    DDQMineFirstSectionCellStylePersonal,       //个人中心
    DDQMineFirstSectionCellStyleBase,           //基地管理
    DDQMineFirstSectionCellStyleManager,        //管理员管理
    
};

typedef NS_ENUM(NSUInteger, DDQMineSecondSection_Operation) {
    
    DDQMineSecondSection_Operation_All,         //全部
    DDQMineSecondSection_Operation_Unpaid,      //待付款
    DDQMineSecondSection_Operation_Paid,        //已付款
    DDQMineSecondSection_Operation_Finished,    //已完成
    DDQMineSecondSection_Operation_Evaluate,    //待评价
    
};

typedef NS_ENUM(NSUInteger, DDQMineThirdSection_Personal_Operation) {
    
    DDQMineThirdSection_Personal_Operation_Point = 1,       //我的积分
    DDQMineThirdSection_Personal_Operation_Coupon,          //优惠券
    DDQMineThirdSection_Personal_Operation_Suggestion,      //建议
    DDQMineThirdSection_Personal_Operation_Collection,      //我的收藏
    DDQMineThirdSection_Personal_Operation_Voucher,         //观演凭证
    
};

typedef NS_ENUM(NSUInteger, DDQMineThirdSection_Manager_Operation) {
    
    DDQMineThirdSection_Manager_Operation_Register = 1,
    DDQMineThirdSection_Manager_Operation_Base,
    DDQMineThirdSection_Manager_Operation_Activity,
    
};

typedef NS_ENUM(NSUInteger, DDQMineThirdSection_Base_Operation) {
    
    DDQMineThirdSection_Base_Operation_Base = 1,
    DDQMineThirdSection_Base_Operation_Activity,
};

@protocol DDQMineCellDelegate <NSObject>

@optional

/**
 分区一，点击用户头像
 除个人以外，其他两种样式点击无效

 @param style 当前显示cell的样式
 */
- (void)first_didSelectUserIconWithStyle:(DDQMineFirstSectionCellStyle)style;

/**
 分区一，点击右上角的按钮。
 个人是“设置”页
 基地是“基地编辑”页

 @param style 当前显示cell的样式
 */
- (void)first_didSelectToRightCornerButtonWithStyle:(DDQMineFirstSectionCellStyle)style;

/**
 点击了“会员中心”
 只有个人的个人中心头像下的控件能够点击
 */
- (void)first_didSelectMemberCenter;

/**
 点击了“我的钱包”
 */
- (void)first_didSelectWallet;

/**
 个人，个人中心分区二的点击事件

 @param operation 点击的订单类型
 */
- (void)second_didSelctOrderOperation:(DDQMineSecondSection_Operation)operation;

/**
 个人，个人中心分区三的“更多功能”

 @param operation 操作的类型
 */
- (void)third_personal_didSelectOperation:(DDQMineThirdSection_Personal_Operation)operation;

/**
 基地，个人中心分区三的“更多功能”
 
 @param operation 操作的类型
 */
- (void)third_base_didSelectOperation:(DDQMineThirdSection_Base_Operation)operation;

/**
 管理员，个人中心分区三的“更多功能”
 
 @param operation 操作的类型
 */
- (void)third_manager_didSelectOperation:(DDQMineThirdSection_Manager_Operation)operation;

@end

NS_ASSUME_NONNULL_END

