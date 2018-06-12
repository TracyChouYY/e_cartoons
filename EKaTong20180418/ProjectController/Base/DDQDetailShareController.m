//
//  DDQDetailShareController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/12.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQDetailShareController.h"

#import <WXApi.h>

@interface DDQDetailShareController ()

@property (nonatomic, strong) UIView *detail_contentView;

@property (nonatomic, strong) UILabel *detail_titleLabel;
@property (strong, nonatomic) DDQDetailShareView *detail_wxView;
@property (strong, nonatomic) DDQDetailShareView *detail_firendView;
@property (nonatomic, copy) DDQSelectShareType detail_type;

@end

@implementation DDQDetailShareController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];

    self.detail_contentView = [UIView viewChangeBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.detail_contentView];
    self.detail_contentView.layer.cornerRadius = 5.0;
    
    self.detail_titleLabel = [UILabel labelChangeText:@"分享到" font:DDQFont(16.0) textColor:[UIColor blackColor]];
    
    self.detail_wxView = [[DDQDetailShareView alloc] initShareViewWithType:DDQDetailShareTypeWX];
    self.detail_firendView = [[DDQDetailShareView alloc] initShareViewWithType:DDQDetailShareTypeFirend];
    
    [self.detail_contentView view_configSubviews:@[self.detail_titleLabel, self.detail_wxView, self.detail_firendView]];
    
    if (![WXApi isWXAppInstalled]) {
        
        self.detail_wxView.hidden = YES;
        self.detail_firendView.hidden = YES;
        
    }
    
    DDQWeakObject(self);
    [self.detail_wxView detail_didSelectShareView:^{
        
        if (weakObjc.detail_type) {
            
            weakObjc.detail_type(DDQDetailShareTypeWX);
            
        }
    }];
    
    [self.detail_firendView detail_didSelectShareView:^{
        
        if (weakObjc.detail_type) {
            
            weakObjc.detail_type(DDQDetailShareTypeFirend);
            
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    autoLayout(self.detail_contentView).ddq_centerX(self.view.centerX, 0.0).ddq_centerY(self.view.centerY, 0.0).ddq_size(CGSizeMake(self.view.width - 40.0 * self.base_widthRate, 150.0 * self.base_widthRate));
    
    autoLayout(self.detail_titleLabel).ddq_centerX(self.detail_contentView.centerX, 0.0).ddq_top(self.detail_contentView.top, 30.0 * self.base_widthRate).ddq_fitSize();
    
    CGFloat viewWH = self.detail_contentView.height - self.detail_titleLabel.frameMaxY;
    autoLayout(self.detail_wxView).ddq_trailing(self.detail_contentView.centerX, 5.0).ddq_top(self.detail_titleLabel.bottom, 0.0).ddq_size(CGSizeMake(viewWH, viewWH));
    
    autoLayout(self.detail_firendView).ddq_leading(self.detail_contentView.centerX, 5.0).ddq_centerY(self.detail_wxView.centerY, 0.0).ddq_size(self.detail_wxView.size);
    
}

- (void)share_didSelectShareType:(DDQSelectShareType)type {
    
    if (type) {
        
        self.detail_type = type;
        
    }
}

@end

@interface DDQDetailShareView ()

@property (nonatomic, copy) DDQSelectDetailShareView select;
@property (nonatomic, strong) UIImageView *share_imageView;
@property (nonatomic, strong) UILabel *share_label;
@property (nonatomic, assign) DDQDetailShareType share_type;

@end

@implementation DDQDetailShareView

- (instancetype)initShareViewWithType:(DDQDetailShareType)type {
    
    self.share_type = type;
    
    return [super initViewWithFrame:CGRectZero];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    if (self.select) {
        
        self.select();
        
    }
}

- (void)view_subviewsConfig {
    
    [super view_subviewsConfig];
    
    UIImage *image = self.share_type == DDQDetailShareTypeWX ? kSetImage(@"share_wx") : kSetImage(@"share_firend");
    
    self.share_imageView = [UIImageView imageViewChangeImage:image];
    
    NSString *title = self.share_type == DDQDetailShareTypeWX ? @"微信好友" : @"微信朋友圈";
    self.share_label = [UILabel labelChangeText:title font:DDQFont(12.0) textColor:kSetColor(102.0, 106.0, 106.0, 1.0)];
 
    [self view_configSubviews:@[self.share_imageView, self.share_label]];
    
}

- (void)view_updateContentSubviewsFrame {
    
    [super view_updateContentSubviewsFrame];
    
    autoLayout(self.share_imageView).ddq_centerX(self.centerX, 0.0).ddq_centerY(self.centerY, -10.0 * self.view_widthRate).ddq_fitSize();
    
    autoLayout(self.share_label).ddq_centerX(self.share_imageView.centerX, 0.0).ddq_top(self.share_imageView.bottom, 12.0 * self.view_widthRate).ddq_fitSize();
    
}

- (void)detail_didSelectShareView:(DDQSelectDetailShareView)share {
    
    if (share) {
        
        self.select = share;
        
    }
}

@end
