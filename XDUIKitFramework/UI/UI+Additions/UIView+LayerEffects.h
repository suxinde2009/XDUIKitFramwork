//
//  UIView+LayerEffects.h
//  XDUIKitFramework
//
//  Created by admin on 12-8-16.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LayerEffects)

// set round corner
- (void)setCornetRadius:(CGFloat)radius;

// set inner border
- (void)setBorder:(UIColor *)color width:(CGFloat)width;

// set the shadow
- (void)setShadow:(UIColor *)color opacity:(CGFloat)opacity offset:(CGSize)offset blurRadius:(CGFloat)blurRadius;

@end
