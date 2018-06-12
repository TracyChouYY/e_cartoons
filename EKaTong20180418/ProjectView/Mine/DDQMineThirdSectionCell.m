//
//  DDQMineThirdSectionCell.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/23.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQMineThirdSectionCell.h"

@interface DDQMineThirdSectionCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIView *third_contentView;
@property (nonatomic, strong) UILabel *third_moreLabel;
@property (nonatomic, strong) UICollectionView *third_collectionView;
@property (nonatomic, strong) NSMutableArray<DDQMineFunctionModel *> *third_dataSource;

@end

@implementation DDQMineThirdSectionCell

- (void)cell_contentViewSubviewsConfig {
    
    [super cell_contentViewSubviewsConfig];
    
    self.third_contentView = [UIView viewChangeBackgroundColor:[UIColor whiteColor]];
    self.third_contentView.layer.shadowOpacity = 1.0;
    self.third_contentView.layer.shadowRadius = 3.0;
    self.third_contentView.layer.shadowOffset = CGSizeMake(0.0, 10.0);
    self.third_contentView.layer.shadowColor = kSetColor(240.0, 240.0, 240.0, 1.0).CGColor;
    [self.contentView addSubview:self.third_contentView];
    
    self.third_moreLabel = [UILabel labelChangeText:@"更多功能" font:DDQFont(13.0) textColor:kSetColor(34.0, 34.0, 34.0, 1.0)];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0.0;
    layout.minimumInteritemSpacing = 0.0;
    self.third_collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.third_contentView view_configSubviews:@[self.third_moreLabel, self.third_collectionView]];
    
    self.third_collectionView.dataSource = self;
    self.third_collectionView.delegate = self;
    [self.third_collectionView registerClass:[DDQMineFunctionItem class] forCellWithReuseIdentifier:@"item"];
    self.third_collectionView.backgroundColor = [UIColor whiteColor];
    self.third_collectionView.scrollEnabled = NO;
    
    DDQMineThirdSectionCellStyle style = [self.class mineThirdSectionStyle];
    NSArray<NSDictionary *> *dataSource = [NSArray array];
    NSString *imageKey = @"image";
    NSString *titleKey = @"title";
    NSString *operationKey = @"pOperation";
    if (style == DDQMineThirdSectionCellStylePersonal) {
        
        dataSource = @[@{imageKey:@"mine_coupon", titleKey:@"优惠券", operationKey:@(DDQMineThirdSection_Personal_Operation_Coupon)},
                       @{imageKey:@"mine_point", titleKey:@"我的积分", operationKey:@(DDQMineThirdSection_Personal_Operation_Point)},
                       @{imageKey:@"mine_cer", titleKey:@"门票凭证", operationKey:@(DDQMineThirdSection_Personal_Operation_Voucher)},
                       @{imageKey:@"mine_suggest", titleKey:@"投诉建议", operationKey:@(DDQMineThirdSection_Personal_Operation_Suggestion)},
                       @{imageKey:@"mine_collection", titleKey:@"我的收藏", operationKey:@(DDQMineThirdSection_Personal_Operation_Collection)},
                       @{imageKey:@"mine_question", titleKey:@"常见问题"},
                       @{imageKey:@"mine_scan", titleKey:@"扫一扫"}
                       ];
        
    } else if (style == DDQMineThirdSectionCellStyleManager) {
        
        operationKey = @"mOperation";
        dataSource = @[@{imageKey:@"mine_base", titleKey:@"基地审核", operationKey:@(DDQMineThirdSection_Manager_Operation_Base)},
                       @{imageKey:@"mine_activity", titleKey:@"活动审核", operationKey:@(DDQMineThirdSection_Manager_Operation_Activity)},
                       @{imageKey:@"mine_check", titleKey:@"注册审核", operationKey:@(DDQMineThirdSection_Manager_Operation_Register)}
                       ];
        
    } else if (style == DDQMineThirdSectionCellStyleBase) {
        
        operationKey = @"bOperation";
        dataSource = @[@{imageKey:@"mine_base", titleKey:@"基地管理", operationKey:@(DDQMineThirdSection_Base_Operation_Base)},
                       @{imageKey:@"mine_activity", titleKey:@"活动管理", operationKey:@(DDQMineThirdSection_Base_Operation_Activity)},
                       @{imageKey:@"mine_check", titleKey:@"验票"},
                       @{imageKey:@"mine_detail", titleKey:@"门票明细"},
                       @{imageKey:@"mine_activityDetail", titleKey:@"活动明细"},
                       @{imageKey:@"mine_scan", titleKey:@"二维码"},
                       ];
    }
    self.third_dataSource = [NSMutableArray arrayWithCapacity:dataSource.count];
    for (NSDictionary *dic in dataSource) {
        
        [self.third_dataSource addObject:[DDQMineFunctionModel mj_objectWithKeyValues:dic]];
        
    }
}

- (void)cell_updateContentSubviewsFrame {
    
    DDQViewVHMargin margin = DDQViewVHMarginMaker(0.0, 10.0 * self.cell_widthRate);
    autoLayout(self.third_contentView).ddq_leading(self.contentView.leading, margin.horMargin).ddq_top(self.contentView.top, 0.0).ddq_width(self.contentView.width - margin.horMargin * 2.0);
    
    DDQViewVHMargin subMargin = DDQViewVHMarginMaker(12.0 * self.cell_widthRate, 12.0 * self.cell_widthRate);
    autoLayout(self.third_moreLabel).ddq_leading(self.third_contentView.leading, subMargin.horMargin).ddq_top(self.third_contentView.top, subMargin.verMargin).ddq_fitSize();

    NSInteger number = 0;
    if (self.third_dataSource.count % 3 == 0) {
        
        number = self.third_dataSource.count / 3;
        
    } else {
        
        number = self.third_dataSource.count / 3;
        number++;
        
    }
    
    CGFloat collectionLeft = 15.0 * self.cell_widthRate;
    CGFloat collectionMargin = collectionLeft * 2.0;
    CGFloat itemWH = (self.third_contentView.width - collectionMargin) / 3.0;
    autoLayout(self.third_collectionView).ddq_leading(self.third_contentView.leading, collectionLeft).ddq_top(self.third_moreLabel.bottom, 0.0).ddq_size(CGSizeMake(self.third_contentView.width - collectionMargin, itemWH * number));
    
    autoLayout(self.third_contentView).ddq_height(self.third_collectionView.frameMaxY);

    [super cell_updateContentSubviewsFrame];
    
}

- (UIView *)cell_layoutBottomControl {
    
    return self.third_contentView;
    
}

- (CGFloat)cell_bottomMargin {
    
    return self.third_contentView.layer.shadowOffset.height;
    
}

+ (DDQMineThirdSectionCellStyle)mineThirdSectionStyle {
    
    return DDQMineThirdSectionCellStylePersonal;
    
}

#pragma mark - CollectionView Cell Delegate && DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.third_dataSource.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DDQMineFunctionItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    item.mineModel = self.third_dataSource[indexPath.row];
    return item;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat itemWidth = collectionView.width / 3.0;
    return CGSizeMake(itemWidth, itemWidth);
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DDQMineFunctionModel *model = self.third_dataSource[indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(third_personal_didSelectOperation:)]) {
        
        [self.delegate third_personal_didSelectOperation:model.pOperation];
        
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(third_manager_didSelectOperation:)]) {
        
        [self.delegate third_manager_didSelectOperation:model.mOperation];
        
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(third_base_didSelectOperation:)]) {
        
        [self.delegate third_base_didSelectOperation:model.bOperation];
        
    }
}

@end

@interface DDQMineFunctionItem ()

@property (nonatomic, strong) UIImageView *item_imageView;
@property (nonatomic, strong) UILabel *item_label;

@end

@implementation DDQMineFunctionItem

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    self.item_imageView = [UIImageView imageView];
    
    self.item_label = [UILabel labelChangeText:@"" font:DDQFont(15.0) textColor:kSetColor(33.0, 33.0, 33.0, 1.0)];
    
    [self.contentView view_configSubviews:@[self.item_label, self.item_imageView]];
    
    return self;
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.item_imageView.auto_layout.ddq_centerX(self.contentView.centerX, 0.0).ddq_bottom(self.contentView.centerY, 0.0).ddq_fitSize();
    
    self.item_label.auto_layout.ddq_centerX(self.contentView.centerX, 0.0).ddq_top(self.contentView.centerY, 10.0).ddq_fitSize();
    
}

- (void)setMineModel:(DDQMineFunctionModel *)mineModel {
    
    _mineModel = mineModel;
    
    self.item_imageView.image = kSetImage(mineModel.image);
    
    self.item_label.text = mineModel.title;
    
    [self setNeedsLayout];
    
}

@end

@implementation DDQMineFunctionModel

@end
