//
//  DDQSearchNavigationBar.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/4.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQSearchNavigationBar.h"

@interface DDQSearchNavigationBar () <DDQSearchBarDelegate>

@property (nonatomic, strong) DDQSearchBar *search_bar;
@property (nonatomic, strong) UIButton *search_cancelButton;

@property (nonatomic, copy) DDQSearchNavigationBarEndEditing search_end;

@end

@implementation DDQSearchNavigationBar

+ (BOOL)view_needUpdateSubviewFrameWhenLayoutSubviews {
    
    return YES;
    
}

- (void)view_subviewsConfig {
    
    [super view_subviewsConfig];
    
    self.search_bar = [DDQSearchBar searchBarWithStyle:DDQBarUnlessEditingStyleAlignmentLeft];
    self.search_bar.backgroundColor = kSetColor(239.0, 239.0, 239.0, 1.0);
    self.search_bar.bar_contentSpace = 5.0 * self.view_widthRate;
    self.search_bar.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索基地/活动" attributes:@{NSFontAttributeName:DDQFont(15.0), NSForegroundColorAttributeName:kSetColor(136.0, 136.0, 136.0, 1.0)}];
    UIImageView *imageView = (UIImageView *)self.search_bar.leftView;
    imageView.image = kSetImage(@"base_search");
    self.search_bar.searchDelegate = self;
    self.search_bar.returnKeyType = UIReturnKeyDone;
    
    self.search_cancelButton = [UIButton buttonChangeFont:DDQFont(15.0) titleColor:kSetColor(102.0, 102.0, 102.0, 1.0) image:nil backgroundImage:nil title:@"取消" attributeTitle:nil target:self sel:@selector(search_didSelectCancel)];
    
    [self view_configSubviews:@[self.search_bar, self.search_cancelButton]];
    
}

- (void)view_updateContentSubviewsFrame {
    
    [super view_updateContentSubviewsFrame];
    
    autoLayout(self.search_cancelButton).ddq_trailing(self.trailing, self.view_defaultControlMargin.horMargin).ddq_centerY(self.centerY, 0.0).ddq_fitSize();
    
    autoLayout(self.search_bar).ddq_leading(self.leading, self.view_defaultControlMargin.horMargin).ddq_centerY(self.centerY, 0.0).ddq_size(CGSizeMake(self.search_cancelButton.x - 5.0 - self.view_defaultControlMargin.horMargin, self.height - 10.0));
    
}

/**
 点击“取消”
 */
- (void)search_didSelectCancel {
    
    [self.search_bar endEditing:YES];
    
}

- (void)search_becomeFirstResponder {
    
    [self.search_bar becomeFirstResponder];
    
}

- (void)search_responseWhenEndEditing:(DDQSearchNavigationBarEndEditing)end {
    
    if (end) {
        
        self.search_end = end;
        
    }
}

#pragma mark - Search Bar Delegate
- (void)searchBar_endEditing {
    
    [self.search_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    if (self.search_bar.text.length == 0) 
        return;
    
    if (self.search_end) {
        
        self.search_end(self.search_bar.text);
        
    }
}

- (void)searchBar_beginEditing {
    
    [self.search_cancelButton setTitle:@"确定" forState:UIControlStateNormal];
    
}

@end
