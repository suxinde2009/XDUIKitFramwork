//
//  TestToastViewController.m
//  XDUIKitFramework
//
//  Created by admin on 12-8-17.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import "TestToastViewController.h"

#import "XDToast.h"
#import "XDUIKitFramework.h"

@interface TestToastViewController ()

@end

@implementation TestToastViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view showViewHierarchy];
    
}

- (IBAction)clickAction:(id)sender
{
    // test toast
    XDToast *toast = [XDToast makeText:@"text"];
    [toast show];
}

- (IBAction)backClickAction:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
