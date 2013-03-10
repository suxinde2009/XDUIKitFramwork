//
//  UIView+LayerEffects.m
//  XDUIKitFramework
//
//  Created by admin on 12-8-16.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import "UIView+LayerEffects.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (LayerEffects)

- (void)setCornetRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
}


- (void)setBorder:(UIColor *)color width:(CGFloat)width {
    self.layer.borderColor = [color CGColor];
    self.layer.borderWidth = width;
}

- (void)setShadow:(UIColor *)color opacity:(CGFloat)opacity offset:(CGSize)offset blurRadius:(CGFloat)blurRadius {
    CALayer *layer = self.layer;
    layer.shadowColor = [color CGColor];
    layer.shadowOpacity = opacity;
    layer.shadowOffset = offset;
    layer.shadowRadius = blurRadius;
}

@end
