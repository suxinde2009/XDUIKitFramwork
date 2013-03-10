//
//  XDCloseButton.h
//  DrawingAndAnimationDemo
//
//  Created by XD.Su on 12-9-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDCloseButton : UIControl
{
    UIColor *_backgorundFillColor;
    UIColor *_borderColor;
    UIColor *_highlightColor;
    BOOL _isHightLighted;
}

- (void)setBackgroundFillColor:(UIColor *)backgroundColor;
- (void)setBorderColor:(UIColor *)borderColor;
- (void)setHighlightColor:(UIColor *)highlightColor;

@end
