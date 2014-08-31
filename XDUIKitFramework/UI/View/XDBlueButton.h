//
//  XDBlueButton.h
//  DrawingAndAnimationDemo
//
//  Created by XD.Su on 12-9-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

enum 
{
    XDBlueButtonTypeRoundRect = 0,
    XDBlueButtonTypeLeftArrow,  
    XDBlueButtonTypeRightArrow 
};
typedef NSUInteger XDBlueButtonType;


@interface XDBlueButton : UIButton
{
    @private 
    UIColor *_borderColor;
    UIColor *_highlightColor;
    BOOL _isHightLighted;
    
    XDBlueButtonType _blueButtonType;
    
    CGFloat _buttonCornerRadius;
    UIEdgeInsets _buttonInsets;
    
}


@property (nonatomic) XDBlueButtonType blueButtonType;

- (void)setBlueButtonType:(XDBlueButtonType)blueButtonType;

@end

