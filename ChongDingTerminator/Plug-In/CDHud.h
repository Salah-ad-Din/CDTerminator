//
//  CDHud.h
//  ChongDingTerminator
//
//  Created by Dingli on 2018/1/17.
//  Copyright © 2018年 Dingli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CDHud : NSObject

+ (void)showHud;

+ (void)hideHud;

+ (void)showHudInView:(UIView *)view;

+ (void)hideHudInView:(UIView *)view;

+ (void)showHud:(NSString *)title inView:(UIView *)view;

@end
