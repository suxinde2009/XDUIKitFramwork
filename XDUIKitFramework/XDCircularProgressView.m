//
//  XDCircularProgressView.m
//  XDUIKitFramework
//
//  Created by admin on 12-8-15.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import "XDCircularProgressView.h"

#define DEGREES_2_RADIANS(x) (0.0174532925 * (x))

@interface XDCircularProgressView ()
- (void)commonInit;
@end

@implementation XDCircularProgressView

@synthesize trackTintColor = trackTintColor_;
@synthesize progressTintColor = progressTintColor_;
@synthesize progress = progress_;


- (void)commonInit
{
    animated = FALSE;
    self.backgroundColor = [UIColor clearColor];
    timer = [[NSTimer scheduledTimerWithTimeInterval:0.02
                                              target:self
                                            selector:@selector(progressChange)
                                            userInfo:nil
                                             repeats:YES] retain];
}

- (id)init
{
    self = [super initWithFrame:CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)];
    if(self){
        [self commonInit];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        [self commonInit];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGPoint centerPoint = CGPointMake(rect.size.width/2, rect.size.height/2);
    CGFloat radius = MIN(rect.size.height, rect.size.width)/2.0f;
    
    CGFloat pathWidth = radius * 0.3f;
    
    CGFloat radians = DEGREES_2_RADIANS((self.progress*350.5)-90);
    CGFloat xOffset = radius*(1 + 0.85*cosf(radians));
    CGFloat yOffset = radius*(1 + 0.85*sinf(radians));
    CGPoint endPoint = CGPointMake(xOffset, yOffset);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [self.trackTintColor setFill];
    
    CGMutablePathRef trackPath = CGPathCreateMutable();
    CGPathMoveToPoint(trackPath, NULL, centerPoint.x, centerPoint.y);
    CGPathAddArc(trackPath, NULL, centerPoint.x, centerPoint.y, radius, DEGREES_2_RADIANS(270), DEGREES_2_RADIANS(-90), NO);
    CGPathCloseSubpath(trackPath);
    CGContextAddPath(context, trackPath);
    CGContextFillPath(context);
    CGPathRelease(trackPath);
    
    [self.progressTintColor setFill];
    CGMutablePathRef progressPath = CGPathCreateMutable();
    CGPathMoveToPoint(progressPath, NULL, centerPoint.x, centerPoint.y);
    CGPathAddArc(progressPath, NULL, centerPoint.x, centerPoint.y, radius, DEGREES_2_RADIANS(270), radians, NO);
    CGPathCloseSubpath(progressPath);
    CGContextAddPath(context, progressPath);
    CGContextFillPath(context);
    CGPathRelease(progressPath);
    
    CGContextAddEllipseInRect(context, CGRectMake(centerPoint.x - pathWidth/2.0f, 0.0f, pathWidth, pathWidth));
    CGContextFillPath(context);
    
    CGContextAddEllipseInRect(context, CGRectMake(endPoint.x - pathWidth/2.0f, endPoint.y-pathWidth/2.0f, pathWidth, pathWidth));
    CGContextFillPath(context);
    
    CGContextSetBlendMode(context, kCGBlendModeClear);
    CGFloat innerRadius = radius * 0.7;
    CGPoint newCenterPoint = CGPointMake(centerPoint.x - innerRadius, centerPoint.y - innerRadius);
    CGContextAddEllipseInRect(context, CGRectMake(newCenterPoint.x, newCenterPoint.y, innerRadius*2, innerRadius*2));
    CGContextFillPath(context);
    
}


- (void)progressChange
{
    if(animated){
        self.progress += 0.01;
        
        if (self.progress > 1.0f)
        {
            self.progress = 0.0f;
        }
    }
}

#pragma mark - Property methods
- (void)setAnimated:(BOOL)_animated{
    animated = _animated;
}

- (UIColor *)trackTintColor {
    if(!trackTintColor_){
        trackTintColor_ = [[UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.3f] retain];
    }
    return trackTintColor_;
}

- (UIColor *)progressTintColor {
    if(!progressTintColor_) {
        progressTintColor_ = [[UIColor whiteColor] retain];
    }
    return progressTintColor_;
}

- (void)setProgress:(float)progress {
    progress_ = progress;
    [self setNeedsDisplay];
}

#pragma mark - dealloc
- (void)dealloc {
    if(timer){
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [trackTintColor_ release];
    [progressTintColor_ release];
    [super dealloc];
}


@end
