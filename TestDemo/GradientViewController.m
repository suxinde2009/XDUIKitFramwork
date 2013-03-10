//
//  GradientViewController.m
//  XDCalenderViewDemo
//
//  Created by admin on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GradientViewController.h"
#import "GradientView.h"
#import "XDUIKitFramework.h"

@interface GradientViewController ()

@end

@implementation GradientViewController

- (void)loadView
{
    [super loadView];
    
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    float width = rect.size.width;
    float height = rect.size.height;
    
    if(![[UIApplication sharedApplication] isStatusBarHidden]){
        height -= 20.0f;
    }
    
    NSArray *colors = [NSArray arrayWithObjects:[UIColor blueColor],[UIColor yellowColor],[UIColor magentaColor],[UIColor orangeColor],[UIColor cyanColor],[UIColor purpleColor],[UIColor greenColor], nil];

    
    self.view = [[GradientView alloc] initWithFrame:CGRectMake(0, 0, width, height) withColors:colors];

}


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view showViewHierarchy];
    
}


@end
