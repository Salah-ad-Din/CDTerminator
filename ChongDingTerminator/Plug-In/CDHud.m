//
//  CDHud.m
//  ChongDingTerminator
//
//  Created by Dingli on 2018/1/17.
//  Copyright © 2018年 Dingli. All rights reserved.
//

#import "CDHud.h"
#import <UIKit/UIWindow.h>
#import "MBProgressHUD.h"

@implementation CDHud

+ (UIWindow *)topWindow {
    __block UIWindow *window = nil;

    [[UIApplication sharedApplication].windows enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIWindow *win = (UIWindow *) obj;

        if ([win isMemberOfClass:[UIWindow class]] && ([win windowLevel] < UIWindowLevelStatusBar) && ![win isHidden]) {
            window = win;
            *stop = YES;
        }
    }];

    return window;
} /* topWindow */

+ (void)showHud {
    [self showHud:nil inView:[self topWindow]];
}

+ (void)showHudInView:(UIView *)view {
    [self showHud:nil inView:view];
}

+ (void)showHud:(NSString *)title inView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];

    BOOL hasHUD = (hud != nil);
    if (hasHUD) {
        [self hideHudInView:view];
    }

    hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = NSLocalizedString(title, @"HUD loading title");
}

+ (void)hideHud {
    [self hideHudInView:[self topWindow]];
}

+ (void)hideHudInView:(UIView *)view {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if (hud) {
        [hud hideAnimated:YES];
    }
}

@end
