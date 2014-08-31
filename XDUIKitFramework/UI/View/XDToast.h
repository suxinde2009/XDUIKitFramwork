//
//  XDToast.h
//  XDUIKitFramework
//
//  Created by admin on 12-8-10.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

//
//  Android like pop tip view
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class XDToastSettings;

typedef enum {
    XDToastGravityTop = 10001,
    XDToastGravityBottom,
    XDToastGravityCenter
}XDToastGravity;

enum XDToastDuration {
    XDToastDurationLong = 10000,
    XDToastDurationShort = 1000,
    XDToastDurationNormal = 3000
}XDToastDuration;

typedef enum {
    XDToastTypeInfo = -100000,
    XDToastTypeNotice,
    XDToastTypeWarning,
    XDToastTypeError
}XDToastType;



@interface XDToast : NSObject {
    
    XDToastSettings *settings_;
    NSInteger offsetLeft_;
    NSInteger offsetTop_;
    
    NSTimer *timer_;
    
    UIView *view_;
    NSString *text_;
}

+ (XDToast *)makeText:(NSString *)text;
- (XDToast *)setDuration:(NSInteger)duration;
- (XDToast *)setGravity:(XDToastGravity)gravity offsetLeft:(NSInteger)left offsetTop:(NSInteger)top;
- (XDToast *)setGravity:(XDToastGravity)gravity;
- (XDToast *)setPostion:(CGPoint)position;
- (XDToastSettings *)theSettings;
- (void)show;

@end

@interface XDToastSettings : NSObject <NSCopying> {
    NSInteger duration_;
    XDToastGravity gravity_;
    CGPoint position_;
    XDToastType toastType_;
    NSDictionary *images_;
    BOOL positionIsSet;
}

@property (nonatomic, assign) NSInteger durration;
@property (nonatomic, assign) XDToastGravity gravity;
@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign, readonly) NSDictionary *images;

- (void)setImage:(UIImage *)img forType:(XDToastType)type;
+ (XDToastSettings *)getSharedSettings;

@end
