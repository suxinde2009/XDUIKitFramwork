//
//  XDGlossyButton.m
//  XDUIKitFramework
//
//  Created by admin on 12-8-14.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import "XDGlossyButton.h"
#import <QuartzCore/QuartzCore.h>

static void RetinaAwareUIGraphicsBeginImageContext(CGSize size) {
    static CGFloat scale = -1.0;
    if(scale < 0.0) {
        UIScreen *screen = [UIScreen mainScreen];
        if([[[UIDevice currentDevice] systemName] floatValue] >= 4.0){
            scale = [screen scale];
        }else {
            scale = 0.0;
        }
    }
    if(scale>0.0){
        UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    }else {
        UIGraphicsBeginImageContext(size);
    }
}


@implementation UIButton (XDGlossyButton)

- (void)useWhiteLabel:(BOOL)dimOnClickedOrDisabled {
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIColor *dimColor = nil;
    if(dimOnClickedOrDisabled) dimColor = [UIColor lightGrayColor];
    [self setTitleColor:dimColor forState:UIControlStateDisabled];
    [self setTitleColor:dimColor forState:UIControlStateHighlighted];
}

- (void)useBlackLabel:(BOOL)dimOnClickedOrDisabled {
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIColor *dimColor = nil;
    if(dimOnClickedOrDisabled) dimColor = [UIColor darkGrayColor];
    [self setTitleColor:dimColor forState:UIControlStateDisabled];
    [self setTitleColor:dimColor forState:UIControlStateHighlighted];
}

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

@implementation UIColor (XDGlossyButton)

+ (UIColor *)doneButtonColor {
    return [UIColor colorWithRed:34.0f/255.0f green:96.0f/255.0f blue:221.0f/255.0f alpha:1.0f];
}

+ (UIColor *)navigationBarButtonColor {
    return [UIColor colorWithRed:72.0f/255.0f green:106.0f/255.0f blue:154.0f/255.0f alpha:1.0f];
}

@end


@interface XDGlossyButton ()

- (void)drawTintColorButton:(CGContextRef)context tintColor:(UIColor *)tintColor isSelectd:(BOOL)isSelected;
- (void)strokeButton:(CGContextRef)context color:(UIColor *)color isSelected:(BOOL)isSelected;

@end

@implementation XDGlossyButton

@synthesize tintColor = _tintColor;
@synthesize disabledColor = _disabledColor;
@synthesize buttonCornerRadius = _buttonCornerRadius;
@synthesize borderColor = _borderColor;
@synthesize disabledBorderColor = _disabledBorderColor;
@synthesize innerBorderWidth = _innerBorderWidth;
@synthesize buttonBorderWidth = _buttonBorderWidth;
@synthesize strokeType = _strokeType;
@synthesize extraShadingType = _extraShadingType;
@synthesize backgroundOpacity = _backgroundOpacity;
@synthesize buttonInsets = _buttonInsets;
@synthesize invertGradientOnSelected = _invertGradientOnSelected;


- (void)setup {
    _buttonCornerRadius = 4.0f;
    _innerBorderWidth = 1.0f;
    _buttonBorderWidth = 1.0f;
    _backgroundOpacity = 1.0f;
    _buttonInsets = UIEdgeInsetsZero;
    [self setGradientType:XDGlossyButtonGradientTypeLinearSmoothStandard];
    [self addObserver:self forKeyPath:@"highlighted" options:0 context:nil];
    [self addObserver:self forKeyPath:@"enabled" options:0 context:nil];
}


- (id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]){
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"highlighted"];
    [self removeObserver:self forKeyPath:@"enabled"];
    
#if !__has_feature(objc_arc)
    self.tintColor = nil;
    self.disabledColor = nil;
    self.borderColor = nil;
	self.disabledColor = nil;
    [super dealloc];
#endif
    
}


#pragma mark -
- (void)setGradientType:(XDGlossyButtonGradientType)type {
    
    switch (type) {
        case XDGlossyButtonGradientTypeLinearSmoothStandard:
        {
            static const CGFloat g0[] = {0.5f, 1.0f, 0.35f, 1.0f};
            backgroundGradient = g0;
            locations = nil;
            numberOfColorsInGradient = 2;
        }
            break;
        case XDGlossyButtonGradientTypeLinearSmoothBrightToNormal:
        {
            static const CGFloat g0[] = {0.9f, 1.0f, 0.5f, 1.0f, 0.5f, 1.0f};
            static const CGFloat l0[] = {0.0f, 0.7f, 1.0f};
            backgroundGradient = g0;
            locations = l0;
            numberOfColorsInGradient = 3;
        }
            break;
        case XDGlossyButtonGradientTypeLinearSmoothExtreme:
        {
            static const CGFloat g0[] = {0.8f, 1.0f, 0.2f, 1.0f};
            backgroundGradient = g0;
            locations = nil;
            numberOfColorsInGradient = 2;
        }
            break;
        case XDGlossyButtonGradientTypeLinearGlossyStandard:
        {
            static const CGFloat g0[] = {0.7f, 1.0f, 0.6f, 1.0f, 0.5f, 1.0f, 0.45f, 1.0f};
            static const CGFloat l0[] = {0.0f, 0.47f, 0.53f, 1.0f};
            backgroundGradient = g0;
            locations = l0;
            numberOfColorsInGradient = 4;
        }
            break;
        case XDGlossyButtonGradientTypeSolid:
        {
            static const CGFloat g0[] = {0.5f, 1.0f, 0.5f, 1.0f};
            backgroundGradient = g0;
            locations = nil;
            numberOfColorsInGradient = 2;
        }
            break;
            
        default:
            break;
    }

}

- (UIBezierPath *)pathForButton:(CGFloat)inset {
    CGFloat radius = _buttonCornerRadius - inset;
    if(radius<0.0f) radius = 0.0f;
    CGRect rr = UIEdgeInsetsInsetRect(self.bounds, _buttonInsets);
    return [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rr, inset, inset) cornerRadius:radius];
}


- (void)drawRect:(CGRect)rect
{
    UIColor *color = _tintColor;
    if(![self isEnabled]) {
        if(_disabledColor) color = _disabledColor;
        else color = [UIColor lightGrayColor];
    }
    if(color == nil) color = [UIColor whiteColor];
         
    //if the background is transparent, we draw on a image and copy the image to the context with alpha
    BOOL drawOnImage = _backgroundOpacity<1.0f;
    
    if(drawOnImage){
        RetinaAwareUIGraphicsBeginImageContext(self.bounds.size);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    BOOL isSelected = [self isHighlighted];
    CGContextSaveGState(context);
    if(_buttonBorderWidth > 0.0f){
        UIColor *color;
        if([self isEnabled])
            color = _borderColor;
        else {
            color = _disabledBorderColor;
            if(color==nil) color = _borderColor;
        }
        if(color == nil) color = [UIColor darkGrayColor];
        [self strokeButton:context color:color isSelected:isSelected];
    }
    
    [self drawTintColorButton:context tintColor:color isSelectd:isSelected];
    CGContextRestoreGState(context);
    
    if(drawOnImage) {
        UIImage *i = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [i drawAtPoint:CGPointZero blendMode:kCGBlendModeNormal alpha:_backgroundOpacity];
    }
    
    [super drawRect:rect];
}



#pragma mark KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"highlighted"] || [keyPath isEqualToString:@"enabled"]) {
        [self setNeedsDisplay];
    }
}


#pragma mark -
- (void)strokeButton:(CGContextRef)context color:(UIColor *)color isSelected:(BOOL)isSelected {
    switch (_strokeType) {
        case XDGlossyButtonStrokeTypeNone:
            break;
            
        case XDGlossyButtonStrokeTypeSolid:
        {
            //simple solid border
            CGContextAddPath(context, [self pathForButton:0.0f].CGPath);
            [color setFill];
            CGContextFillPath(context);
        }
            break;
            
        case XDGlossyButtonStrokeTypeGradientFrame:
            // solid border with gradient outer frame
        {
            CGRect rect = self.bounds;
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
            CGFloat strokeComponents[] = { 0.25f, 1.0f, 1.0f, 1.0f};
            UIBezierPath *outerPath = [self pathForButton:0.0f];
            CGContextAddPath(context, outerPath.CGPath);
            [color setFill];
            CGContextFillPath(context);
            
            // stroke the gradient in 1 pixels using overlay so tha t still keeep the stroke color
            CGContextSaveGState(context);
            CGContextAddPath(context, outerPath.CGPath);
            CGContextAddPath(context, [self pathForButton:1.0f].CGPath);
            CGContextEOClip(context);
            CGContextSetBlendMode(context, kCGBlendModeOverlay);
            
            CGGradientRef strokeGradient = CGGradientCreateWithColorComponents(colorSpace, strokeComponents, NULL, 2);
            CGContextDrawLinearGradient(context, strokeGradient, CGPointMake(0, CGRectGetMinY(rect)), CGPointMake(0, CGRectGetMaxY(rect)), 0);
            CGGradientRelease(strokeGradient);
            CGColorSpaceRelease(colorSpace);
            
        }    
            break;
            
        case XDGlossyButtonStrokeTypeInnerBevelDown:
        {
            CGContextSaveGState(context);
            CGPathRef path = [self pathForButton:0.0f].CGPath;
            CGContextAddPath(context, path);
            CGContextClip(context);
            [[UIColor colorWithWhite:0.9f alpha:1.0f] setFill];
            CGContextAddPath(context, path);
            CGContextFillPath(context);
            
            CGFloat highlightWidth = _buttonBorderWidth / 4.0f;
            if(highlightWidth<0.5f) {
                highlightWidth = 0.5f;
            }else if (highlightWidth>2.0f) {
                highlightWidth = 2.0f;
            }
            CGPathRef innerPath = [self pathForButton:highlightWidth].CGPath;
            CGContextTranslateCTM(context, 0.0f, -highlightWidth);
            [color setFill];
            CGContextAddPath(context, innerPath);
            CGContextFillPath(context);
            
            CGContextRestoreGState(context);
            
        }
            break;
        case XDGlossyButtonStrokeTypeBevelUp:
        {
            CGRect rect = self.bounds;
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
            
            const CGFloat *strokeComponents;
            const CGFloat *l0;
            if(_invertGradientOnSelected && isSelected) {
                const CGFloat s[] = {0.2f, 1.0f, 0.5f, 1.0f, 0.6f, 1.0f};
                const CGFloat l[] = {0.0f, 0.1f, 1.0f};
                strokeComponents = s;
                l0 = l;
            }else {
                const CGFloat s[] = {0.9f, 1.0f, 0.5f, 1.0f, 0.2f, 1.0f};
                const CGFloat l[] = {0.0f, 0.1f, 1.0f};
                strokeComponents = s;
                l0 = l;
            }
            
            CGContextAddPath(context, [self pathForButton:0.0f].CGPath);
            CGContextClip(context);
            
            CGGradientRef strokeGradient = CGGradientCreateWithColorComponents(colorSpace, strokeComponents, l0, 3);
            CGContextDrawLinearGradient(context, strokeGradient, CGPointMake(0, CGRectGetMinY(rect)), CGPointMake(0, CGRectGetMaxY(rect)), 0);
            CGGradientRelease(strokeGradient);
            CGColorSpaceRelease(colorSpace);
            
            [color set];
            UIRectFillUsingBlendMode(rect, kCGBlendModeOverlay);
            CGContextFillPath(context);
        }
            break;
        default:
            break;
    }
}

- (void)addShading:(CGContextRef)context type:(XDGlossyButtonExtraShadingType)type rect:(CGRect)rect colorSpace:(CGColorSpaceRef)colorSpace {

    switch (type) {
        case XDGlossyButtonExtraShadingTypeRounded:
        {
            CGPathRef shade = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(rect.origin.x, rect.origin.y-_buttonCornerRadius, rect.size.width, _buttonCornerRadius+rect.size.height/2.0f) cornerRadius:_buttonCornerRadius].CGPath;
            CGContextAddPath(context, shade);
            CGContextClip(context);
            const CGFloat strokeComponents[4] = {0.80f, 1.0f, 0.55f, 1.0f};
            CGGradientRef strokeGradient = CGGradientCreateWithColorComponents(colorSpace, strokeComponents, NULL, 2);
            CGContextDrawLinearGradient(context, strokeGradient, CGPointMake(0, CGRectGetMinY(rect)), CGPointMake(0, rect.origin.y+rect.size.height*.07f), 0);
        }
            break;
        case XDGlossyButtonExtraShadingTypeAngleLeft:
        {
            CGRect roundRect = CGRectMake(rect.origin.x-rect.size.width*2.0f, rect.origin.y-rect.size.height*3.33, rect.size.width*4.0f, rect.size.height*4.0f);
            CGContextAddEllipseInRect(context, roundRect);
            CGContextClip(context);
            const CGFloat strokeComponents[4] = {0.80f, 1.0f, 0.55f, 1.0f};
            CGGradientRef strokeGradient = CGGradientCreateWithColorComponents(colorSpace, strokeComponents, NULL, 2);
            CGContextDrawLinearGradient(context, strokeGradient, CGPointMake(rect.origin.x, rect.origin.y), CGPointMake(rect.origin.x+rect.size.width/2.0f, rect.origin.y+rect.size.height*0.7f), 0);
        }
            break;
        case XDGlossyButtonExtraShadingTypeAngleRight:
        {
            CGRect roundRect = CGRectMake(rect.origin.x-rect.size.width, rect.origin.y-rect.size.height*3.33, rect.size.width*4.0f, rect.size.height*4.0f);
            CGContextAddEllipseInRect(context, roundRect);
            CGContextClip(context);
            const CGFloat strokeComponents[4] = {0.80f, 1.0f, 0.55f, 1.0f};
            CGGradientRef strokeGradient = CGGradientCreateWithColorComponents(colorSpace, strokeComponents, NULL, 2);
            CGContextDrawLinearGradient(context, strokeGradient, CGPointMake(rect.origin.x+rect.size.width, rect.origin.y), CGPointMake(rect.origin.x + rect.size.width/2.0f, rect.origin.y+rect.size.height*0.7f), 0);
            CGGradientRelease(strokeGradient);
        
        }
            break;
        case XDGlossyButtonExtraShadingTypeNone:
            break;
        default:
            break;
    }

}


- (void)drawTintColorButton:(CGContextRef)context tintColor:(UIColor *)tintColor isSelectd:(BOOL)isSelected {

    CGRect rect = self.bounds;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    if(_innerBorderWidth>0.0f){
        
        // STROKE GRADIENT
        
        CGContextAddPath(context, [self pathForButton:_buttonBorderWidth].CGPath);
        CGContextClip(context);
        
        CGContextSaveGState(context);
        
        const CGFloat strokeComponents[4] = {0.55f, 1.0f, 0.40f, 1.0f};
        CGGradientRef strokeGradient = CGGradientCreateWithColorComponents(colorSpace, strokeComponents, NULL, 2);
        CGContextDrawLinearGradient(context, strokeGradient, CGPointMake(0, CGRectGetMinY(rect)), CGPointMake(0, CGRectGetMaxY(rect)), 0);
        CGGradientRelease(strokeGradient);
    }
    
    
    // FILL GRADIENT
    CGRect fillRect = CGRectInset(rect, _buttonBorderWidth+_innerBorderWidth, _buttonBorderWidth+_innerBorderWidth);
    CGContextAddPath(context, [self pathForButton:_buttonBorderWidth+_innerBorderWidth].CGPath);
    CGContextClip(context);
    
    CGGradientRef fillGradient = CGGradientCreateWithColorComponents(colorSpace, backgroundGradient, locations, numberOfColorsInGradient);
    if(_invertGradientOnSelected && isSelected) {
        CGContextDrawLinearGradient(context, fillGradient, CGPointMake(0, CGRectGetMaxY(fillRect)), CGPointMake(0, CGRectGetMinY(fillRect)), 0);
    }else {
        CGContextDrawLinearGradient(context, fillGradient, CGPointMake(0, CGRectGetMinY(fillRect)), CGPointMake(0, CGRectGetMaxY(fillRect)), 0);
    }
    CGGradientRelease(fillGradient);
    
    if(_extraShadingType != XDGlossyButtonStrokeTypeNone) {
    
        // add addtional glossy effect
        CGContextSaveGState(context);
        CGContextSetBlendMode(context, kCGBlendModeLighten);
        [self addShading:context type:_extraShadingType rect:fillRect colorSpace:colorSpace];
        CGContextRestoreGState(context);
        
    }
    CGColorSpaceRelease(colorSpace);
    
    if(_innerBorderWidth>0.0){
        CGContextRestoreGState(context);
    }
    [tintColor set];
    UIRectFillUsingBlendMode(rect, kCGBlendModeOverlay);
    
    if(isSelected) {
        [[UIColor lightGrayColor] set];
        UIRectFillUsingBlendMode(rect, kCGBlendModeMultiply);
    }
}

#pragma mark -
- (void)setActionSheetButtonColor:(UIColor *)color {
    
    self.tintColor = color;
    [self setGradientType:XDGlossyButtonGradientTypeLinearGlossyStandard];
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:17.0f]];
    [self useWhiteLabel:NO];
    self.buttonCornerRadius = 8.0f;
    self.strokeType = XDGlossyButtonStrokeTypeGradientFrame;
    self.buttonBorderWidth = 3.0f;
    self.borderColor = [UIColor colorWithWhite:0.2f alpha:0.8f];
    [self setNeedsDisplay];
}

- (void)setNavigationButtonColor:(UIColor *)color {
    self.tintColor = color;
    self.disabledBorderColor = [UIColor lightGrayColor];
    [self setGradientType:XDGlossyButtonGradientTypeLinearGlossyStandard];
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:12.0f]];
    [self useWhiteLabel:NO];
    [self setTitleColor:[UIColor colorWithWhite:0.5f alpha:1.0f] forState:UIControlStateDisabled];
    self.buttonCornerRadius = 4.0f;
    self.strokeType = XDGlossyButtonStrokeTypeInnerBevelDown;
    self.buttonBorderWidth = 1.0f;
    self.innerBorderWidth = 0.0f;
    [self setNeedsDisplay];
}

@end


@implementation XDGNavigationButton

@synthesize leftArrow = _leftArrow;

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
    
    if(_leftArrow) {
        CGRect rr1 = CGRectMake(arrowWidth+rr.origin.x+extraHeadInset, rr.origin.y, rr.size.width-arrowWidth-extraHeadInset, rr.size.height);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rr1 cornerRadius:radius];
        [path moveToPoint:CGPointMake(rr.origin.x+extraHeadInset, rr.origin.y+rr.size.height/2.0f)];
        [path addLineToPoint:CGPointMake(rr.origin.x+arrowWidth+radiusOffset+extraHeadInset, rr.origin.y+radiusOffset)];
        [path addLineToPoint:CGPointMake(rr.origin.x+arrowWidth+radiusOffset+extraHeadInset, rr.origin.y+rr.size.height-radiusOffset)];
        [path closePath];
        return path;
    }
    else {
        CGRect rr1 = CGRectMake(rr.origin.x, rr.origin.y, rr.size.width-arrowWidth-extraHeadInset, rr.size.height);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rr1 cornerRadius:radius];
        [path moveToPoint:CGPointMake(rr.origin.x+rr.size.width-extraHeadInset, rr.origin.y+rr.size.height/2.0f)];
        [path addLineToPoint:CGPointMake(rr.origin.x+rr.size.width-arrowWidth-radiusOffset-extraHeadInset, rr.origin.y+rr.size.height-radiusOffset)];
        [path addLineToPoint:CGPointMake(rr.origin.x+rr.size.width-arrowWidth-radiusOffset-extraHeadInset, rr.origin.y+radiusOffset)];
        [path closePath];
        return path;
    }
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect {

    CGFloat arrowWidth = round(self.bounds.size.height*0.30f);
    if(_leftArrow){
        contentRect.origin.x += arrowWidth;
        contentRect.size.width -= arrowWidth;
    }else {
        contentRect.size.width -= arrowWidth;
    }
    return [super titleRectForContentRect:contentRect];
    
}

@end



@implementation XDGBadgeButton
        
@synthesize numberOfEdges = _numberOfEdges;
@synthesize innerRadiusRatio = _innerRadiusRatio;

- (void)setup {
    [super setup];
    _numberOfEdges = 24;
    _innerRadiusRatio = 0.75f;
}

- (UIBezierPath *)pathForButton:(CGFloat)inset {
    CGRect bounds = UIEdgeInsetsInsetRect(self.bounds, _buttonInsets);
    CGPoint center = CGPointMake(bounds.size.width/2.0f, bounds.size.height/2.0f);
    CGFloat outerRadius = MIN(bounds.size.width, bounds.size.height)/2.0f - inset;
    CGFloat innerRadius = outerRadius * _innerRadiusRatio;
    CGFloat angle = M_PI*2.0f/(_numberOfEdges*2);
    UIBezierPath *path = [UIBezierPath bezierPath];
    for(NSInteger cc = 0; cc < _numberOfEdges; cc++){
        CGPoint p0 = CGPointMake(center.x + outerRadius * cos(angle * (cc*2)), center.y + outerRadius * sin(angle * (cc*2)));
        CGPoint p1 = CGPointMake(center.x + innerRadius * cos(angle * (cc*2+1)), center.y + innerRadius * sin(angle * (cc*2+1)));
        
        if(cc == 0) {
            [path moveToPoint:p0];
        }else {
            [path addLineToPoint:p0];
        }
        [path addLineToPoint:p1];
        
        
    }
    [path closePath];
    return path;
}

@end