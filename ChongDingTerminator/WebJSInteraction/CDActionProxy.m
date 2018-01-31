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
#import "LocalNotificationManager.h"
#import "CDHud.h"

@implementation CDActionProxy

- (void)openOrDownloadApk:(id)jsonStr {
    NSLog(@"AppInfo : %@", jsonStr);
    if (!jsonStr) {
        return;
    }
    NSArray<AppInfo *> *model = [NSArray yy_modelArrayWithClass:[AppInfo class] json:jsonStr];
    if ([model count]  == 0) {
        [CDHud alertWithTitle:@"参数错误" message:@"打开失败"];
        return;
    }
    
    [self gotoApp:model];
}

- (void)gotoApp:(NSArray*)apps {
    for (AppInfo* a in apps) {
        NSURL *scheme = [NSURL URLWithString:a.scheme];
        
        if (!scheme) {
            return;
        }
        
        MAIN_THREAD({
            if ([[UIApplication sharedApplication] canOpenURL:scheme]) {
                [[UIApplication sharedApplication] openURL:scheme];
                return;
            }
        });
    }
    
    MAIN_THREAD({
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:((AppInfo*)apps[0]).appUrl]];
    });
}

- (void)shareApp:(id)jsonStr {
    NSLog(@"shareApp : %@", jsonStr);
    if (!jsonStr) {
        return;
    }
    ShareModel *model = [ShareModel yy_modelWithJSON:jsonStr];

    if ([self.delegate respondsToSelector:@selector(share:)]) {
        [self.delegate share:model];
    }
}

- (void)sendSysNotification:(id)jsonStr {
    NSLog(@"sendSysNotification : %@", jsonStr);
    if (!jsonStr) {
        return;
    }
    LocalNotificationModel *model = [LocalNotificationModel yy_modelWithJSON:jsonStr];
    [LocalNotificationManager addLocalNotification:model];
}

@end
