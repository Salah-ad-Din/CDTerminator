//
//  CDWebView.h
//  ChongDingTerminator
//
//  Created by Dingli on 2018/1/15.
//  Copyright © 2018年 Dingli. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CDWebViewDelegate <UIWebViewDelegate>

@end


@interface CDWebView : UIWebView

@property(nonatomic, weak) id <CDWebViewDelegate> cdDelegate;

- (void)loadURL:(NSString *)url;

// 分享成功调用webview的方法
- (void)shareSuccess;

@end
