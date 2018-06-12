//
//  DDQContentImageItem.h
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/11.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DDQContentImageItemDelegate;

/**
 图片选择
 */
@interface DDQContentImageItem : UICollectionViewCell

@property (nonatomic, weak, nullable) id <DDQContentImageItemDelegate> delegate;

- (void)content_updateImage:(UIImage *)image;

- (void)content_updateImageUrl:(NSString *)imageUrl;

@end

@protocol DDQContentImageItemDelegate <NSObject>

@optional
- (void)content_didSelectCloseWithCell:(DDQContentImageItem *)item;

@end

NS_ASSUME_NONNULL_END
