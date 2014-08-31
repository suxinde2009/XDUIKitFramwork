//
//  XDCircularProgressView.h
//  XDUIKitFramework
//
//  Created by admin on 12-8-15.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

////////////////////////////////////////////////////////////////
// 
// 原作者： Daniel Amitay
// 出处：   https://github.com/danielamitay/DACircularProgress
//
// 改写原因：原来的类使用了ARC，对iOS 5.0以下版本不兼容，将其改写为手动内存管理
//
////////////////////////////////////////////////////////////////

#import <UIKit/UIKit.h>

@interface XDCircularProgressView : UIView
{
    NSTimer *timer;
    BOOL     animated;
}
@property (nonatomic, retain) UIColor *trackTintColor;
@property (nonatomic, retain) UIColor *progressTintColor;
@property (nonatomic) float progress;

- (void)setProgress:(float)progress;
- (void)setAnimated:(BOOL)animated;

@end

