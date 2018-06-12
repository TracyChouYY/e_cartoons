//
//  DDQContentImageItem.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/11.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQContentImageItem.h"

#import "UIView+DDQAdditionalContent.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface DDQContentImageItem ()

@property (nonatomic, strong, readwrite) UIImageView *item_imageView;
@property (nonatomic, strong) UIButton *item_closeButton;

@end

@implementation DDQContentImageItem

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    self.item_imageView = [UIImageView imageView];
    
    self.item_closeButton = [UIButton buttonChangeFont:nil titleColor:nil image:kSetImage(@"image_close") backgroundImage:nil title:nil attributeTitle:nil target:self sel:@selector(content_didSelectClose)];
    self.item_closeButton.hidden = YES;
    
    [self.contentView view_configSubviews:@[self.item_imageView, self.item_closeButton]];
    
    return self;
    
}

- (void)updateConstraints {

    [super updateConstraints];
    
    [self.item_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView.mas_left).offset(11.0);
        make.top.equalTo(self.contentView.mas_top).offset(11.0);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        
    }];
    
    [self.item_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.item_imageView.mas_left);
        make.centerY.equalTo(self.item_imageView.mas_top);
        
    }];
}

/**
 点击关闭
 */
- (void)content_didSelectClose {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(content_didSelectCloseWithCell:)]) {
        
        [self.delegate content_didSelectCloseWithCell:self];
        
    }
}

- (void)content_updateImage:(UIImage *)image {
    
    self.item_closeButton.hidden = (image.isDefault) ? YES : NO;
    
    self.item_imageView.image = image;
    [self setNeedsUpdateConstraints];
    
 }

- (void)content_updateImageUrl:(NSString *)imageUrl {

    self.item_closeButton.hidden = NO;
    
    [self.item_imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    [self setNeedsUpdateConstraints];

}


@end
