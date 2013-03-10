//
//  TestCloseButtonViewController.h
//  XDUIKitFramework
//
//  Created by admin on 12-9-27.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XDCloseButton.h"
#import "XDUIKitFramework.h"
@interface TestCloseButtonViewController : UIViewController
{
    XDCloseButton *_closeButton;
    IBOutlet XDCloseButton *_closeButton2;
}

- (IBAction)close:(id)sender;

@end
