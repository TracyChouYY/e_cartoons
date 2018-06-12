//
//  DDQMyCollectionCell.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/27.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQMyCollectionCell.h"

@interface DDQMyCollectionCell ()

@property (nonatomic, strong) UIImageView *collection_imageView;
@property (nonatomic, strong) UILabel *collection_titleLabel;
@property (nonatomic, strong) UILabel *collection_timeLabel;
@property (nonatomic, strong) UILabel *collection_priceLabel;

@end

@implementation DDQMyCollectionCell

- (void)cell_contentViewSubviewsConfig {
    
    [super cell_contentViewSubviewsConfig];
    
    self.collection_imageView = [UIImageView imageView];
    self.collection_imageView.layer.cornerRadius = 3.0;
    self.collection_imageView.layer.masksToBounds = YES;
    
    self.collection_titleLabel = [UILabel labelChangeText:@"" font:DDQFont(16.0) textColor:kSetColor(20.0, 26.0, 36.0, 1.0)];
    
    self.collection_timeLabel = [UILabel labelChangeText:@"" font:DDQFont(13.0) textColor:self.defaultGrayColor];
    
    self.collection_priceLabel = [UILabel labelChangeText:@"" font:DDQFont(16.0) textColor:self.defaultOrangeColor];
    
    [self.contentView view_configSubviews:@[self.collection_titleLabel, self.collection_imageView, self.collection_priceLabel, self.collection_timeLabel]];
    
}

- (void)cell_updateContentSubviewsFrame {
    
    autoLayout(self.collection_imageView).ddq_leading(self.contentView.leading, self.cell_defaultLeftMargin).ddq_top(self.contentView.top, 10.0 * self.cell_widthRate).ddq_size(CGSizeMake(110.0 * self.cell_widthRate, 70.0 * self.cell_widthRate));
    
    CGSize maxSize = CGSizeMake(self.contentView.width - self.collection_imageView.frameMaxX - 10.0 * self.cell_widthRate - self.collection_imageView.x, 17.5);
    autoLayout(self.collection_titleLabel).ddq_leading(self.collection_imageView.trailing, 10.0 * self.cell_widthRate).ddq_top(self.collection_imageView.top, 5.0).ddq_estimateSize(maxSize);
    
    autoLayout(self.collection_timeLabel).ddq_leading(self.collection_titleLabel.leading, 0.0).ddq_top(self.collection_titleLabel.bottom, 10.0 * self.cell_widthRate).ddq_estimateSize(CGSizeMake(maxSize.width, 14.5));
    
    autoLayout(self.collection_priceLabel).ddq_leading(self.collection_titleLabel.leading, 0.0).ddq_top(self.collection_timeLabel.bottom, 10.0 * self.cell_widthRate).ddq_fitSize();
    
    [super cell_updateContentSubviewsFrame];
    
}

- (void)cell_updateDataWithModel:(__kindof DDQBaseCellModel *)model {
    
    DDQMyCollectionModel *collectionModel = model;
    
    [self.collection_imageView sd_setImageWithURL:[NSURL URLWithString:collectionModel.image]];
    
    self.collection_titleLabel.text = collectionModel.name;
    self.collection_timeLabel.text = [self cell_exchangeWithStartTime:collectionModel.start endTime:collectionModel.end];
    
    NSString *price = [NSString stringWithFormat:@"￥%@/人", collectionModel.price];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:price attributes:@{NSFontAttributeName:DDQFont(16.0), NSForegroundColorAttributeName:self.defaultOrangeColor}];
    [attr addAttribute:NSFontAttributeName value:DDQFont(12.0) range:[price rangeOfString:@"￥"]];
    [attr addAttribute:NSFontAttributeName value:DDQFont(12.0) range:[price rangeOfString:@"/人"]];
    self.collection_priceLabel.attributedText = attr.copy;
    
    [super cell_updateDataWithModel:model];
    
}

- (UIView *)cell_layoutBottomControl {
    
    return (self.collection_imageView.frameMaxY > self.collection_priceLabel.frameMaxY) ? self.collection_imageView : self.collection_priceLabel;
    
}

- (CGFloat)cell_bottomMargin {
    
    return self.collection_imageView.y;
    
}

@end

@implementation DDQMyCollectionModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID":@"id"};
    
}

- (NSDictionary *)model_handlerReplaceProperty {
    
    return @{@"ID":@"id"};
    
}

@end
