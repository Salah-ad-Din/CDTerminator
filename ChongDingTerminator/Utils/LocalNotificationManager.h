//
//  LocalNotificationManager.h
//  ChongDingTerminator
//
//  Created by Dingli on 2018/1/17.
//  Copyright © 2018年 Dingli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalNotificationManager : NSObject

+ (void)addLocalNotification:(NSDate*)date;

+ (void)cancelLocalNotification:(NSString *)notificationIdentifier;

@end
