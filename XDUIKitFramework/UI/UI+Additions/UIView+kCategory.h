//
//  UIView+kCategory.h
//  XDUIKitFramework
//
//  Created by admin on 12-8-13.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (kCategory)

/**
 * The view controller whose view contains this view.
 */
- (UIViewController*)viewController;


// draw gradient
+ (void)drawGradientInRect:(CGRect)rect withColors:(NSArray *)colors;
+ (void)drawLinearGradientInRect:(CGRect)rect colors:(CGFloat [])colors;

// draw roundrect
+ (void)drawRoundRectangleInRect:(CGRect)rect withRadius:(CGFloat)radius;

// draw line
+ (void)drawLineInRect:(CGRect)rect red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+ (void)drawLineInRect:(CGRect)rect colors:(CGFloat [])colors;
+ (void)drawLineInRect:(CGRect)rect colors:(CGFloat [])colors width:(CGFloat)lineWidth cap:(CGLineCap)cap;


@end
