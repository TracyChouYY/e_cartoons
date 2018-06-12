//
//  DDQWriteSecondSectionCell.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/2.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQWriteSecondSectionCell.h"

@interface DDQWriteSecondSectionCell () <UICollectionViewDelegate, UICollectionViewDataSource, UITextViewDelegate>

@property (nonatomic, strong) UILabel *second_titleLabel;
@property (nonatomic, strong) UITextView *second_inputView;
@property (nonatomic, strong) UICollectionView *second_imageCollectionView;

@end

@implementation DDQWriteSecondSectionCell

- (void)cell_contentViewSubviewsConfig {
    
    [super cell_contentViewSubviewsConfig];
    
    self.second_titleLabel = [UILabel labelChangeText:@"写出您的体验心得" font:DDQFont(14.0) textColor:kSetColor(184.0, 184.0, 184.0, 1.0)];
    
    self.second_inputView = [[UITextView alloc] initWithFrame:CGRectZero];
    self.second_inputView.delegate = self;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0.0;
    layout.minimumInteritemSpacing = 20.0 * self.cell_widthRate;
    layout.sectionInset = UIEdgeInsetsMake(0.0, self.cell_defaultLeftMargin, 0.0, self.cell_defaultLeftMargin);
    layout.itemSize = CGSizeMake(60.0 * self.cell_widthRate, 60.0 * self.cell_widthRate);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.second_imageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.second_imageCollectionView.delegate = self;
    self.second_imageCollectionView.dataSource = self;
    [self.second_imageCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    self.second_imageCollectionView.backgroundColor = [UIColor clearColor];
    self.second_imageCollectionView.showsHorizontalScrollIndicator = NO;
    
    [self.contentView view_configSubviews:@[self.second_inputView, self.second_titleLabel, self.second_imageCollectionView]];
    
}

- (void)cell_updateContentSubviewsFrame {
    
    autoLayout(self.second_inputView).ddq_leading(self.contentView.leading, self.cell_defaultLeftMargin).ddq_top(self.contentView.top, 8.0).ddq_size(CGSizeMake(self.contentView.width - self.cell_defaultLeftMargin * 2.0, 130.0 * self.cell_widthRate));
    
    autoLayout(self.second_titleLabel).ddq_leading(self.second_inputView.leading, 5.0).ddq_top(self.second_inputView.top, 6.0).ddq_fitSize();
    
    autoLayout(self.second_imageCollectionView).ddq_leading(self.second_inputView.leading, 0.0).ddq_top(self.second_inputView.bottom, 10.0 * self.cell_widthRate).ddq_size(CGSizeMake(self.second_inputView.width, 60.0 * self.cell_widthRate));
    
    [super cell_updateContentSubviewsFrame];
    
}

- (UIView *)cell_layoutBottomControl {
    
    return self.second_imageCollectionView;
    
}

- (CGFloat)cell_bottomMargin {
    
    return 10.0;
    
}

#pragma mark - TextView Delegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    self.second_titleLabel.hidden = YES;
    
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if (textView.text == 0) {
        
        self.second_titleLabel.hidden = NO;
        
    }
}

#pragma mark - collectionView Delegate && DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 1;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    
    UIImageView *imageView = [cell.contentView viewWithTag:1];
    if (!imageView) {
        
        imageView = [UIImageView imageViewChangeImage:kSetImage(@"evaluate_normal")];
        imageView.tag = 1;
        [cell.contentView addSubview:imageView];
        
    }
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        
    }];
    
    return cell;
    
}

@end
