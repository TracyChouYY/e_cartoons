//
//  DDQIssueFirstSectionCell.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/3.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQIssueFirstSectionCell.h"

#import "DDQContentImageItem.h"

@interface DDQIssueFirstSectionCell () <UICollectionViewDelegate, UICollectionViewDataSource, UITextViewDelegate, DDQContentImageItemDelegate>

@property (nonatomic, strong) UITextField *first_titleField;
@property (nonatomic, strong) UITextView *first_inputTextView;
@property (nonatomic, strong) UICollectionView *first_collectionView;
@property (nonatomic, strong) DDQButton *first_locationButton;
@property (nonatomic, strong) UILabel *first_placeholderLabel;
@property (nonatomic, strong) UIView *first_separator;

@property (nonatomic, strong) UITextView *first_otherTextView;
@property (nonatomic, strong) UILabel *first_otherPlaceholderLabel;
@property (nonatomic, strong) UIView *first_otherSeparator;

@property (nonatomic, strong) NSMutableArray *first_imageDataSource;
@property (nonatomic, strong) NSIndexPath *first_deSelectIndexPath;

@property (nonatomic, assign) DDQIssueFirstSectionCellStyle first_cellStyle;

@end

@implementation DDQIssueFirstSectionCell

- (void)updateConstraints {
    
    [super updateConstraints];
    
    //为什么这两个label用mas呢？
    //首先这两个label不会对整体布局产生什么影响。其次，为什么我重新布局没有用呢？
    [self.first_placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.first_inputTextView.mas_left).offset(5.0);
        make.top.equalTo(self.first_inputTextView.mas_top).offset(8.0);
        
    }];
    
    [self.first_otherPlaceholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.first_otherTextView.mas_left).offset(5.0);
        make.top.equalTo(self.first_otherTextView.mas_top).offset(8.0);
    }];
}

- (void)cell_contentViewSubviewsConfig {
    
    [super cell_contentViewSubviewsConfig];
    
    self.first_titleField = [UITextField fieldChangeFont:DDQFont(14.0) textColor:[UIColor blackColor] placeholder:nil attributePlaceholder:nil];
    
    self.first_inputTextView = [[UITextView alloc] initWithFrame:CGRectZero];
    self.first_inputTextView.delegate = self;
    
    self.first_placeholderLabel = [UILabel labelChangeText:@" " font:DDQFont(14.0) textColor:kSetColor(203.0, 203.0, 203.0, 1.0)];
    
    self.first_separator = [UIView viewChangeBackgroundColor:self.defaultSeparatorColor];
    
    self.first_otherTextView = [[UITextView alloc] initWithFrame:CGRectZero];
    self.first_otherTextView.delegate = self;
    
    self.first_otherPlaceholderLabel = [UILabel labelChangeText:@" " font:DDQFont(14.0) textColor:kSetColor(203.0, 203.0, 203.0, 1.0)];
    
    self.first_otherSeparator = [UIView viewChangeBackgroundColor:self.defaultSeparatorColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0.0, 5.0, 0.0, self.cell_defaultLeftMargin);
    layout.minimumLineSpacing = 5.0;
    layout.minimumInteritemSpacing = 15.0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(90.0, 90.0);
    self.first_collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.first_collectionView.delegate = self;
    self.first_collectionView.dataSource = self;
    self.first_collectionView.backgroundColor = [UIColor whiteColor];
    [self.first_collectionView registerClass:[DDQContentImageItem class] forCellWithReuseIdentifier:@"item"];
    self.first_collectionView.showsHorizontalScrollIndicator = NO;
    
    self.first_locationButton = [DDQButton ddq_customButtonWithStyle:DDQButtonStyleLeftImageView fontSize:12.0 title:@"请选择" image:kSetImage(@"base_location") titleColor:self.defaultBlackColor target:self selector:@selector(first_didSelectLocationWithButton:)];
    self.first_locationButton.control_space = 5.0;
    
    [self.contentView view_configSubviews:@[self.first_titleField, self.first_inputTextView, self.first_placeholderLabel, self.first_collectionView, self.first_separator, self.first_locationButton, self.first_otherTextView, self.first_otherPlaceholderLabel, self.first_otherSeparator]];
    
    self.first_imageDataSource = [NSMutableArray arrayWithCapacity:5];
    
}

- (void)cell_updateContentSubviewsFrame {
    
    autoLayout(self.first_titleField).ddq_leading(self.contentView.leading, self.cell_defaultLeftMargin).ddq_top(self.contentView.top, 0.0).ddq_size(CGSizeMake(self.contentView.width - self.cell_defaultLeftMargin, 44.0));
    
    autoLayout(self.first_separator).ddq_leading(self.first_titleField.leading, 0.0).ddq_top(self.first_titleField.bottom, 0.0).ddq_size(CGSizeMake(self.first_titleField.width, 1.0));
    
    autoLayout(self.first_inputTextView).ddq_leading(self.first_separator.leading, -5.0).ddq_top(self.first_separator.bottom, 0.0).ddq_size(CGSizeMake(self.first_separator.width, 160.0));
    
    autoLayout(self.first_otherSeparator).ddq_leading(self.first_separator.leading, 0.0).ddq_top(self.first_inputTextView.bottom, 5.0).ddq_size(self.first_separator.size);
    
    autoLayout(self.first_otherTextView).ddq_leading(self.first_otherSeparator.leading, -5.0).ddq_top(self.first_otherSeparator.bottom, 0.0).ddq_size(CGSizeMake(self.first_otherSeparator.width, 160.0));
    
    autoLayout(self.first_collectionView).ddq_leading(self.contentView.leading, 0.0).ddq_top(self.first_otherTextView.bottom, 0.0).ddq_size(CGSizeMake(self.contentView.width, 85.0));

    autoLayout(self.first_locationButton).ddq_leading(self.first_titleField.leading, 0.0).ddq_top(self.first_collectionView.bottom, 25.0 * self.cell_widthRate).ddq_fitSize();
    
    [super cell_updateContentSubviewsFrame];
    
}

- (void)cell_updateDataWithModel:(__kindof DDQBaseCellModel *)model {
    
    DDQIssueFirstSectionModel *firstModel = model;
    
    self.first_imageDataSource = [NSMutableArray arrayWithArray:firstModel.images];
    [self content_handleImageDataSource];

    if (self.first_cellStyle == DDQIssueFirstSectionCellStyleBase) {
        
        self.first_titleField.text = firstModel.base_name;
        self.first_inputTextView.text = firstModel.base_scenic;
        self.first_otherTextView.text = firstModel.base_notice;
        self.first_position = firstModel.base_address;

    } else {
        
        self.first_titleField.text = firstModel.activity_name;
        self.first_inputTextView.text = firstModel.activity_describe;
        self.first_otherTextView.text = firstModel.activity_description;
        self.first_position = firstModel.activity_address;

    }
    [self textViewDidEndEditing:self.first_inputTextView];
    [self textViewDidEndEditing:self.first_otherTextView];
    [self.first_collectionView reloadData];
    
    [super cell_updateDataWithModel:model];
    
}

- (UIView *)cell_layoutBottomControl {
    
    return self.first_locationButton;
    
}

- (CGFloat)cell_bottomMargin {
    
    return 20.0 * self.cell_widthRate;
    
}

- (void)first_updateCellStyle:(DDQIssueFirstSectionCellStyle)style {
    
    self.first_cellStyle = style;
    
    NSString *title = @"标题 基地名称";
    NSString *placeholder1 = @"景区特色";
    NSString *placeholder2 = @"门票须知";
    if (style == DDQIssueFirstSectionCellStyleActivity) {
        
        title = @"标题 活动主题";
        placeholder1 = @"活动介绍";
        placeholder2 = @"费用说明";

    }
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:DDQFont(14.0), NSForegroundColorAttributeName:kSetColor(203.0, 203.0, 203.0, 1.0)}];
    self.first_titleField.attributedPlaceholder = attribute;
    self.first_placeholderLabel.text = placeholder1;
    self.first_otherPlaceholderLabel.text = placeholder2;
    [self setNeedsUpdateConstraints];
    //这样为什么不行呢？
//    autoLayout(self.first_placeholderLabel).ddq_leading(self.first_inputTextView.leading, 5.0).ddq_top(self.first_inputTextView.top, 8.0).ddq_fitSize();
//    autoLayout(self.first_otherPlaceholderLabel).ddq_leading(self.first_otherTextView.leading, 5.0).ddq_top(self.first_otherTextView.top, 8.0).ddq_fitSize();

}

/**
 点击位置按钮
 */
- (void)first_didSelectLocationWithButton:(UIButton *)button {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(first_didSelectLocationWithCell:)]) {
        
        [self.delegate first_didSelectLocationWithCell:self];
        
    }
}

- (void)setFirst_position:(NSString *)first_position {
    
    _first_position = first_position;
    
    NSString *title = @"";
    if (_first_position.length == 0) {
        
        title = @"请选择";
        
    } else {
        
        title = _first_position;
        
    }
    [self.first_locationButton setTitle:title forState:UIControlStateNormal];
    autoLayout(self.first_locationButton).ddq_leading(self.first_titleField.leading, 0.0).ddq_top(self.first_collectionView.bottom, 25.0 * self.cell_widthRate).ddq_fitSize();

}

- (void)first_replaceImage:(UIImage *)image index:(NSInteger)index {
    
    [self.first_imageDataSource replaceObjectAtIndex:index withObject:image];
    [self content_handleImageDataSource];
    [self.first_collectionView reloadData];

}

- (void)content_handleImageDataSource {
    
    //先看看有没有默认图片
    BOOL haveDefault = NO;
    for (id object in self.first_imageDataSource) {
        
        if (![object isKindOfClass:[UIImage class]]) {
            
            continue;
            
        }
        
        UIImage *image = object;
        if (image.isDefault) {
            
            haveDefault = YES;
            
        }
    }
    
    if (!haveDefault) {//没有默认图片
        
        if (self.first_imageDataSource.count < 5) {//图片没有超过5张
            
            UIImage *defaultImage = kSetImage(@"issue_placeholder");
            defaultImage.isDefault = YES;
            [self.first_imageDataSource addObject:defaultImage];
            
        }
    }
}

- (NSArray *)first_changeImages {
    
    return self.first_imageDataSource.copy;
    
}

- (NSString *)first_title {
    
    return self.first_titleField.text;
    
}

- (NSString *)first_content1 {
    
    return self.first_inputTextView.text;
    
}

- (NSString *)first_content2 {
    
    return self.first_otherTextView.text;
    
}

#pragma mark - TextView Delegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    UILabel *label = (textView == self.first_otherTextView) ? self.first_otherPlaceholderLabel : self.first_placeholderLabel;
    label.hidden = YES;

}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    UILabel *label = (textView == self.first_otherTextView) ? self.first_otherPlaceholderLabel : self.first_placeholderLabel;
    label.hidden = (textView.text.length == 0) ? NO : YES;

}

#pragma mark - CollectionView Delegate && DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.first_imageDataSource.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DDQContentImageItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    
    item.delegate = self;
    id object = self.first_imageDataSource[indexPath.row];
    if ([object isKindOfClass:[UIImage class]]) {
        
        [item content_updateImage:object];
 
    } else {
        
        DDQIssueFirstImageModel *imageModel = object;
        [item content_updateImageUrl:imageModel.image_url];

    }
    
    return item;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(first_didSelectPickerImageWithCell:selectIndexPath:deselectIndexPath:defaultImage:)]) {
        
        BOOL isDefault = NO;
        id object = self.first_imageDataSource[indexPath.row];
        if ([object isKindOfClass:[UIImage class]]) {
            
            UIImage *image = object;
            isDefault = image.isDefault;
            
        }
        [self.delegate first_didSelectPickerImageWithCell:self selectIndexPath:indexPath deselectIndexPath:self.first_deSelectIndexPath defaultImage:isDefault];
        
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.first_deSelectIndexPath = indexPath;
    
}

#pragma mark - Custom Cell Delegate
- (void)content_didSelectCloseWithCell:(DDQContentImageItem *)item {
    
    NSIndexPath *indexPath = [self.first_collectionView indexPathForCell:item];
 
    [self.first_imageDataSource removeObjectAtIndex:indexPath.row];

    [self content_handleImageDataSource];
    
    [self.first_collectionView reloadData];

    if (self.delegate && [self.delegate respondsToSelector:@selector(first_didSelectCloseImageWithIndexPath:)]) {
        
        [self.delegate first_didSelectCloseImageWithIndexPath:indexPath];
        
    }
}

@end

@implementation DDQIssueFirstSectionModel

@end

@implementation DDQIssueFirstImageModel

@end
