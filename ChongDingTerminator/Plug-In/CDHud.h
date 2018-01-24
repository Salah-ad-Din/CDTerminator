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

@interface CDHud : NSObject

+ (MBProgressHUD *)alertWithTitle:(NSString *)title message:(NSString *)message;

+ (MBProgressHUD *)alertWithTitle:(NSString *)title message:(NSString *)message inView:(UIView *)view;

+ (MBProgressHUD *)showHud;

+ (void)hideHud;

+ (MBProgressHUD *)showHudInView:(UIView *)view;

+ (void)hideHudInView:(UIView *)view;

+ (MBProgressHUD *)showHud:(NSString *)title inView:(UIView *)view;

@end
