//
//  LocalNotificationManager.h
//  ChongDingTerminator
//
//  Created by Dingli on 2018/1/17.
//  Copyright © 2018年 Dingli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalNotificationManager : NSObject

+ (NSString*)addLocalNotification:(id)model;

+ (void)cancelLocalNotification:(NSString *)notificationIdentifier;

@end
