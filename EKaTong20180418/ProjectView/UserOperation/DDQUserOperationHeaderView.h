//
//  DDQUserOperationHeaderView.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/18.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DDQUserOperationHeaderViewStyle) {
    
    DDQUserOperationHeaderViewStyleRegister,        //注册
    DDQUserOperationHeaderViewStyleLogin,           //登录
    DDQUserOperationHeaderViewStyleForget,          //忘记密码
    
};

typedef NS_ENUM(NSUInteger, DDQUserOperationHeaderSelectType) {
    
    DDQUserOperationHeaderSelectTypeToPersonalLogin,          //个人登录
    DDQUserOperationHeaderSelectTypeToBaseLogin,              //基地登录
    DDQUserOperationHeaderSelectTypeToManageLogin,            //管理员登录
    
};
typedef void(^DDQUserOperationHeaderSelectCompleted)(DDQUserOperationHeaderSelectType selectType);

/**
 用户操作（比如：登录、注册等）头视图
 */
@interface DDQUserOperationHeaderView : DDQView

- (instancetype)initHeaderViewWithStyle:(DDQUserOperationHeaderViewStyle)style DDQ_DESIGNATED_INITIALIZER;

@property (nonatomic, strong, readonly) UILabel *header_titleLabel;

/**
 显示选中第几种登录方式
 */
@property (nonatomic, assign) NSInteger header_index;

- (void)header_didSelectTypeCompleted:(DDQUserOperationHeaderSelectCompleted)completed;

@end

NS_ASSUME_NONNULL_END
