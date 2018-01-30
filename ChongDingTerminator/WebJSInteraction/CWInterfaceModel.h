//
//  CWInterfaceModel.h
//  ChongDingTerminator
//
//  Created by Dingli on 2018/1/24.
//  Copyright © 2018年 Dingli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+YYModel.h"

@interface AppInfo : NSObject

@property(nonatomic, strong) NSString *appType;
@property(nonatomic, strong) NSString *appName;
@property(nonatomic, strong) NSString *packageName;
@property(nonatomic, strong) NSString *scheme;
@property(nonatomic, strong) NSString *downloadUrl;
@property(nonatomic, strong) NSString *appUrl;

@end

@interface OpenDownloadModel : NSObject

@property(nonatomic, strong) NSString *appType;
@property(nonatomic, strong) NSString *appName;
@property(nonatomic, strong) NSString *packageName;
@property(nonatomic, strong) NSString *scheme;
@property(nonatomic, strong) NSString *downloadUrl;
@property(nonatomic, strong) NSString *appUrl;

@end


@interface ShareModel : NSObject

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *shareType;
@property(nonatomic, strong) NSString *descript;
@property(nonatomic, strong) NSString *shareImgUrl;
@property(nonatomic, strong) NSString *directUrl;

@end

@interface LocalNotificationModel : NSObject

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *msg;
@property(nonatomic, strong) NSString *icon;
@property(nonatomic, strong) NSString *ticker;
@property(nonatomic, strong) NSString *delay;

@end

