//
//  UIColor+XDCategory.h
//  XDUIKitFramework
//
//  Created by admin on 12-8-18.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import <UIKit/UIKit.h>


#define UIColorMakeRGBA(nRed, nGreen, nBlue, nAlpha) [UIColor colorWithRed:(nRed)/255.0f \
                                                                     green:(nGreen)/255.0f \
                                                                      blue:(nBlue)/255.0f \
                                                                     alpha:nAlpha]

#define UIColorMakeRGB(nRed, nGreen, nBlue) UIColorMakeRGBA(nRed, nGreen, nBlue, 1.0f)

@interface UIColor (XDCategory)

+ (id)colorWithHex:(NSUInteger)hexValue;
+ (id)colorWithHex:(NSUInteger)hexValue alpha:(CGFloat)alpha;


@end
