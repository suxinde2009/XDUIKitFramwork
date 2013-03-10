//
//  TestCircularProgressViewViewController.m
//  XDUIKitFramework
//
//  Created by admin on 12-8-16.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import "TestCircularProgressViewViewController.h"
#import "XDUIKitFramework.h"

@interface TestCircularProgressViewViewController ()

@end

@implementation TestCircularProgressViewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

@synthesize progressView;
@synthesize largeProgressView;
@synthesize largestProgressView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    progressView = [[XDCircularProgressView alloc] initWithFrame:CGRectMake(140.0f, 20.0f, 40.0f, 40.0f)];
    [self.view addSubview:progressView];
    progressView.trackTintColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.3f];
    progressView.progressTintColor = [UIColor purpleColor];
    [progressView setAnimated:YES];
    
    largeProgressView = [[XDCircularProgressView alloc] initWithFrame:CGRectMake(110.0f, 80.0f, 100.0f, 100.0f)];
    [self.view addSubview:largeProgressView];
    
    largestProgressView = [[XDCircularProgressView alloc] initWithFrame:CGRectMake(60.0f, 200.0f, 200.0f, 200.0f)];
    [self.view addSubview:largestProgressView];
    
    //timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(progressChange) userInfo:nil repeats:YES];
    
    [self.view showViewHierarchy];
}

- (void)progressChange
{
    progressView.progress += 0.01;
    largeProgressView.progress += 0.01;
    largestProgressView.progress += 0.01;
    
    if (progressView.progress > 1.0f)
    {
        progressView.progress = 0.0f;
    }
    
    if (largeProgressView.progress > 1.0f)
    {
        largeProgressView.progress = 0.0f;
    }
    
    if (largestProgressView.progress > 1.0f)
    {
        largestProgressView.progress = 0.0f;
    }
}

- (IBAction)cancelClickAction:(id)sender 
{
    [timer invalidate];
    [self dismissModalViewControllerAnimated:YES];
}

@end
