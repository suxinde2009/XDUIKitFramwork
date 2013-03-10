//
//  UIColor+XDCategory.m
//  XDUIKitFramework
//
//  Created by admin on 12-8-18.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import "UIColor+XDCategory.h"

@implementation UIColor (XDCategory)

+ (id)colorWithHex:(NSUInteger)hexValue
{
    return [UIColor colorWithHex:hexValue alpha:1.0f];
}

+ (id)colorWithHex:(NSUInteger)hexValue alpha:(CGFloat)alpha
{
    CGFloat red = ((CGFloat)((hexValue & 0xFF000) >> 16))/255.0f;
    CGFloat green = ((CGFloat)((hexValue & 0xFF00) >> 8))/255.0f;
    CGFloat blue = ((CGFloat)((hexValue & 0xFF)))/255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


@end
