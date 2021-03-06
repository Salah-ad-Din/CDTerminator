//
//  CDActionProxy.h
//  ChongDingTerminator
//
//  Created by Dingli on 2018/1/15.
//  Copyright © 2018年 Dingli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol CDJsObjectProtocol <JSExport>

JSExportAs(openOrDownloadApk,
        -(void) openOrDownloadApk:(id)jsonStr
);

JSExportAs(shareApp,
        -(void) shareApp:(id)jsonStr
);

JSExportAs(sendSysNotification,
           -(void) sendSysNotification:(id)jsonStr
           );

@end

@protocol CDActionDelegate <NSObject>

- (void)share:(id)model;

@end

@interface CDActionProxy : NSObject <CDJsObjectProtocol>

@property(nonatomic, weak) id<CDActionDelegate> delegate;

- (void)gotoApp:(NSArray*)apps;

@end
