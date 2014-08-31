//
//  XDPrecompile.h
//  XDUIKitFramework
//
//  Created by suxinde on 14-8-31.
//  Copyright (c) 2014年 __MyCompany__. All rights reserved.
//

#import <Foundation/Foundation.h>

////////////////////////////////////////////////////////////////////////////////////////
// 加载.h头文件
////////////////////////////////////////////////////////////////////////////////////////

//#import "HexColor.h"

////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////
// MD5宏定义
////////////////////////////////////////////////////////////////////////////////////////
#define md5_key @"" // encode用的key


////////////////////////////////////////////////////////////////////////////////////////
// 通知类宏定义
////////////////////////////////////////////////////////////////////////////////////////

#define NSNotificationCenterInstance [NSNotificationCenter defaultCenter]

// POST Notification
#define NSNotificationCenterPostNotification(__Name__, __Object__) \
[NSNotificationCenterInstance postNotificationName:__Name__ object:__Object__];

// Add Notification Observer
#define NSNotificationCenterAddObserverForNotification(__Observer__, __SEL__ , __Name__, __Object__) \
[NSNotificationCenterInstance addObserver:__Observer__      \
                                 selector:__SEL__           \
                                     name:__Name__          \
                                   object:__Object__]

// Remove Notification Observer
#define NSNotificationCenterRemoveObserverForNotification(__Observer__, __Name__, __Object__) \
[[NSNotificationCenter defaultCenter] removeObserver:__Observer__       \
                                                name:__Name__           \
                                              object:__Object__]

////////////////////////////////////////////////////////////////////////////////////////
// 用户偏好类宏定义
////////////////////////////////////////////////////////////////////////////////////////

#define NSUserDefaultsInstance [NSUserDefaults standardUserDefaults]

//synchronize
#define NSUserDefalutsSynchronize() [NSUserDefaultsInstance synchronize]

// Int
#define NSUserDefalutsSetIntForKey(__value__ , __key__) \
[NSUserDefaultsInstance setInteger:__value__ forKey:__key__]

#define NSUserDefalutsGetIntForKey(__key__) \
[[NSUserDefaults standardUserDefaults] integerForKey:__key__]

// Float
#define NSUserDefalutsSetFloatForKey(__value__ , __key__) \
[NSUserDefaultsInstance setFloat:__value__ forKey:__key__]

#define NSUserDefalutsGetFloatForKey(__key__) \
[[NSUserDefaults standardUserDefaults] floatForKey:__key__]

// Double
#define NSUserDefalutsSetDoubleForKey(__value__ , __key__) \
[NSUserDefaultsInstance setDouble:__value__ forKey:__key__]

#define NSUserDefalutsGetDoubleForKey(__key__) \
[[NSUserDefaults standardUserDefaults] doubleForKey:__key__]

// BOOL
#define NSUserDefalutsSetBoolForKey(__value__ , __key__) \
[NSUserDefaultsInstance setBool:__value__ forKey:__key__]

#define NSUserDefalutsGetBoolForKey(__key__) \
[[NSUserDefaults standardUserDefaults] boolForKey:__key__]

// Object
#define NSUserDefalutsSetObjectForKey(__value__ , __key__) \
[NSUserDefaultsInstance setObject:__value__ forKey:__key__]

#define NSUserDefalutsGetObjectForKey(__key__) \
[[NSUserDefaults standardUserDefaults] objectForKey:__key__]

////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////
// Deprecated
////////////////////////////////////////////////////////////////////////////////////////
#define __Class_Deprecated__
#define __Method_Deprecated__

////////////////////////////////////////////////////////////////////////////////////////
// 颜色类宏定义
////////////////////////////////////////////////////////////////////////////////////////

#define RgbColor(r,g,b) \
[UIColor colorWithRed:(r)/255.0f \
                green:(g)/255.0f \
                 blue:(b)/255.0f \
                alpha:1.0f]

#define RgbColorA(r,g,b,a) \
[UIColor colorWithRed:(r)/255.0f \
                green:(g)/255.0f \
                 blue:(b)/255.0f \
                alpha:(a)]


#define RgbColorByHex(__hex__) \
[HXColor colorWithHexString:__hex__]


#define RgbColorByHexA(__hex__, __alpha__) \
[HXColor colorWithHexString:__hex__ alpha:__alpha__]


////////////////////////////////////////////////////////////////////////////////////////

#ifdef __IPHONE_6_0
#define kTextAlignmentLeft NSTextAlignmentLeft
#define kTextAlignmentCenter NSTextAlignmentCenter
#define kTextAlignmentRight NSTextAlignmentRight
#define kLineBreakModeCharaterWrap NSLineBreakByCharWrapping
#define kLineBreakModeWordWrap NSLineBreakByWordWrapping
#define kLineBreakModeClip NSLineBreakByClipping
#define kLineBreakModeTruncatingHead NSLineBreakByTruncatingHead
#define kLineBreakModeTruncatingMiddle NSLineBreakByTruncatingMiddle
#define kLineBreakModeTruncatingTail NSLineBreakByTruncatingTail
#else
#define kTextAlignmentLeft UITextAlignmentLeft
#define kTextAlignmentCenter UITextAlignmentCenter
#define kTextAlignmentRight UITextAlignmentRight
#define kLineBreakModeCharaterWrap UILineBreakModeCharacterWrap
#define kLineBreakModeWordWrap UILineBreakModeWordWrap
#define kLineBreakModeClip UILineBreakModeClip
#define kLineBreakModeTruncatingHead UILineBreakModeHeadTruncation
#define kLineBreakModeTruncatingMiddle UILineBreakModeMiddleTruncation
#define kLineBreakModeTruncatingTail UILineBreakModeTailTruncation
#endif

#define kMainScreenFrame [[UIScreen mainScreen] bounds]
#define kMainScreenWidth kMainScreenFrame.size.width
#define kMainScreenHeight kMainScreenFrame.size.height-20
#define kApplicationFrame [[UIScreen mainScreen] applicationFrame]
#define kNavBarHeight 44.0f

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?  \
CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)



// 日期字符串 格式
#define kOriginDateFormat       @"yyyyMMddhhmmss"
#define kDestinationDateFormat  @"yyyy-MM-dd hh:mm:ss"
