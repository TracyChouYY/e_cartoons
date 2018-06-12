//
//  DDQUserProtocolController.m
//  EKaTong20180418
//
//  Created by 我叫咚咚枪 on 2018/5/7.
//  Copyright © 2018年 WICEP. All rights reserved.
//

#import "DDQUserProtocolController.h"

@interface DDQUserProtocolController ()

@end

@implementation DDQUserProtocolController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //WebView
    self.web_requestUrl = [self.base_url stringByAppendingString:@"Public/userProtocal.html"];

}

+ (BOOL)webView_needRefreshHeader {
    
    return NO;
    
}

@end
