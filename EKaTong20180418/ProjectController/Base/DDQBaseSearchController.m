//
//  DDQBaseSearchController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/4.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQBaseSearchController.h"

#import "DDQSearchResultView.h"
#import "DDQSearchNavigationBar.h"
#import "DDQBaseViewController+DDQHandleControllerHaveSearch.h"

@interface DDQBaseSearchController () <DDQSearchBarDelegate>

@property (nonatomic, strong) DDQSearchResultView *search_resultView;


@end

@implementation DDQBaseSearchController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.base_handler handler_deleteCacheDataWithPathType:DDQProjectHandlerPathTypeProduct];
    
    //ResultView
    self.search_resultView = [[DDQSearchResultView alloc] initResultViewWithData:[self.base_handler handler_decodeSearchDataWithPathType:DDQProjectHandlerPathTypeProduct]];
    [self.view addSubview:self.search_resultView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //NavigationItem
    [self handle_navigationTitleWithSearchViewDelegate:self rightItemSelector:@selector(search_didSelectRightItem)];
    
}

/**
 点击右边的取消按钮
 */
- (void)search_didSelectRightItem {
    
    [self.view endEditing:YES];
    
}

#pragma mark - Custom Search Bar Delegate
- (void)searchBar_endEditingWithSearchBar:(DDQSearchBar *)bar {
    
    if (bar.text.length > 0) {
        
        [self.base_handler handler_encodeSearchDataWithText:bar.text pathType:DDQProjectHandlerPathTypeProduct operationType:DDQProjectHandlerOperationTypeInsert];
        self.search_resultView.result_dataSource = [self.base_handler handler_decodeSearchDataWithPathType:DDQProjectHandlerPathTypeProduct];
        
    }
}

@end
