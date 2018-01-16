//
//  PrefixHeader.h
//  ChongDingTerminator
//
//  Created by Dingli on 2018/1/15.
//  Copyright © 2018年 Dingli. All rights reserved.
//

#ifndef PrefixHeader_h
#define PrefixHeader_h

#define IS_IPAD             ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define IS_IPHONE           ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define IS_IPHONE5          (IS_IPHONE && (CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size) || CGSizeEqualToSize(CGSizeMake(568, 320), [[UIScreen mainScreen] bounds].size)))
#define IS_IPHONE6          (IS_IPHONE && (CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size) || CGSizeEqualToSize(CGSizeMake(667, 375), [[UIScreen mainScreen] bounds].size)))
#define IS_IPHONE6_PLUS     (IS_IPHONE && (CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size) || CGSizeEqualToSize(CGSizeMake(736, 414), [[UIScreen mainScreen] bounds].size)))
#define IS_IPHONE_X         (IS_IPHONE && (CGSizeEqualToSize(CGSizeMake(375, 812), [[UIScreen mainScreen] bounds].size) || CGSizeEqualToSize(CGSizeMake(812, 375), [[UIScreen mainScreen] bounds].size)))
#define IS_IPHONE5_OR_LATER (IS_IPHONE && ([UIScreen mainScreen].currentMode.size.height >= 1136))
#define IS_SIMULATOR    TARGET_IPHONE_SIMULATOR

#define IS_LANDSCAPE_ORIENT  (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IS_IOS7_OR_LATER    SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")
#define IS_IOS8_OR_LATER    SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")
#define IS_IOS9_OR_LATER    SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")
#define IS_IOS10_OR_LATER    SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")
#define IS_IOS11_OR_LATER    SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0")

#define VIEW_SAFE_AREAINSETS(view) ({UIEdgeInsets i; if(@available(iOS 11.0, *)) {i = view.safeAreaInsets;} else {i = UIEdgeInsetsZero;} i;})
#define DkGetNSValueFromCType(cValue) ([NSValue value:&cValue withObjCType:@encode(typeof(cValue))])
#define DkSetCValueFromNSValue(ocValue, cValue) [ocValue getValue:&cValue]

#define STRING(fmt, ...)  [NSString stringWithFormat: fmt, __VA_ARGS__]

#define SAFE_VALUE(value, DEFAULT_VALUE) ( (value) ? : (DEFAULT_VALUE) )
#define SAFE_STRING(value) ( (value) ? : @"" )
#define NOT_EMPTY_STRING(value, default) ( (value) ? : (default) )

#if defined(__LP64__) && __LP64__
#define DK_CGABS(doubleValue)   fabs(doubleValue)
#else
#define DK_CGABS(floatValue)    fabsf(floatValue)
#endif

#define DK_DABSD(doubleValue)   fabs(doubleValue)
#define DK_FABSF(floatValue)    fabsf(floatValue)

#define DKCheckNSString(string) (string != nil && [string isKindOfClass:[NSString class]] && string.length > 0)

// 十进制rgb(0-255)，a(0-1)
#define UICOLOR_WITH_DEC_RGBA(R,G,B,A) [UIColor colorWithRed: (R) / 255.0 green: (G) / 255.0 blue: (B) / 255.0 alpha:(A)]

// 十六进制颜色值，a(0-1)
#define UICOLOR_WITH_HEX_RGB(RGB)       [UIColor colorWithRed:(((0x##RGB & 0xFF0000) >> 16) / 255.0) green:(((0x##RGB & 0x00FF00) >> 8) / 255.0) blue:((0x##RGB & 0x0000FF) / 255.0) alpha:1.0]
#define UICOLOR_WITH_HEX_RGBA(RGB,A)    [UIColor colorWithRed:(((0x##RGB & 0xFF0000) >> 16) / 255.0) green:(((0x##RGB & 0x00FF00) >> 8) / 255.0) blue:((0x##RGB & 0x0000FF) / 255.0) alpha:A]

#endif /* PrefixHeader_h */
