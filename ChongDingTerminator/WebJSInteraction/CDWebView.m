//
//  CDWebView.m
//  ChongDingTerminator
//
//  Created by Dingli on 2018/1/15.
//  Copyright © 2018年 Dingli. All rights reserved.
//

#import "CDWebView.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "CDActionProxy.h"

@interface CDWebView () <UIWebViewDelegate>

@property (nonatomic, strong) JSContext *context;

@end

@implementation CDWebView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.delegate = self;
    }
    return self;
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
    //首先创建JSContext 对象（此处通过当前webView的键获取到jscontext)
    _context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    CDActionProxy *cdActionProxy = [[CDActionProxy alloc] init];
    _context[@"CWInterface"] = cdActionProxy;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"didFailLoadWithError");
}

#pragma mark - Notification info
- (void)shareSuccess {
    [_context evaluateScript: @"shareSuccess()"];
}
@end
