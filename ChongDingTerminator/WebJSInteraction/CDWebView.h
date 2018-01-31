//
//  CDWebView.h
//  ChongDingTerminator
//
//  Created by Dingli on 2018/1/15.
//  Copyright © 2018年 Dingli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSURLRequest (DataController)
@end

@protocol CDWebViewDelegate <UIWebViewDelegate>
- (void)share:(id)model;
@end


@interface CDWebView : UIWebView

@property(nonatomic, weak) id <CDWebViewDelegate> cdDelegate;

- (void)loadURL:(NSString *)url;

- (void)shareSuccess:(NSArray*)app;

@end
