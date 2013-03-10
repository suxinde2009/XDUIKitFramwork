//
//  XDBlueButton.m
//  DrawingAndAnimationDemo
//
//  Created by XD.Su on 12-9-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "XDBlueButton.h"

#import <QuartzCore/QuartzCore.h>

@interface XDBlueButton ()
- (void)reLayout;
- (void) drawGradientInRect:(CGRect)rect withColors:(NSArray*)colors;
- (UIBezierPath *)pathForButton:(CGFloat)inset;
@end

@implementation XDBlueButton
@synthesize blueButtonType = _blueButtonType;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]){
        [self setBlueButtonType:XDBlueButtonTypeRoundRect];
    }
    return  self;
}

- (id)initWithFrame:(CGRect)frame 
{
    if(self = [super initWithFrame:frame]){
        [self setBlueButtonType:XDBlueButtonTypeRoundRect];
    }
    return  self;
}

- (id)init
{
    if(self = [super init]){
        self.frame = CGRectZero;
        [self setBlueButtonType:XDBlueButtonTypeRoundRect];
    }
    return self;
}

- (void)setBlueButtonType:(XDBlueButtonType)blueButtonType
{
    _blueButtonType = blueButtonType;
    [self reLayout];
}


- (void)drawRect:(CGRect)rect
{
    NSArray *colors = nil;
    
    if(!_isHightLighted){
        UIColor *color1 = [UIColor colorWithRed:85.0/255.0 green:150.0/255.0 blue:245.0/255.0 alpha:1.0];
        UIColor *color2 = [UIColor colorWithRed:45.0/255.0 green:120.0/255.0 blue:215.0/255.0 alpha:1.0];
        UIColor *color3 = [UIColor colorWithRed:0.0/255.0 green:90.0/255.0 blue:185.0/255.0 alpha:1.0];
        colors = [NSArray arrayWithObjects:color1,color2,color3, nil];
    }else{
        UIColor *color1 = [UIColor colorWithRed:50.0/255.0 green:80.0/255.0 blue:130.0/255.0 alpha:1.0];
        UIColor *color2 = [UIColor colorWithRed:20.0/255.0 green:60.0/255.0 blue:115.0/255.0 alpha:1.0];
        UIColor *color3 = [UIColor colorWithRed:0.0/255.0 green:50.0/255.0 blue:100.0/255.0 alpha:1.0];
        colors = [NSArray arrayWithObjects:color1,color2,color3, nil];
    }
    
    [self drawGradientInRect:rect withColors:colors];
}

- (void) drawGradientInRect:(CGRect)rect withColors:(NSArray*)colors
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    // Clip the context
    UIBezierPath *bezierPath = [self pathForButton:0.0f];
    CGPathRef path = bezierPath.CGPath;
    CGContextAddPath(context, path);
    CGContextClip(context);
    
    // Gradient Code
	NSMutableArray *ar = [NSMutableArray array];
	for(UIColor *c in colors){
		[ar addObject:(id)c.CGColor];
	}
    
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
	CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);

	CGPoint start = CGPointMake(0.0, 0.0);
	CGPoint end = CGPointMake(0.0, rect.size.height);
	
	CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
	
	CGGradientRelease(gradient);
    CGContextRestoreGState(context);

}
 
- (void)reLayout
{
    _isHightLighted = FALSE;
    _borderColor = [[UIColor colorWithRed:72.0f green:72.0f blue:72.0f alpha:1.0f] retain];
    _buttonCornerRadius = 10.0f;
    _buttonInsets = UIEdgeInsetsZero;
    
    [self addTarget:self action:@selector(addHighlight) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(removeHighlight) forControlEvents:UIControlEventTouchCancel|UIControlEventTouchUpInside|UIControlEventTouchUpOutside];
}

- (void)addHighlight
{
    _isHightLighted = TRUE;
    [self setNeedsDisplay];
}

- (void)removeHighlight
{
    _isHightLighted = FALSE;
    [self setNeedsDisplay];
}


- (UIBezierPath *)pathForButton:(CGFloat)inset{
    CGRect bounds = UIEdgeInsetsInsetRect(self.bounds, _buttonInsets);
    CGRect rr = CGRectInset(bounds, inset, inset);
    CGFloat radius = _buttonCornerRadius - inset;
    if(radius<0.0f){
        radius = 0.0f;
    }
    CGFloat arrowWidth = round(bounds.size.height*0.30f);
    CGFloat radiusOffset = 0.29289321 * radius;
    CGFloat extraHeadInset = 0.01118742 * inset;
    
    if(_blueButtonType == XDBlueButtonTypeLeftArrow) {
        
        CGRect rr1 = CGRectMake(arrowWidth+rr.origin.x+extraHeadInset, rr.origin.y, rr.size.width-arrowWidth-extraHeadInset, rr.size.height);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rr1 cornerRadius:radius];
        [path moveToPoint:CGPointMake(rr.origin.x+extraHeadInset, rr.origin.y+rr.size.height/2.0f)];
        [path addLineToPoint:CGPointMake(rr.origin.x+arrowWidth+radiusOffset+extraHeadInset, rr.origin.y+radiusOffset)];
        [path addLineToPoint:CGPointMake(rr.origin.x+arrowWidth+radiusOffset+extraHeadInset, rr.origin.y+rr.size.height-radiusOffset)];
        [path closePath];
        return path;
        
    }else if(_blueButtonType == XDBlueButtonTypeRightArrow) {
        
        CGRect rr1 = CGRectMake(rr.origin.x, rr.origin.y, rr.size.width-arrowWidth-extraHeadInset, rr.size.height);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rr1 cornerRadius:radius];
        [path moveToPoint:CGPointMake(rr.origin.x+rr.size.width-extraHeadInset, rr.origin.y+rr.size.height/2.0f)];
        [path addLineToPoint:CGPointMake(rr.origin.x+rr.size.width-arrowWidth-radiusOffset-extraHeadInset, rr.origin.y+rr.size.height-radiusOffset)];
        [path addLineToPoint:CGPointMake(rr.origin.x+rr.size.width-arrowWidth-radiusOffset-extraHeadInset, rr.origin.y+radiusOffset)];
        [path closePath];
        return path;
        
    }else {
        
        CGRect rr = UIEdgeInsetsInsetRect(self.bounds, _buttonInsets);
        return [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rr, inset, inset) cornerRadius:radius];
        
    }
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGFloat arrowWidth = round(self.bounds.size.height*0.30f);
    if(_blueButtonType == XDBlueButtonTypeLeftArrow){
        contentRect.origin.x += arrowWidth;
        contentRect.size.width -= arrowWidth;
    }else if(_blueButtonType == XDBlueButtonTypeRightArrow) {
        contentRect.size.width -= arrowWidth;
    }
    return [super titleRectForContentRect:contentRect];
    
}

@end

