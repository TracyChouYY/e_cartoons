//
//  DDQManagerReviewCell.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/3.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQManagerReviewCell.h"

@interface DDQManagerReviewCell ()

@property (nonatomic, strong) UIImageView *review_imageView;
@property (nonatomic, strong) UILabel *review_titleLabel;
@property (nonatomic, strong) UILabel *review_timeLabel;
@property (nonatomic, strong) UILabel *review_addressLabel;
@property (nonatomic, strong) UIView *review_separator;
@property (nonatomic, strong) UIButton *review_passButton;
@property (nonatomic, strong) UIButton *review_rejectButton;

@end

@implementation DDQManagerReviewCell

- (void)cell_contentViewSubviewsConfig {
    
    [super cell_contentViewSubviewsConfig];
    
    DDQManagerReviewCellStyle style = [self.class reviewCellStyle];
    
    if (style != DDQManagerReviewCellStyleRegister) {
        
        self.review_imageView = [UIImageView imageView];
        [self.contentView addSubview:self.review_imageView];
        
    }
    
    self.review_titleLabel = [UILabel labelChangeText:@"发货撒豆腐脑is的年费是的修改你不是是都干什么不羁的风没办法更好发生的擦是否电风扇" font:DDQFont(16.0) textColor:self.defaultBlackColor];
    self.review_titleLabel.textAlignment = NSTextAlignmentLeft;
    
    self.review_timeLabel = [UILabel labelChangeText:@"表单是烦恼歌查水电费你说的采访时东方红是南京东方跨年开个会比较大范甘迪" font:DDQFont(13.0) textColor:self.defaultGrayColor];
    
    self.review_addressLabel = [UILabel labelChangeText:@"发过火打匹配可以不到付可以回家不放过好几遍儿童教育日特码" font:DDQFont(13.0) textColor:self.defaultGrayColor];
    self.review_addressLabel.textAlignment = NSTextAlignmentLeft;

    self.review_separator = [UIView viewChangeBackgroundColor:self.defaultSeparatorColor];
    
    self.review_passButton = [UIButton buttonChangeFont:DDQFont(14.0) titleColor:self.defaultOrangeColor image:nil backgroundImage:nil title:@"审核通过" attributeTitle:nil target:self sel:@selector(review_didSelectPass)];
    [self.review_passButton view_hanlderLayerWithRadius:3.0 borderWidth:1.0 borderColor:self.defaultOrangeColor];
    
    self.review_rejectButton = [UIButton buttonChangeFont:DDQFont(14.0) titleColor:kSetColor(136.0, 136.0, 136.0, 1.0) image:nil backgroundImage:nil title:@"审核驳回" attributeTitle:nil target:self sel:@selector(review_didSelectReject)];
    [self.review_rejectButton view_hanlderLayerWithRadius:3.0 borderWidth:1.0 borderColor:kSetColor(136.0, 136.0, 136.0, 1.0)];

    [self.contentView view_configSubviews:@[self.review_titleLabel, self.review_timeLabel, self.review_addressLabel, self.review_separator, self.review_passButton, self.review_rejectButton]];
    
}

- (void)cell_updateContentSubviewsFrame {
    
    DDQManagerReviewCellStyle style = [self.class reviewCellStyle];
    
    CGSize maxSize = CGSizeZero;
    if (style != DDQManagerReviewCellStyleRegister) {
        
        autoLayout(self.review_imageView).ddq_leading(self.contentView.leading, self.cell_defaultLeftMargin).ddq_top(self.contentView.top, 8.0).ddq_size(CGSizeMake(115.0 * self.cell_widthRate, 80.0 * self.cell_widthRate));
        maxSize = CGSizeMake(self.contentView.width - self.review_imageView.frameMaxX - 8.0 - self.cell_defaultLeftMargin, 40.0);
        autoLayout(self.review_titleLabel).ddq_leading(self.review_imageView.trailing, 8.0).ddq_top(self.review_imageView.top, 0.0).ddq_estimateSize(maxSize);

    } else {
        
        maxSize = CGSizeMake(self.contentView.width  - self.cell_defaultLeftMargin * 2.0, 40.0);
        autoLayout(self.review_titleLabel).ddq_leading(self.contentView.leading, self.cell_defaultLeftMargin).ddq_top(self.contentView.top, 12.0 * self.cell_widthRate).ddq_estimateSize(maxSize);

    }
    
    autoLayout(self.review_timeLabel).ddq_leading(self.review_titleLabel.leading, 0.0).ddq_top(self.review_titleLabel.bottom, 8.0 * self.cell_widthRate).ddq_estimateSize(CGSizeMake(maxSize.width, 15.0));
    
    autoLayout(self.review_addressLabel).ddq_leading(self.review_timeLabel.leading, 0.0).ddq_top(self.review_timeLabel.bottom, 10.0 * self.cell_widthRate).ddq_estimateSize(CGSizeMake(maxSize.width, 35.0));
    
    UIView *view = (self.review_addressLabel.frameMaxY > self.review_imageView.frameMaxY) ? self.review_addressLabel : self.review_imageView;
    autoLayout(self.review_separator).ddq_leading(self.contentView.leading, 0.0).ddq_top(view.bottom, 12.0 * self.cell_widthRate).ddq_size(CGSizeMake(self.contentView.width, 1.0));
    
    CGSize buttonSize = CGSizeMake(78.0, 28.0);
    autoLayout(self.review_passButton).ddq_trailing(self.contentView.trailing, self.cell_defaultLeftMargin).ddq_top(self.review_separator.bottom, 8.0 * self.cell_widthRate).ddq_size(buttonSize);
    
    autoLayout(self.review_rejectButton).ddq_trailing(self.review_passButton.leading, 10.0 * self.cell_widthRate).ddq_centerY(self.review_passButton.centerY, 0.0).ddq_size(buttonSize);
    
    [super cell_updateContentSubviewsFrame];
    
}

- (UIView *)cell_layoutBottomControl {
    
    return self.review_passButton;
    
}

- (CGFloat)cell_bottomMargin {
    
    return 8.0 * self.cell_widthRate;
    
}

+ (DDQManagerReviewCellStyle)reviewCellStyle {
    
    return DDQManagerReviewCellStyleRegister;
    
}

/**
 点击审核通过
 */
- (void)review_didSelectPass {
    
    
}

/**
 点击审核驳回
 */
- (void)review_didSelectReject {
    
    
}

@end
