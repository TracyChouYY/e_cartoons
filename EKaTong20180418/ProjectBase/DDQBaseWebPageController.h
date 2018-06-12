//
//  DDQBaseWebPageController.h
//
//  Copyright © 2017年 我叫咚咚枪. All rights reserved.

#import "DDQBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

/**
 工程基础网页控制器
 PS:本身我在pod里写的控制器基类局限性较大，所以我单独又写了这个类，实现基本过程相同但耦合度降低。
 且本工程pod版本的WebPageController在WebBridge上处理存在问题。我在本类已完成修改。
 */
@interface DDQBaseWebPageController : DDQBaseViewController <WKNavigationDelegate, WKUIDelegate>

/**
 一个基础的WebView
 */
@property (nonatomic, strong) WKWebView *web_WKWebView;

/**
 请求地址
 */
@property (nonatomic, copy, nullable) NSString *web_requestUrl;

/** 当前网页是否已经请求过 */
@property (nonatomic, assign, readonly) BOOL web_requested;

/** 当前网页请求失败 */
@property (nonatomic, assign, readonly) BOOL web_requestedFailure;

/**
 JSDataKey
 */
@property (nonatomic, readonly) NSString *web_dataKey;

/**
 是否显示Web的标题
 */
@property (nonatomic, assign) BOOL web_showWebTitle;//Default YES

/**
 网页加载进度
 */
@property (nonatomic, strong) UIProgressView *web_rateProgress;

/**
 js交互
 */
@property (nonatomic, strong, nullable) WKWebViewJavascriptBridge *web_jsBridge;

/**
 网页加载失败时的提示View
 */
@property (nonatomic, strong) DDQWebPagePlaceholderView *web_placeholderView;

+ (BOOL)webView_needRefreshHeader;//default YES;

@end

NS_ASSUME_NONNULL_END
