//
//  XDToast.m
//  XDUIKitFramework
//
//  Created by admin on 12-8-10.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import "XDToast.h"
#import <QuartzCore/QuartzCore.h>

static XDToastSettings *sharedSettings = nil;

@implementation XDToast

- (id)initWithText:(NSString *)text {
    if(self = [super init]){
        text_ = [text copy];
    }
    return self;
}

- (void)show {
    
    XDToastSettings *theSettings = settings_;
    if(!theSettings) {
        theSettings = [XDToastSettings getSharedSettings];
    }
    
    UIFont *font = [UIFont systemFontOfSize:16.0f];
    CGSize textSize = [text_ sizeWithFont:font constrainedToSize:CGSizeMake(280, 60)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width, textSize.height+5)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor]; 
    label.font = font;
    label.text = text_;
    label.numberOfLines = 0;
    label.shadowColor = [UIColor darkGrayColor];
    label.shadowOffset = CGSizeMake(1, 1);
    
    UIButton *v = [UIButton buttonWithType:UIButtonTypeCustom];
    v.frame = CGRectMake(5, 0, textSize.width+10, textSize.height+10);
    label.center = CGPointMake(v.frame.size.width/2, v.frame.size.height/2);
    [v addSubview:label];
    [label release];
    
    v.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    v.layer.cornerRadius = 5.0f;
    
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    CGPoint point = CGPointZero; //CGPointMake(window.frame.size.width/2, window.frame.size.height/2);
    
    if(theSettings.gravity == XDToastGravityTop) {
        point = CGPointMake(window.frame.size.width/2, 45);
    }else if (theSettings.gravity == XDToastGravityBottom) {
        point = CGPointMake(window.frame.size.width/2, window.frame.size.height-45);
    }else if (theSettings.gravity == XDToastGravityCenter) {
        point = CGPointMake(window.frame.size.width/2, window.frame.size.height/2);
    }else {
        point = theSettings.position;
    }

    point = CGPointMake(point.x + offsetLeft_, point.y + offsetTop_);
    v.center = point;
    
    NSTimer *timer1 = [NSTimer timerWithTimeInterval:(((float)theSettings.durration)/1000) target:self selector:@selector(hideToast:) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:timer1 forMode:NSDefaultRunLoopMode];

    [window addSubview:v];
    
    view_ = [v retain];

    [v addTarget:self action:@selector(hideToast:) forControlEvents:UIControlEventTouchDown];
}

- (void)hideToast:(NSTimer *)theTimer {
    
    [UIView beginAnimations:nil context:NULL];
    view_.alpha = 0;
    [UIView commitAnimations];
    
    NSTimer *timer2 = [NSTimer timerWithTimeInterval:500 target:self selector:@selector(hideToast:) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:timer2 forMode:NSDefaultRunLoopMode];
}

- (void)removeToast:(NSTimer *)theTimer {
    [view_ removeFromSuperview];
}


+ (XDToast *)makeText:(NSString *)text {
    XDToast *toast = [[[XDToast alloc] initWithText:text] autorelease];
    return toast;
}

- (XDToast *)setDuration:(NSInteger)duration {
    self.theSettings.durration = duration;
    return self;
}

- (XDToast *)setGravity:(XDToastGravity)gravity offsetLeft:(NSInteger)left offsetTop:(NSInteger)top {
    self.theSettings.gravity = gravity;
    offsetTop_ = top;
    offsetLeft_ = left;
    return self;
}

- (XDToast *)setGravity:(XDToastGravity)gravity {
    self.theSettings.gravity = gravity;
    return self;
}

- (XDToast *)setPostion:(CGPoint)position {
    self.theSettings.position = CGPointMake(position.x, position.y);
    return self;
}

- (XDToastSettings *)theSettings {
    if(!settings_) {
        settings_ = [[XDToastSettings getSharedSettings] copy];
    }
    return settings_;
}

- (XDToast *)setGravity:(XDToastGravity)gravity offsetTop:(NSInteger)top {
    self.theSettings.gravity = gravity;
    offsetTop_ = top;
    return self;
}

@end

@implementation XDToastSettings
@synthesize durration = duration_;
@synthesize gravity = gravity_;
@synthesize position = position_;
@synthesize images = images_;

- (void)setImage:(UIImage *)img forType:(XDToastType)type {
    if(!images_) {
        images_ = [[NSMutableDictionary alloc] initWithCapacity:4];
    }
    if(img) {
        NSString *key = [NSString stringWithFormat:@"%i",type];
        [images_ setValue:img forKey:key];
    }
}

+ (XDToastSettings *)getSharedSettings {
    if(!sharedSettings) {
        sharedSettings = [[XDToastSettings alloc] init];
        sharedSettings.gravity = XDToastGravityBottom; //XDToastGravityCenter;
        sharedSettings.durration = XDToastDurationShort;
    }
    
    return sharedSettings;
}

- (id)copyWithZone:(NSZone *)zone {
    XDToastSettings *copy = [[XDToastSettings alloc] init];
    copy.gravity = self.gravity;
    copy.durration = self.durration;
    copy.position = self.position;
    NSArray *keys = [self.images allKeys];
    for(NSString *key in keys) {
        [copy setImage:[images_ valueForKey:key] forType:[key intValue]];
    }
    return copy;
}

@end


