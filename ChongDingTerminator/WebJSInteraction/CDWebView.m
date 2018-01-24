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
#import "MJRefresh.h"
#import "CDHud.h"
#import "Constants.h"
#import "extobjc.h"

@implementation NSURLRequest (DataController)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host {
    return YES;
}
@end


@interface CDWebView () <UIWebViewDelegate, CDActionDelegate>

@property(nonatomic, strong) JSContext *context;
@property(nonatomic, strong) NSString *url;

@end

@implementation CDWebView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.delegate = self;

    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.delegate = self;
        self.scrollView.bounces = false;
        if (ADD_REFREFRESH) {
            MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                             refreshingAction:@selector(headerRefresh)];
            header.lastUpdatedTimeLabel.hidden = YES;
            [header setTitle:@"下拉刷新" forState:MJRefreshStateWillRefresh];
            [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
            [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
            [header setTitle:@"玩命加载中..." forState:MJRefreshStateRefreshing];
            self.scrollView.mj_header = header;
            //        self.scrollView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self
            //                                                                         refreshingAction:@selector(footerRefresh)];
        }

    }
    return self;
}

- (void)loadURL:(NSString *)url {
    self.url = url;
    [self loadData];
}

- (void)loadData {
    [self loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

#pragma mark - 下拉刷新

- (void)headerRefresh {
    [self loadData];
}

#pragma mark - 上拉加载

- (void)footerRefresh {
    [self loadData];
}

#pragma mark - 结束下拉刷新和上拉加载

- (void)endRefresh {
    //当请求数据成功或失败后，如果你导入的MJRefresh库是最新的库，就用下面的方法结束下拉刷新和上拉加载事件
    [self.scrollView.mj_header endRefreshing];
    [self.scrollView.mj_footer endRefreshing];
    [CDHud hideHudInView:self];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%@", request.description);
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
    [CDHud showHud:@"加载中..." inView:self];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
    //首先创建JSContext 对象（此处通过当前webView的键获取到jscontext)
    _context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    CDActionProxy *cdActionProxy = [[CDActionProxy alloc] init];
    cdActionProxy.delegate = self;
    _context[@"CWInterface"] = cdActionProxy;

    if ([self.cdDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [self.cdDelegate webViewDidFinishLoad:self];
    }
    [self endRefresh];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"didFailLoadWithError");
    [self endRefresh];
}

#pragma mark - Notification info

- (void)shareSuccess {
    [_context evaluateScript:@"shareSuccess()"];
}
@end
