//
//  DDQUserInfoHeaderView.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/24.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^DDQUserInfoHeaderPickImage)(void);

/**
 个人资料 - 头部的头像选择
 */
@interface DDQUserInfoHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) UIImage *header_image;
@property (nonatomic, strong) NSString *header_url;
- (void)userInfo_didSelectPickImage:(DDQUserInfoHeaderPickImage)pick;

@end

NS_ASSUME_NONNULL_END

