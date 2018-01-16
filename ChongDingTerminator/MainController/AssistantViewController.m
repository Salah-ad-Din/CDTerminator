//
//  FirstViewController.m
//  ChongDingTerminator
//
//  Created by Dingli on 2018/1/11.
//  Copyright © 2018年 Dingli. All rights reserved.
//

#import "AssistantViewController.h"
#import "StoryboardConstants.h"
#import <UShareUI/UShareUI.h>

@interface AssistantViewController ()

@end

@implementation AssistantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer * gr = [UITapGestureRecognizer new];
    [gr addTarget:self action:@selector(push:)];
    [self.label addGestureRecognizer:gr];
    [self.label setUserInteractionEnabled:YES];
}

- (void)push:(UITapGestureRecognizer* )gr {
//    [self performSegueWithIdentifier:CDShare sender:self];
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
