//
//  SecondViewController.m
//  ChongDingTerminator
//
//  Created by Dingli on 2018/1/11.
//  Copyright © 2018年 Dingli. All rights reserved.
//

#import "ToolsViewController.h"
#import "CDWebView.h"

@interface ToolsViewController ()
@property (weak, nonatomic) IBOutlet CDWebView *webView;
@end

@implementation ToolsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *path = @"https://www.baidu.com";
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:path]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
