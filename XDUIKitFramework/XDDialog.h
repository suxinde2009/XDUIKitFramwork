//
//  XDDialog.h
//  XDUIKitFramework
//
//  Created by admin on 12-8-13.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

////////////////////////////////////////////////////////////////////////////////////////////////
//
//  Original Author :  Erik Aigner ( CODialog github: https://github.com/eaigner/CODialog )
//
//  ReWriten By     :  XD.Su
//
//  Rewrite reason  :  The original code writen by Erik Aigner using ARC, that means the code 
//                     can only run on the device with iOS 5.0 and above. So I rewrite it to 
//                     compatible for iOS 4.0, and I plan to add a delegate to this class to 
//                     make it a UIAlertView-like for convenience. 
//
//  Last updated    :  0813, 2012
//
//////////////////////////////////////////////////////////////////////////////////////////////

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol XDDialogDelegate;

typedef enum {
    XDDialogStyleDefault = 0,
    XDDialogStyleIndeterminate,
    XDDialogStyleDeterminate,
    XDDialogStyleSuccess,
    XDDialogStyleError,
    XDDialogStyleCustomView
}XDDialogStyle;

@interface XDDialog : UIView {
    
@private
    struct {
        CGRect titleRect;
        CGRect subtitleRect;
        CGRect accessoryRect;
        CGRect textFieldRect;
        CGRect buttonRect;
    } layout;
    
}

@property (nonatomic, retain) UIView *customView;
@property (nonatomic, assign) XDDialogStyle dialogStyle;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) NSTimeInterval batchDelay; // ?
@property (nonatomic, assign) id<XDDialogDelegate> delegate;
@property (nonatomic, readonly) BOOL isShowing;

+ (id)dialogWithWindow:(UIWindow *)hostWindow;
- (id)initWithWindow:(UIWindow *)hostWindow;

/**
 @name Configuration
 */
- (void)resetLayout;
- (void)removeAllControls;
- (void)removeAllTextFields;
- (void)removeAllButtons;
- (void)addTextFieldWithPlaceholder:(NSString *)placeholder secure:(BOOL)secure;
- (void)addButtonWithTitle:(NSString *)title target:(id)target selector:(SEL)sel;
- (void)addButtonWithTitle:(NSString *)title target:(id)target selector:(SEL)sel highlighted:(BOOL)flag;

/**
 @name Getting the string values in the textFields
 */
- (NSString *)textForTextFieldAtIndex:(NSUInteger)index;

/**
 @name Showing, updating and hiding
 */
- (void)showOrUpdateAnimated:(BOOL)flag;
- (void)hideAnimated:(BOOL)flag;
- (void)hideAnimated:(BOOL)flag afterDelay:(NSTimeInterval)delay;

/**
 @name Methods to override
 */
- (void)drawRect:(CGRect)rect;
- (void)drawDialogBackgroundInRect:(CGRect)rect;
- (void)drawButtonInRect:(CGRect)rect title:(NSString *)title highlighted:(BOOL)highlighted down:(BOOL)down;
- (void)drawTitleInRect:(CGRect)rect isSubtitle:(BOOL)isSubtitle;
- (void)drawSymbolInRect:(CGRect)rect;
- (void)drawTextFieldInRect:(CGRect)rect;

@end


/**
 @name Delegate methods
 */

@protocol XDDialogDelegate <NSObject>

@optional

- (void)willPresentDialog:(XDDialog *)dialog;
- (void)didPresentDialog:(XDDialog *)dialog;
//- (void)didDismissDialog:(XDDialog *)dialog;

@end
