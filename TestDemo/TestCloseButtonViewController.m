//
//  TestCloseButtonViewController.m
//  XDUIKitFramework
//
//  Created by admin on 12-9-27.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import "TestCloseButtonViewController.h"

static BOOL isColorDefult = TRUE;

@interface TestCloseButtonViewController ()

@end

@implementation TestCloseButtonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]){
    
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _closeButton = [[XDCloseButton alloc] initWithFrame:CGRectMake(20, 20, 44, 44)];
    [_closeButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_closeButton];
    [_closeButton setHighlightColor:[UIColor orangeColor]];//colorWithRed:1. green:.5 blue:0. alpha:.8]];
    
    
    [_closeButton2 setBorderColor:[UIColor whiteColor]];
   [self.view showViewHierarchy];
}


- (IBAction)close:(id)sender
{
    XDCloseButton *btn = (XDCloseButton *)sender;
    
    NSLog(@"close button click: ooxx");
    isColorDefult = !isColorDefult;
    /*
    if(isColorDefult){
        [btn setBackgroundFillColor:[UIColor blackColor]];
        [btn setHighlightColor:[UIColor colorWithRed:0.0 green:0.290 blue:0.940 alpha:1.0]];
    }else {
        [btn setBackgroundFillColor:[UIColor greenColor]];
        [btn setHighlightColor:[UIColor orangeColor]];
    }
     */
}

@end
