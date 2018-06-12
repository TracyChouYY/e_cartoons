//
//  DDQMemberCenterController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/26.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQMemberCenterController.h"

#import "DDQMemberFirstSectionCell.h"

#import "DDQMemberCouponItem.h"

@interface DDQMemberCenterController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *member_collectionView;

@end

@implementation DDQMemberCenterController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //TableView
    [self base_tableViewConfig];
    
    //CollectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(6.0, 15.0 * self.base_widthRate, 6.0, 15.0 * self.base_widthRate);
    layout.minimumLineSpacing = 15.0 * self.base_widthRate;
    layout.minimumInteritemSpacing = 15.0 * self.base_widthRate;
    
    self.member_collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.member_collectionView.delegate = self;
    self.member_collectionView.dataSource = self;
    self.member_collectionView.backgroundColor = [UIColor whiteColor];
    self.member_collectionView.scrollEnabled = NO;
    [self.member_collectionView registerClass:[DDQMemberCouponItem class] forCellWithReuseIdentifier:@"item"];
        
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    NSInteger number = [self.member_collectionView numberOfItemsInSection:0];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)[self.member_collectionView collectionViewLayout];
    NSInteger row = 1;
    if (number >= 2) {
        
        if (number / 2 == 0) {
            
            row = number / 2;
            
        } else {
            
            row = number / 2;
            row++;
            
        }
    }
    self.member_collectionView.frame = CGRectMake(0.0, 0.0, self.view.width, layout.sectionInset.top + layout.sectionInset.bottom + layout.minimumLineSpacing * (row - 1) + row * 88.0 * self.base_widthRate);
    self.base_tableView.tableFooterView = self.member_collectionView;
    
}

- (NSString *)base_navigationTitle {
    
    return @"会员中心";
    
}

- (DDQBaseNavigationBarStyle)base_navigationBarStyle {
    
    return DDQBaseNavigationBarStyleMemberCenterEngross;
    
}

- (void)base_tableViewConfig {
    
    [super base_tableViewConfig];
    
    [self.base_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"footer"];
    
    DDQWeakObject(self);
    [self.base_tableView tableView_setFooterViewConfig:^__kindof UIView * _Nullable(NSInteger section, DDQFoundationTableView * _Nonnull tableView) {
        
        UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer"];
        footerView.contentView.backgroundColor = footerView.defaultViewBackgroundColor;
        
        UIButton *button = [footerView.contentView viewWithTag:1];
        if (!button) {
            
            button = [UIButton buttonChangeFont:DDQFont(13.0) titleColor:footerView.defaultBlackColor image:nil backgroundImage:nil title:@"注册卡专享" attributeTitle:nil target:nil sel:nil];
            [footerView.contentView addSubview:button];
            button.tag = 1;
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 15.0 * weakObjc.base_widthRate, 0.0, 0.0)];
            button.backgroundColor = [UIColor whiteColor];
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            
        }
        
        [button mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.mas_equalTo(UIEdgeInsetsMake(10.0 * weakObjc.base_widthRate, 0.0, 1.0, 0.0));
            
        }];

        return footerView;
        
    }];
    
    DDQBaseCellModel *model = [DDQBaseCellModel new];
    [self.base_tableView tableView_setCellConfig:^__kindof UITableViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, DDQFoundationTableView * _Nonnull tableView) {
        
        DDQMemberFirstSectionCell *firstCell = [tableView dequeueReusableCellWithIdentifier:tableView.tableView_layout.layout_cellIdentifier];
        [firstCell cell_updateDataWithModel:model];
        tableView.tableView_layout.layout_rowHeight = [DDQMemberFirstSectionCell cell_getCellHeightWithModel:model];
        return firstCell;
        
    }];
}

- (DDQFoundationTableViewLayout *)base_tableViewLayout {
    
    DDQFoundationTableViewLayout *layout = [super base_tableViewLayout];
    
    layout.layout_cellClass = [DDQMemberFirstSectionCell class];
    layout.layout_rowCount = 1;
    layout.layout_footerHeight = 60.0;
    
    return layout;
    
}

#pragma mark - CollectionView Delegate && DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 1;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DDQMemberCouponItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    return item;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionViewLayout;
    CGFloat itemW = (collectionView.width - layout.sectionInset.left - layout.sectionInset.right - layout.minimumInteritemSpacing) / 2.0;
    return CGSizeMake(itemW, 88.0 * self.base_widthRate);
    
}

@end
