//
//  ViewController.h
//  TestDemo
//
//  Created by admin on 12-8-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "XDUIKitFramework.h"
#import "XDCircularProgressView.h"


@interface TestDialogViewController : UIViewController
{
    XDDialog *dialog;
    NSTimer *timer;
}
@property (nonatomic, retain) XDDialog *dialog;

- (IBAction)clickAction:(id)sender;
- (IBAction)backClickAction:(id)sender;
@end
