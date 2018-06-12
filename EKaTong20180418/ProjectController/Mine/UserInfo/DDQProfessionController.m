//
//  DDQProfessionController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/4/25.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQProfessionController.h"

@interface DDQProfessionController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *profession_collectionView;
@property (nonatomic, strong) NSMutableArray<NSString *> *profession_dataSource;
@property (nonatomic, copy) DDQSelectProfession profession;

@end

@implementation DDQProfessionController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //DataSource
    self.profession_dataSource = [NSMutableArray array];
    
    //Subviews
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 30.0 * self.base_widthRate;
    layout.minimumInteritemSpacing = 35.0 * self.base_widthRate;
    layout.sectionInset = UIEdgeInsetsMake(35.0 * self.base_widthRate, 20.0 * self.base_widthRate, 35.0 * self.base_widthRate, 20.0 * self.base_widthRate);
    
    self.profession_collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.view addSubview:self.profession_collectionView];
    self.profession_collectionView.view_autoLayout = YES;
    self.profession_collectionView.delegate = self;
    self.profession_collectionView.dataSource = self;
    self.profession_collectionView.backgroundColor = [UIColor clearColor];
    [self.profession_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    
    //NetRequest
    [self pro_netRequest];
    
}

- (NSString *)base_navigationTitle {
    
    return @"职业";
    
}

/**
 网络请求
 */
- (void)pro_netRequest {
    
    DDQWeakObject(self);
    NSString *requestUrl = [self.base_url stringByAppendingString:@"UserApi/usertype"];
    [self foundation_processNetPOSTRequestWithUrl:requestUrl Param:@{@"uid":self.base_userID} WhenHUDHidden:^BOOL(id  _Nullable response, int code) {
        
        if (code == 1) {
            
            NSArray *listArr = [weakObjc base_handleRequestDataIfLegal:[response valueForKey:@"list"] targetClass:[NSArray class]];
            for (NSDictionary *dic in listArr) {
                
                [weakObjc.profession_dataSource addObject:dic[@"name"]];
            }
            
            [weakObjc.profession_collectionView reloadData];
            return NO;
        }
        return YES;
        
    }];
}

- (void)profession_didSelectProfession:(DDQSelectProfession)pro {
    
    if (pro) {
        
        self.profession = pro;
        
    }
}

#pragma mark - CollectionView Delegate && DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.profession_dataSource.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    
//    cell.contentView.layer.cornerRadius = cell.height * 0.5;
//    cell.contentView.backgroundColor = [UIColor blueColor];
    UILabel *titleLabel = [cell.contentView viewWithTag:1];
    if (!titleLabel) {
        
        titleLabel = [UILabel labelChangeText:@"" font:DDQFont(13.0) textColor:kSetColor(35.0, 35.0, 35.0, 1.0)];
        titleLabel.tag = 1;
        [cell.contentView addSubview:titleLabel];
        
    }
    titleLabel.text = self.profession_dataSource[indexPath.row];
    [titleLabel view_hanlderLayerWithRadius:cell.height * 0.5 borderWidth:1.0 borderColor:titleLabel.textColor];
    
    [titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(UIEdgeInsetsZero);
        
    }];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    UILabel *label = [cell.contentView viewWithTag:1];
//    label.backgroundColor = collectionView.defaultBlueColor;
//    label.textColor = [UIColor whiteColor];
//    label.layer.borderWidth = 0.0;

    if (self.profession) {
        
        self.profession(self.profession_dataSource[indexPath.row]);
        [self base_handlePopController];
        
    }
}

//- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
//
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    UILabel *label = [cell.contentView viewWithTag:1];
//    label.backgroundColor = [UIColor whiteColor];
//    label.textColor = [UIColor colorWithCGColor:label.layer.borderColor];
//    label.layer.borderWidth = 1.0;
//
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionViewLayout;
    CGFloat itemWidth = (collectionView.width - layout.minimumInteritemSpacing * 2.0 - layout.sectionInset.left - layout.sectionInset.right) / 3.0;
    return CGSizeMake(itemWidth, 35.0 * self.base_widthRate);
    
}

@end
