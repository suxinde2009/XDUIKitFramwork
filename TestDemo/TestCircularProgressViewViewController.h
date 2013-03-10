//
//  TestCircularProgressViewViewController.h
//  XDUIKitFramework
//
//  Created by admin on 12-8-16.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XDCircularProgressView.h"

@interface TestCircularProgressViewViewController : UIViewController
{
    NSTimer *timer;
}
@property (retain, nonatomic) XDCircularProgressView *progressView;
@property (retain, nonatomic) XDCircularProgressView *largeProgressView;
@property (retain, nonatomic) XDCircularProgressView *largestProgressView;

- (IBAction)cancelClickAction:(id)sender;

@end
