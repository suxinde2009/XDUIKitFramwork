//
//  UIView+kCategory.m
//  XDUIKitFramework
//
//  Created by admin on 12-8-13.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import "UIView+kCategory.h"
#import <QuartzCore/QuartzCore.h>

CGPoint demoLGStart(CGRect bounds) {
    return CGPointMake(bounds.origin.x, bounds.origin.y+bounds.size.height*0.25);
}

CGPoint demoLGEnd(CGRect bounds) {
    return CGPointMake(bounds.origin.x, bounds.origin.y+bounds.size.height*0.75);
}

CGPoint demoRGCenter(CGRect bounds) {
    return CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
}

CGFloat demoRGInnerRadius(CGRect bounds) {
    CGFloat r = bounds.size.width < bounds.size.height ? bounds.size.width :bounds.size.height;
    return r*0.125;
}

@implementation UIView (kCategory)

- (UIViewController*)viewController {
    for(UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

+ (void)drawGradientInRect:(CGRect)rect withColors:(NSArray *)colors {
    NSMutableArray *array = [NSMutableArray array];
    for(UIColor *color in colors) {
        [array addObject:(id)color.CGColor];
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)array, NULL);
    
    CGContextClipToRect(context, rect);
    
    CGPoint start = CGPointMake(0.0f, 0.0f);
    CGPoint ent = CGPointMake(0.0f, rect.size.height);
    
    CGContextDrawLinearGradient(context, gradient, start, ent, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    
}

+ (void)drawLinearGradientInRect:(CGRect)rect colors:(CGFloat [])colors {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(rgbColorSpace, colors, NULL, 2);
    CGColorSpaceRelease(rgbColorSpace);
    
    CGPoint startPoint = demoLGStart(rect);
    CGPoint endPoint = demoLGEnd(rect);
    
    CGContextClipToRect(context, rect);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    CGGradientRelease(gradient);

    CGContextRestoreGState(context);
    
}

+ (void)drawRoundRectangleInRect:(CGRect)rect withRadius:(CGFloat)radius {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect rrect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    
    CGFloat minX = CGRectGetMinX(rrect), midX = CGRectGetMidX(rrect), maxX = CGRectGetMaxX(rrect);
    CGFloat minY = CGRectGetMinY(rrect), midY = CGRectGetMidY(rrect), maxY = CGRectGetMaxY(rrect);
    
    CGContextMoveToPoint(context, minX, midY);
    CGContextAddArcToPoint(context, minX, minY, midX, minY, radius);
    CGContextAddArcToPoint(context, maxX, minY, maxX, midY, radius);
    CGContextAddArcToPoint(context, maxX, maxY, midX, maxY, radius);
    CGContextAddArcToPoint(context, minX, maxY, minX, midY, radius);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill);
    
}

+ (void)drawLineInRect:(CGRect)rect red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    CGFloat colors[4];
    colors[0] = red;
    colors[1] = green;
    colors[2] = blue;
    colors[3] = alpha;
    [UIView drawLineInRect:rect colors:colors];
}

+ (void)drawLineInRect:(CGRect)rect colors:(CGFloat [])colors {
    [UIView drawLineInRect:rect colors:colors width:1 cap:kCGLineCapButt];
}

+ (void)drawLineInRect:(CGRect)rect colors:(CGFloat [])colors width:(CGFloat)lineWidth cap:(CGLineCap)cap {

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextSetRGBStrokeColor(context, colors[0], colors[1], colors[2], colors[3]);
    CGContextSetLineCap(context, cap);
    CGContextSetLineWidth(context, lineWidth);
    
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
    CGContextAddLineToPoint(context, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
    CGContextStrokePath(context);
    
    CGContextRestoreGState(context);
    
}


@end

