//
//  CDActionProxy.m
//  ChongDingTerminator
//
//  Created by Dingli on 2018/1/15.
//  Copyright © 2018年 Dingli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDActionProxy.h"
#import "CWInterfaceModel.h"

@implementation CDActionProxy

- (void)openOrDownloadApk:(id)jsonStr {
    NSLog(@"openOrDownloadApk : %@", jsonStr);
    if (!jsonStr) {
        return;
    }
    OpenDownloadModel *model = [OpenDownloadModel yy_modelWithJSON:jsonStr];
    NSURL *scheme = [NSURL URLWithString:model.scheme];

    if ([[UIApplication sharedApplication] canOpenURL:scheme]) {
        [[UIApplication sharedApplication] openURL:scheme];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.downloadUrl]];
    }
}

- (void)shareApp:(id)jsonStr {
    NSLog(@"shareApp : share。。。。。。。。。");
    if (!jsonStr) {
        return;
    }
    ShareModel *model = [ShareModel yy_modelWithJSON:jsonStr];

    if ([self.delegate respondsToSelector:@selector(share)]) {
            [self.delegate share:model];
    }
}

@end
