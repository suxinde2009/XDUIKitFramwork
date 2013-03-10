//
//  XDCloseButton.m
//  DrawingAndAnimationDemo
//
//  Created by XD.Su on 12-9-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "XDCloseButton.h"

#define DEGREES_2_RADIANS(x) (0.0174532925 * (x))

@interface XDCloseButton ()
- (void)buildView;
@end

@implementation XDCloseButton

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]){
        [self buildView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildView];
    }
    return self;
}

- (void)setBackgroundFillColor:(UIColor *)backgroundColor
{
    if(_backgorundFillColor){
        [_backgorundFillColor release];
        _backgorundFillColor = nil;
    }
    _backgorundFillColor = [backgroundColor retain];
}

- (void)setBorderColor:(UIColor *)borderColor
{
    if(_borderColor){
        [_borderColor release];
        _borderColor = nil;
    }
    _borderColor = [borderColor retain];
}

- (void)setHighlightColor:(UIColor *)highlightColor
{
    if(_highlightColor){
        [_highlightColor release];
        _highlightColor = nil;
    }
    _highlightColor = [highlightColor retain];
}

- (void)drawRect:(CGRect)rect
{
   
    CGPoint centerPoint = CGPointMake(rect.size.width/2, rect.size.height/2);
    CGFloat radius = MIN(rect.size.height, rect.size.width)/2.0f;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 设置边框颜色
    [_borderColor setFill];
    CGMutablePathRef trackPath = CGPathCreateMutable();
    CGPathMoveToPoint(trackPath, NULL, centerPoint.x, centerPoint.y);
    CGPathAddArc(trackPath, NULL, centerPoint.x, centerPoint.y, radius, DEGREES_2_RADIANS(270), DEGREES_2_RADIANS(-90), NO);
    CGPathCloseSubpath(trackPath);
    CGContextAddPath(context, trackPath);
    CGContextFillPath(context);
    CGPathRelease(trackPath);
    
    // 填充背景颜色
    if(_isHightLighted){
        
        [_highlightColor setFill];
        trackPath = CGPathCreateMutable();
        CGPathMoveToPoint(trackPath, NULL, centerPoint.x, centerPoint.y);
        CGPathAddArc(trackPath, NULL, centerPoint.x, centerPoint.y, radius-1.0f, DEGREES_2_RADIANS(270), DEGREES_2_RADIANS(-90), NO);
        CGPathCloseSubpath(trackPath);
        CGContextAddPath(context, trackPath);
        CGContextFillPath(context);
        CGPathRelease(trackPath);
        
    }else{
        
        [_backgorundFillColor setFill];
        trackPath = CGPathCreateMutable();
        CGPathMoveToPoint(trackPath, NULL, centerPoint.x, centerPoint.y);
        CGPathAddArc(trackPath, NULL, centerPoint.x, centerPoint.y, radius-1.0f, DEGREES_2_RADIANS(270), DEGREES_2_RADIANS(-90), NO);
        CGPathCloseSubpath(trackPath);
        CGContextAddPath(context, trackPath);
        CGContextFillPath(context);
        CGPathRelease(trackPath);
        
    }
    
    // 打个叉叉
    [[UIColor whiteColor] set]; 
    CGContextSetLineWidth(context, 5.0f); 
    CGContextMoveToPoint(context, centerPoint.x-radius/2.0f, centerPoint.y-radius/2.0f); 
    CGContextAddLineToPoint(context, centerPoint.x, centerPoint.y);
    CGContextMoveToPoint(context, centerPoint.x-radius/2.0f, centerPoint.y+radius/2.0f);
    CGContextAddLineToPoint(context, centerPoint.x, centerPoint.y); 
    CGContextMoveToPoint(context, centerPoint.x+radius/2.0f, centerPoint.y-radius/2.0f);
    CGContextAddLineToPoint(context, centerPoint.x, centerPoint.y); 
    CGContextMoveToPoint(context, centerPoint.x+radius/2.0f, centerPoint.y+radius/2.0f);
    CGContextAddLineToPoint(context, centerPoint.x, centerPoint.y); 
    CGContextStrokePath(context); //用当前图形上下文的颜色填充线条

    
}

#pragma mark -
- (void)buildView
{
    self.backgroundColor = [UIColor clearColor];
    _isHightLighted = FALSE;
    _backgorundFillColor = [[UIColor blackColor] retain];
    _borderColor = [[UIColor whiteColor] retain];
    _highlightColor = [[UIColor colorWithRed:0.0 green:0.290 blue:0.940 alpha:1.0] retain];
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

- (void)dealloc
{
    [_highlightColor release];
    [_backgorundFillColor release];
    [_borderColor release];
    [super dealloc];
}

@end
