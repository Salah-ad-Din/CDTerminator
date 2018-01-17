//
//  SecondViewController.m
//  ChongDingTerminator
//
//  Created by Dingli on 2018/1/11.
//  Copyright © 2018年 Dingli. All rights reserved.
//

#import "ToolsViewController.h"
#import "CDWebView.h"

@interface ToolsViewController () <CDWebViewDelegate>
@property(weak, nonatomic) IBOutlet CDWebView *webView;
@end

@implementation ToolsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [_webView loadURL:@"https://www.baidu.com"];

    // Configure View Controller
    self.webView.cdDelegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CDWebviewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {

}
@end
