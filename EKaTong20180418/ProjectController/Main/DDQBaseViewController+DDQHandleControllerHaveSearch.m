//
//  DDQBaseViewController+DDQHandleControllerHaveSearch.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/8.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBaseViewController+DDQHandleControllerHaveSearch.h"

#import "DDQBaseSearchController.h"

@interface DDQBaseViewController ()


@end

@implementation DDQBaseViewController (DDQHandleControllerHaveSearch)

- (void)handle_navigationTitleSearchButtonwWithType:(DDQSearchContentType)type {
        
    NSString *title = @"";
    if (type == DDQSearchContentTypeBase) {
        
        title = @"搜索基地";
        
    } else if (type == DDQSearchContentTypeActivity) {
        
        title = @"搜索活动";
    }
    UIButton *titleButton = [UIButton buttonChangeFont:DDQFont(15.0) titleColor:kSetColor(136.0, 136.0, 136.0, 1.0) image:kSetImage(@"base_search") backgroundImage:nil title:title attributeTitle:nil target:self sel:@selector(handle_didSelectSearchPlaceholder)];
    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 12.0);
    titleButton.backgroundColor = kSetColor(239.0, 239.0, 239.0, 1.0);
    
    [self handle_navigationTitleViewLayoutWithView:titleButton];

}

/**
 处理NavigationItem的布局
 */
- (CGSize)handle_navigationTitleViewLayoutWithView:(UIView *)view {
    
    NSMutableArray *items = self.navigationItem.leftBarButtonItems.mutableCopy;
    CGFloat viewWidth = self.base_navigationController.navigationBar.width - 20.0 * self.base_widthRate;
    for (UIBarButtonItem *item in items) {
        
        UIView *view = item.customView;
        //ViewDidLoad中不好计算customView相对于NavigationBar的frame
        CGRect rect = [view convertRect:view.frame fromView:self.base_navigationController.navigationBar];
        //LeftItem默认离左边15距离
        viewWidth = self.base_navigationController.navigationBar.width - (CGRectGetMaxX(rect) + 15.0 + 16.0 + 15.0);
        
    }
    
    view.frame = CGRectMake(0.0, 0.0, viewWidth, 36.0);
    view.layer.cornerRadius = view.height * 0.5;
    
    [items addObject:[[UIBarButtonItem alloc] initWithCustomView:view]];
    self.navigationItem.leftBarButtonItems = items.mutableCopy;

    return CGSizeMake(viewWidth, 36.0);
    
}

/**
 点击基地搜索
 */
- (void)handle_didSelectSearchPlaceholder {
    
    [self base_handleInitializeWithControllerClass:[DDQBaseSearchController class] fromNib:NO title:nil animation:NO propertys:nil];
    
}

- (void)handle_navigationTitleWithSearchViewDelegate:(id<DDQSearchBarDelegate>)delegate rightItemSelector:(nonnull SEL)selector {
    
    DDQSearchBar *searchBar = [DDQSearchBar searchBarWithStyle:DDQBarUnlessEditingStyleAlignmentLeft];
    searchBar.backgroundColor = kSetColor(239.0, 239.0, 239.0, 1.0);
    searchBar.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索基地\\活动" attributes:@{NSFontAttributeName:DDQFont(15.0), NSForegroundColorAttributeName:kSetColor(136.0, 136.0, 136.0, 1.0)}];
    UIImageView *imageView = (UIImageView *)searchBar.leftView;
    imageView.image = kSetImage(@"base_search");
    searchBar.searchDelegate = delegate;
    CGSize maxSize = [self handle_navigationTitleViewLayoutWithView:searchBar];

    [self foundation_setRightItemWithStyle:DDQFoundationBarButtonText Content:@"取消" Selector:selector];
    UIButton *button = self.navigationItem.rightBarButtonItem.customView;
    [button setTitleColor:kSetColor(102.0, 102.0, 102.0, 1.0) forState:UIControlStateNormal];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = DDQFont(15.0);
    //对于这个searchBar我必须写约束，不然他会随输入的内容而撑大，导致取消按钮消失
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(maxSize.width - button.width);
        make.height.mas_equalTo(maxSize.height);
        
    }];
}

@end
