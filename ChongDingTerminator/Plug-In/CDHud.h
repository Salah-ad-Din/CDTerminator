//
//  CDHud.h
//  ChongDingTerminator
//
//  Created by Dingli on 2018/1/17.
//  Copyright © 2018年 Dingli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

#define MAIN_THREAD(ARGS) if (strcmp(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL), dispatch_queue_get_label(dispatch_get_main_queue())) == 0) { ARGS;} else { dispatch_async(dispatch_get_main_queue(), ^{ ARGS; });}

@interface CDHud : NSObject

+ (MBProgressHUD *)alertWithTitle:(NSString *)title message:(NSString *)message;

+ (MBProgressHUD *)alertWithTitle:(NSString *)title message:(NSString *)message inView:(UIView *)view;

+ (MBProgressHUD *)showHud;

+ (void)hideHud;

+ (MBProgressHUD *)showHudInView:(UIView *)view;

+ (void)hideHudInView:(UIView *)view;

+ (MBProgressHUD *)showHud:(NSString *)title inView:(UIView *)view;

@end
