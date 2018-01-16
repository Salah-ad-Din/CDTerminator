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
           - (void)openOrDownloadApk:(id)pkgStr downloadUrl:(id)url
           );

JSExportAs(openOrDownloadApk,
           - (void)shareApp:(id)qrImageUrl
           );

@end

@interface CDActionProxy : NSObject

@end
