//
//  DDQBaseWebPageController.m
//
//  Copyright © 2017年 我叫咚咚枪. All rights reserved.

#import "DDQBaseWebPageController.h"

@interface DDQBaseWebPageController ()<DDQWebPagePlaceholderDelegate, UINavigationControllerDelegate>

@property (nonatomic, assign, readwrite) BOOL web_requested;
@property (nonatomic, assign, readwrite) BOOL web_requestedFailure;

@end

@implementation DDQBaseWebPageController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //WebView
    WKWebViewConfiguration *webConfig = [[WKWebViewConfiguration alloc] init];
    self.web_WKWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:webConfig];
    [self.view addSubview:self.web_WKWebView];
    self.web_WKWebView.UIDelegate = self;
    
    //Progress
    self.web_rateProgress = [[UIProgressView alloc] initWithFrame:CGRectZero];
    self.web_rateProgress.progressViewStyle = UIProgressViewStyleDefault;
    self.web_rateProgress.trackTintColor = kSetColor(235.0, 235.0, 235.0, 1.0);
    [self.view addSubview:self.web_rateProgress];
    [self.web_rateProgress setProgressTintColor:[UIColor blackColor]];
    
    //PlaceholderView
    self.web_placeholderView = [DDQWebPagePlaceholderView placeholderWithTitle:@"当前网络异常!" subTitle:@"加载失败"];
    [self.view addSubview:self.web_placeholderView];
    self.web_placeholderView.hidden = YES;
    self.web_placeholderView.delegate = self;
    
    //KVO
    [self.web_WKWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];//进度条
    
    //WebBridge
    /**
     创建一个bridge
     PS:这里重点说明下，我将pod的WebViewJavascriptBridge指定到了4.1.5版本。因为5.0以后的版本我截获不到js，原因排查中。
     */
    self.web_jsBridge = [WKWebViewJavascriptBridge bridgeForWebView:self.web_WKWebView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        DDQLog(@"%@", data);
    }];
    
    //iOS 11.0
    if (@available(iOS 11.0, *)) {
        
        self.web_WKWebView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    } else {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.web_showWebTitle = YES;
    
    self.base_navigationController.delegate = self;
    
    //Reload
    if ([self.class respondsToSelector:@selector(webView_needRefreshHeader)]) {
        
        if ([self.class webView_needRefreshHeader]) {
            
            DDQWeakObject(self);
            [DDQWebPageController foundation_setHeaderWithView:self.web_WKWebView.scrollView Stlye:DDQFoundationHeaderStyleNormal Handle:^{
                
                [weakObjc.web_WKWebView reload];
            }];
        }
    }
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    CGFloat webY = (self.base_navigationBarStyle == DDQBaseNavigationBarStyleClearAndWhitBack) ? 0.0 : self.base_safeTopInset;
    CGFloat webH = self.view.height - webY - self.base_safeBottomInset;
    self.web_WKWebView.frame = CGRectMake(0.0, webY, self.view.width,  webH);
    self.web_rateProgress.frame = CGRectMake(0.0, self.web_WKWebView.y, self.web_WKWebView.width, 2.0);
    self.web_placeholderView.frame = self.web_WKWebView.frame;
}

- (void)dealloc {
    
    [self.web_WKWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    if (self.web_WKWebView.UIDelegate) self.web_WKWebView.UIDelegate = nil;
    
}

#pragma mark - Custom Method
- (void)setWeb_requestUrl:(NSString *)web_requestUrl {
    
    _web_requestUrl = web_requestUrl;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_web_requestUrl] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:25.0];
    [self.web_WKWebView loadRequest:request];
}

- (NSString *)web_dataKey { return @"key"; }

+ (BOOL)webView_needRefreshHeader {
    
    return YES;
    
}

#pragma mark - WKWebView Delegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    
    [self.web_rateProgress setHidden:NO];
    self.web_requested = YES;
    self.base_navigationController.interactivePopGestureRecognizer.enabled = YES;
    if (self.view.subviews.lastObject != self.web_rateProgress) [self.view bringSubviewToFront:self.web_rateProgress];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    if (self.web_showWebTitle && webView.title.length > 0) self.navigationItem.title = webView.title;//显示标题并且标题不为空
    [self.web_rateProgress setHidden:YES];
    self.web_placeholderView.hidden = YES;
    self.web_requested = YES;
    [webView.scrollView foundation_endRefreshing];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    self.web_placeholderView.hidden = NO;
    self.web_requestedFailure = YES;
    [self.view bringSubviewToFront:self.web_placeholderView];
    
    [webView.scrollView foundation_endRefreshing];
    self.web_placeholderView.placeholder_titleLabel.text = @"当前网络异常！";
    self.web_placeholderView.placeholder_subTitleLabel.text = @"加载失败";
}

#pragma mark - WKWebView UIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(nonnull NSString *)message initiatedByFrame:(nonnull WKFrameInfo *)frame completionHandler:(nonnull void (^)(void))completionHandler {
    
    DDQAlertController *alerController = [DDQAlertController alertControllerWithTitle:@"提示" message:message alertStyle:DDQAlertControllerStyleAlert];
    [alerController alert_addAlertItem:^__kindof DDQAlertItem * _Nullable{
        
        DDQAlertItem *item = [DDQAlertItem alertItemWithStyle:DDQAlertItemStyleDefault];
        item.item_attrTitle = [[NSAttributedString alloc] initWithString:@"确定" attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
        return item;
    } handler:nil];
    [self presentViewController:alerController animated:YES completion:nil];
    
    completionHandler();
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if (change[NSKeyValueChangeNewKey]) {
        
        float progress = [change[NSKeyValueChangeNewKey] floatValue];
        [self.web_rateProgress setProgress:progress animated:YES];
        
        if (progress >= 1.0) {//加载完成
            
            [self.web_rateProgress setHidden:YES];
            [self.web_rateProgress setProgress:0.0];
        }
    }
}

#pragma mark - PlaceholderView Delegate
- (void)placeholder_didSelectAlertWithView:(DDQWebPagePlaceholderView *)placeholderView {
    
    placeholderView.placeholder_titleLabel.text = @"重新加载中...";
    placeholderView.placeholder_subTitleLabel.text = @"请稍候";
    
    DDQWeakObject(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //webview没有数据，reload后不会重走代理方法
        weakObjc.web_requestUrl = weakObjc.web_requestUrl;
        [weakObjc.web_WKWebView reload];
    });
}

#pragma mark - NavigationController Delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    //将要显示的控制器
    if (viewController != self && navigationController.viewControllers.count - 1 < [navigationController.viewControllers indexOfObject:self]) {//将要显示的控制器不是self即为pop操作
        
        //这么写的原因是因为防止bridge的base对页面的强引用，造成页面的不被释放。
        //大致就是 self -> bridge -> bridgeBase -> self
        self.web_jsBridge = nil;
    }
}

@end
