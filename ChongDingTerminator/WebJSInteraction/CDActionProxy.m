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

@implementation CDActionProxy

- (void)openOrDownloadApk:(id)jsonStr {
    NSLog(@"openOrDownloadApk : %@", jsonStr);
    if (!jsonStr) {
        return;
    }
    OpenDownloadModel *model = [OpenDownloadModel yy_modelWithJSON:jsonStr];
    NSURL *scheme = [NSURL URLWithString:model.scheme];

    if (!scheme) {
        return;
    }
    
    if ([[UIApplication sharedApplication] canOpenURL:scheme]) {
        [[UIApplication sharedApplication] openURL:scheme];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.downloadUrl]];
    }
}

- (void)shareApp:(id)jsonStr {
    NSLog(@"shareApp : %@", jsonStr);
    jsonStr = @"{\n"
 " \"title\": \"test title\",\n"
 " \"shareType\": \"1\",\n"
 " \"descript\": \"nothing is improtent\",\n"
 " \"shareImgUrl\": \"https://i.don't.know\",\n"
 " \"directUrl\": \"http://x.v.xiaomi.com/test\",\n"
 " \"extInfo\": {\n"
 "  \"name\": \"YY\",\n"
 "  \"group\": \"152634\",\n"
 "  \"androidApp\": [{\n"
 "   \"packageName\": \"com.xiaomi.test\",\n"
 "   \"scheme\": \"http://\",\n"
 "   \"downloadUrl\": \"http://downloan.xiaomi.com\",\n"
 "   \"appUrl\": \"https://x.v.xiaomi.com\",\n"
 "   \"appName\": \"冲顶大会\"\n"
 "  }],\n"
 "  \"appleApp\": [{\n"
 "   \"packageName\": \"com.xiaomi.test\",\n"
 "   \"scheme\": \"http://\",\n"
 "   \"downloadUrl\": \"http://downloan.xiaomi.com\",\n"
 "   \"appUrl\": \"https://x.v.xiaomi.com\",\n"
 "   \"appName\": \"冲顶大会\"\n"
 "  }]\n"
 " }\n"
 "}";
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
