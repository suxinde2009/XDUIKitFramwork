//
//  XDGlossyButton.h
//  XDUIKitFramework
//
//  Created by admin on 12-8-14.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+LayerEffects.h"

@interface UIButton (XDGlossyButton)

- (void)useWhiteLabel:(BOOL)dimOnClickedOrDisabled;
- (void)useBlackLabel:(BOOL)dimOnClickedOrDisabled;

// set round corner
- (void)setCornetRadius:(CGFloat)radius;

// set inner border
- (void)setBorder:(UIColor *)color width:(CGFloat)width;

// set the shadow
- (void)setShadow:(UIColor *)color opacity:(CGFloat)opacity offset:(CGSize)offset blurRadius:(CGFloat)blurRadius;

@end

@interface UIColor (XDGlossyButton)

+ (UIColor *)doneButtonColor;
+ (UIColor *)navigationBarButtonColor;

@end


typedef enum {
    XDGlossyButtonGradientTypeLinearSmoothStandard = 0, // general vertical linear gradient, normal to little dark
    XDGlossyButtonGradientTypeLinearGlossyStandard,     // iOS like glossy effect
    XDGlossyButtonGradientTypeLinearSmoothExtreme,      // very bright to very dim
    XDGlossyButtonGradientTypeLinearSmoothBrightToNormal, // plain solid
    XDGlossyButtonGradientTypeSolid
}XDGlossyButtonGradientType;

typedef enum {
    XDGlossyButtonStrokeTypeNone = 0,
    XDGlossyButtonStrokeTypeSolid,         // simple solid color
    XDGlossyButtonStrokeTypeInnerBevelDown, // draw bevel down effect (navigation bar button)
    XDGlossyButtonStrokeTypeGradientFrame, // frame a 1 pixel b/w gradient(default delete button)
    XDGlossyButtonStrokeTypeBevelUp // stroke bevel using button color
}XDGlossyButtonStrokeType;


typedef enum {
    XDGlossyButtonExtraShadingTypeNone = 0, // no extra shading
    XDGlossyButtonExtraShadingTypeRounded,  // rounded shading, shading radius = button corner radius
    XDGlossyButtonExtraShadingTypeAngleLeft,
    XDGlossyButtonExtraShadingTypeAngleRight
}XDGlossyButtonExtraShadingType;


@interface XDGlossyButton : UIButton {

@private
    const CGFloat *backgroundGradient;
    const CGFloat *locations;
    NSInteger numberOfColorsInGradient;

@protected
    UIColor *_tintColor;
    UIColor *_disabledColor;
    
    UIColor *_borderColor;
    UIColor *_disabledBorderColor;
    
    CGFloat _buttonCornerRadius;
    CGFloat _innerBorderWidth;
    CGFloat _buttonBorderWidth;
    
    BOOL _invertGradientOnSelected;
    
    CGFloat _backgroundOpacity;
    
    UIEdgeInsets _buttonInsets;
    
    XDGlossyButtonStrokeType _strokeType;
    XDGlossyButtonExtraShadingType _extraShadingType;
    
}

@property (nonatomic, retain) UIColor *tintColor;
@property (nonatomic, retain) UIColor *disabledColor; // color when disabled, can be nil for lightgray color when disabled
@property (nonatomic, assign) CGFloat buttonCornerRadius; // outer button border
@property (nonatomic, assign) UIEdgeInsets buttonInsets; // inset of the button face, default 0.0
@property (nonatomic, retain) UIColor *borderColor; // button border color, default nil = dark gray
@property (nonatomic, retain) UIColor *disabledBorderColor; // color when disabled, can be nil for lightgray color when disabled
@property (nonatomic, assign) CGFloat buttonBorderWidth; // outer button border width, default 1.0
@property (nonatomic, assign) CGFloat innerBorderWidth; // inner stroke that fill same color as the tint color, default = 1.0
@property (nonatomic, assign) XDGlossyButtonStrokeType strokeType; // outer button border
@property (nonatomic, assign) XDGlossyButtonExtraShadingType extraShadingType; // extra shading effect other than gradient
@property (nonatomic, assign) BOOL invertGradientOnSelected; // invert the gradient when button down for inner bevel effect, default = NO
@property (nonatomic, assign) CGFloat backgroundOpacity; // default 1.0, set smaller to draw button in transparent

// path for the button, default is a round cornect retangle, we can subclass and customize it
- (UIBezierPath *)pathForButton:(CGFloat)inset;

- (void)setGradientType:(XDGlossyButtonGradientType)type; 

- (void)setActionSheetButtonColor:(UIColor *)color;
- (void)setNavigationButtonColor:(UIColor *)color; // navigation bar button, or store button

@end



// subtype that with left and right navigation button shape
@interface XDGNavigationButton : XDGlossyButton {

@private
    BOOL _leftArrow;

}

@property (nonatomic, getter = isLeftArrow) BOOL leftArrow;

@end

@interface XDGBadgeButton : XDGlossyButton {

@private
    NSInteger _numberOfEdges;
    CGFloat _innerRadiusRatio;

}

@property (nonatomic, assign) NSInteger numberOfEdges;
@property (nonatomic, assign) CGFloat innerRadiusRatio;

@end



