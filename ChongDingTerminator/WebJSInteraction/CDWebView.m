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
#import "PrefixHeader.h"
#import "UIWebView+KeyValueStorage.h"
#import "UIScrollView+EmptyDataSet.h"
#import "RealReachability.h"

@implementation NSURLRequest (DataController)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host {
    return YES;
}
@end


@interface CDWebView () <UIWebViewDelegate, CDActionDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property(nonatomic, strong) IBOutlet UIButton *back;

@property(nonatomic, strong) JSContext *context;
@property(nonatomic, strong) NSURL *originUrl;
@property(nonatomic, assign) BOOL bLoadSuccess;

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

        self.back.hidden = YES;
        self.scrollView.bounces = NO;
        self.scrollView.emptyDataSetSource = self;
        self.scrollView.emptyDataSetDelegate = self;
        self.bLoadSuccess = YES;
        if (ADD_REFREFRESH) {
            self.scrollView.bounces = YES;
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
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(networkChanged:)
                                                     name:kRealReachabilityChangedNotification
                                                   object:nil];
    }
    return self;
}

- (void)loadURL:(NSString *)url {
    self.originUrl = [NSURL URLWithString:url];
    self.back.hidden = YES;
    [self loadData];
}

- (void)loadData {
    [self loadRequest:[NSURLRequest requestWithURL:self.originUrl]];
}

- (IBAction)backToMain:(id)sender {
    [self goBack];
    //    [self loadData];
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
    [self.scrollView reloadEmptyDataSet];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%@, navigationType: %ld", request.description, (long)navigationType);
    if ([request.URL.absoluteString containsString:@"account.xiaomi.com"]) {
        self.back.hidden = NO;
    }
    
    if ([request.URL.absoluteString isEqualToString:@"about:blank"]) {
        return NO;
    }
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
    self.bLoadSuccess = YES;
    [self endRefresh];
    NSLog(@"canGoBack %@，canForward %@", @([self canGoBack]), @([self canGoForward]));
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"didFailLoadWithError");
    self.bLoadSuccess = NO;
    [self endRefresh];
}

#pragma mark - EmpytPage

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"no_network"];
}

// 图片的动画效果(默认为关闭,需要调用代理方法emptyDataSetShouldAnimateImageView进行开启)
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];

    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:0.0];

    animation.duration = 1.0;
    animation.autoreverses = YES;
    animation.repeatCount = MAXFLOAT;
    return animation;
}

// 标题文本，富文本样式
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"网络有问题";

    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
            NSForegroundColorAttributeName: [UIColor darkGrayColor]};

    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

// 标题文本下面的详细描述，富文本样式
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *text = @"请检查网络是否有通畅";

    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;

    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
            NSForegroundColorAttributeName: [UIColor lightGrayColor],
            NSParagraphStyleAttributeName: paragraph};

    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

// 空白页的背景色
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return UICOLOR_WITH_HEX_RGB(2c107f);
}

// 图片与标题文本,以及标题文本和详细描述之间的垂直距离,默认是11pts
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 11;
}

// 是否 显示空白页,默认是YES
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return !self.bLoadSuccess;
}

// 是否 允许图片有动画效果，默认NO(设置为YES后,动画效果才会有效)
- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
    return YES;
}

// 是否 允许点击,默认是YES
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}

// 点击中间的图片和文字时调用
- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView {
    [self loadData];
}

#pragma mark - Notification info

- (void)share:(id)model {
    if ([self.cdDelegate respondsToSelector:@selector(share:)]) {
        [self.cdDelegate share:model];
    }
}

- (void)shareSuccess {
    [_context evaluateScript:@"shareSuccess()"];
}

#pragma mark - network

- (void)networkChanged:(NSNotification *)notification {
    RealReachability *reachability = (RealReachability *) notification.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];
    NSLog(@"currentStatus:%@", @(status));
    if (self.scrollView.emptyDataSetVisible && (status == RealStatusViaWWAN || status == RealStatusViaWiFi)) {
        [self loadData];
    }
}
@end
