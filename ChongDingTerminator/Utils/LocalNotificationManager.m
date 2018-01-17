//
//  LocalNotificationManager.m
//  ChongDingTerminator
//
//  Created by Dingli on 2018/1/17.
//  Copyright © 2018年 Dingli. All rights reserved.
//

#import "LocalNotificationManager.h"
#import <UserNotifications/UserNotifications.h>
#import <UIKit/UIKit.h>

@implementation LocalNotificationManager

static NSString *kLocalNotificationIdentifier = @"LocalNotificationIdentifier";

+ (void)addLocalNotification:(NSDate*)date {
    // 先取消已存在的推送
    [self cancelLocalNotification:kLocalNotificationIdentifier];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                        | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];

    //添加推送
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings *_Nonnull settings) {
            if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
                UNMutableNotificationContent *content = [UNMutableNotificationContent new];
                content.badge = @1;
                content.body = @"GO GO GO...";
                content.sound = [UNNotificationSound defaultSound];
                content.title = @"赢钱马上开始";
                UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:NO];
                UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:kLocalNotificationIdentifier content:content trigger:trigger];
                [center addNotificationRequest:request withCompletionHandler:^(NSError *_Nullable error) {
                    NSLog(@"%@", error);
                }];
            } else {

            }
        }];
    } else {
        if ([UIApplication sharedApplication].currentUserNotificationSettings.types != UIUserNotificationTypeNone) {
            UILocalNotification *notification = [[UILocalNotification alloc] init];
            notification.fireDate = [calendar dateFromComponents:components];
            notification.repeatInterval = 0;
            notification.alertBody = @"赢钱马上开始";
            notification.applicationIconBadgeNumber = 1;
            notification.soundName = UILocalNotificationDefaultSoundName;
            notification.userInfo = @{@"notificationIdentifier": kLocalNotificationIdentifier};
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        } else {

        }
    }
}

+ (void)cancelLocalNotification:(NSString *)notificationIdentifier {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> *_Nonnull requests) {
            for (UNNotificationRequest *request in requests) {
                if ([request.identifier isEqualToString:notificationIdentifier]) {
                    [center removePendingNotificationRequestsWithIdentifiers:@[request.identifier]];
                    break;
                }
            }
        }];
    } else {
        NSArray *notifications = [UIApplication sharedApplication].scheduledLocalNotifications;
        for (UILocalNotification *notification in notifications) {
            NSDictionary *userInfo = notification.userInfo;
            NSString *identifier = [userInfo objectForKey:@"notificationIdentifier"];
            if ([identifier isEqualToString:notificationIdentifier]) {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                break;
            }
        }
    }
}

@end
