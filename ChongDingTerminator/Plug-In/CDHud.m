//
//  CDHud.m
//  ChongDingTerminator
//
//  Created by Dingli on 2018/1/17.
//  Copyright © 2018年 Dingli. All rights reserved.
//

#import "CDHud.h"
#import <UIKit/UIWindow.h>

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

+ (MBProgressHUD *)alertWithTitle:(NSString *)title message:(NSString *)message {
    return [self alertWithTitle:title message:message inView:[self topWindow]];
}

+ (MBProgressHUD *)alertWithTitle:(NSString *)title message:(NSString *)message inView:(UIView *)view {
    __block MBProgressHUD *hud = nil;
    void (^actionBlock) (void) = ^{
        hud = [CDHud showHudInView:view];
        
        hud.mode = MBProgressHUDModeText;
        hud.graceTime = 0.1;
        hud.animationType = MBProgressHUDAnimationZoomOut;
        hud.userInteractionEnabled = NO;
        hud.label.text = title;
        hud.detailsLabel.text = message;
        [hud hideAnimated:YES afterDelay:3];
    };
    
    MAIN_THREAD(actionBlock());
    return hud;
} /* alertWithTitle */

+ (MBProgressHUD *)alertWithMessage:(NSString *)message {
    return [self alertWithTitle:nil message:message];
}

+ (MBProgressHUD *)showHud {
    return [self showHud:nil inView:[self topWindow]];
}

+ (MBProgressHUD *)showHudInView:(UIView *)view {
    return [self showHud:nil inView:view];
}

+ (MBProgressHUD *)showHud:(NSString *)title inView:(UIView *)view {
    __block MBProgressHUD *hud = [MBProgressHUD HUDForView:view];

    BOOL hasHUD = (hud != nil);
    if (hasHUD) {
        [self hideHudInView:view];
    }
    void (^actionBlock) (void) = ^{
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.label.text = NSLocalizedString(title, @"HUD loading title");
    };
    MAIN_THREAD(actionBlock());
    
    return hud;
}

+ (void)hideHud {
    [self hideHudInView:[self topWindow]];
}

+ (void)hideHudInView:(UIView *)view {
    MAIN_THREAD({
        MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
        if (hud) {
            [hud hideAnimated:YES];
        }
    });
}

@end
