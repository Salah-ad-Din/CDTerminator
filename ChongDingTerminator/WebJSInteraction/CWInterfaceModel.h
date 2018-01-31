//
//  CWInterfaceModel.h
//  ChongDingTerminator
//
//  Created by Dingli on 2018/1/24.
//  Copyright © 2018年 Dingli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+YYModel.h"

// 跳转
@interface AppInfo : NSObject
@property(nonatomic, strong) NSString *appType;
@property(nonatomic, strong) NSString *appName;
@property(nonatomic, strong) NSString *packageName;
@property(nonatomic, strong) NSString *scheme;
@property(nonatomic, strong) NSString *downloadUrl;
@property(nonatomic, strong) NSString *appUrl;
@end

// 分享相关内容

@interface ExtInfo : NSObject
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *group;
@property(nonatomic, strong) NSArray<AppInfo*> *appleApps;
@end

@interface ShareModel : NSObject
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *shareType;
@property(nonatomic, strong) NSString *descript;
@property(nonatomic, strong) NSString *shareImgUrl;
@property(nonatomic, strong) NSString *directUrl;
@property(nonatomic, strong) NSString *iconUrl;
@property(nonatomic, strong) ExtInfo *extInfo;
@end

@interface LocalNotificationModel : NSObject
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *msg;
@property(nonatomic, strong) NSString *icon;
@property(nonatomic, strong) NSString *ticker;
@property(nonatomic, strong) NSString *delay;
@end

