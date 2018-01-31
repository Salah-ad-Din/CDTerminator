//
//  CWInterfaceModel.m
//  ChongDingTerminator
//
//  Created by Dingli on 2018/1/24.
//  Copyright © 2018年 Dingli. All rights reserved.
//

#import "CWInterfaceModel.h"

@implementation AppInfo
@end

@implementation ExtInfo
+ (NSDictionary*)modelContainerPropertyGenericClass {
    return @{@"appleApps" : [AppInfo class]
             };
}
@end

@implementation ShareModel
@end

@implementation LocalNotificationModel
@end
