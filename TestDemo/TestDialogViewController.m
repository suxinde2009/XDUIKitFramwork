//
//  ViewController.m
//  TestDemo
//
//  Created by admin on 12-8-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TestDialogViewController.h"

#import "AppDelegate.h"

@implementation TestDialogViewController
@synthesize dialog;


- (void)viewDidLoad
{
    
#warning https://github.com/eaigner/CODialog/issues/6
#warning 当使用XDDialog的viewController是用presentModalViewController弹出的modal视图时，退出Dialog会顺带退出视图，此处bug待修正
    
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"wallpaper.jpg"];
    UIColor *color = [UIColor colorWithPatternImage:image];
    
    self.view.backgroundColor = color;
    
    [self.view showViewHierarchy];
}


- (IBAction)clickAction:(id)sender{
    
    // Display dialog
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    self.dialog = [XDDialog dialogWithWindow:self.view.window];//[XDDialog dialogWithWindow:app.window];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(advanceProgress:) userInfo:nil repeats:YES];
    
    [self showDefault:nil];
    
}


- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];

}

- (void)advanceProgress:(NSTimer *)sender {
    CGFloat progress = self.dialog.progress + 0.25;
    if (progress > 1.0) {
        progress = 0;
    }
    self.dialog.progress = progress;
}

- (void)hideAndShow:(id)sender {
    [self.dialog hideAnimated:NO];
    
    /*
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.dialog showOrUpdateAnimated:NO];
    });
     */
     
}

- (void)hideAnimatedAndShow:(id)sender {
    [self.dialog hideAnimated:YES];
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.dialog showOrUpdateAnimated:YES];
    });
}

- (void)showDefault:(id)sender {
    NSLog(@"default");
    
    [self.dialog resetLayout];
    
    self.dialog.dialogStyle = XDDialogStyleDefault;
    self.dialog.title = @"Title";
    self.dialog.subtitle = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec at tincidunt arcu. Donec faucibus velit ac ante condimentum pulvinar. Aliquam eget urna vel tortor laoreet porttitor. Pellentesque molestie fringilla tortor, ut consectetur diam adipiscing sit amet.";
    
    [self.dialog addButtonWithTitle:@"Hide" target:self selector:@selector(hideAndShow:)];
    [self.dialog addButtonWithTitle:@"Hide (A)" target:self selector:@selector(hideAnimatedAndShow:)];
    [self.dialog addButtonWithTitle:@"Next" target:self selector:@selector(showText:) highlighted:YES];
    [self.dialog showOrUpdateAnimated:YES];
}

- (void)showText:(id)sender {
    NSLog(@"text");
    
    [self.dialog resetLayout];
    
    self.dialog.dialogStyle = XDDialogStyleDefault;
    self.dialog.title = @"Text Fields";
    self.dialog.subtitle = @"Plenty of them";
    
    [self.dialog addTextFieldWithPlaceholder:@"User" secure:NO];
    [self.dialog addTextFieldWithPlaceholder:@"Password" secure:YES];
    [self.dialog addTextFieldWithPlaceholder:@"Pin" secure:YES];
    
    [self.dialog addButtonWithTitle:@"Hide" target:self selector:@selector(hideAndShow:)];
    [self.dialog addButtonWithTitle:@"Next" target:self selector:@selector(showIndeterminate:) highlighted:YES];
    [self.dialog showOrUpdateAnimated:YES];
}

- (void)showIndeterminate:(id)sender {
    NSLog(@"indeterminate");
    
    // Display text values first
    NSLog(@"user: %@, pass: %@, pin %@",
          [self.dialog textForTextFieldAtIndex:0],
          [self.dialog textForTextFieldAtIndex:1],
          [self.dialog textForTextFieldAtIndex:2]);
    
    // Setup indeterminate dialog
    [self.dialog resetLayout];
    
    self.dialog.title = @"Indeterminate";
    self.dialog.dialogStyle = XDDialogStyleIndeterminate;
    
    [self.dialog addButtonWithTitle:@"Hide" target:self selector:@selector(hideAndShow:)];
    [self.dialog addButtonWithTitle:@"Next" target:self selector:@selector(showDeterminate:) highlighted:YES];
    [self.dialog showOrUpdateAnimated:YES];
}

- (void)showDeterminate:(id)sender {
    NSLog(@"determinate");
    
    [self.dialog resetLayout];
    
    self.dialog.title = @"Determinate";
    self.dialog.dialogStyle = XDDialogStyleDeterminate;
    
    [self.dialog addButtonWithTitle:@"Hide" target:self selector:@selector(hideAndShow:)];
    [self.dialog addButtonWithTitle:@"Next" target:self selector:@selector(showCustomView:) highlighted:YES];
    [self.dialog showOrUpdateAnimated:YES];
}

- (void)showCustomView:(id)sender {
    NSLog(@"custom");
    
    [self.dialog resetLayout];
    
    UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Octocat.png"]];
    view.frame = CGRectMake(0, 0, 128, 128);
    
    self.dialog.title = @"Custom";
    self.dialog.subtitle = @"Hi!";
    self.dialog.dialogStyle = XDDialogStyleCustomView;
    self.dialog.customView = view;
    
    [self.dialog addButtonWithTitle:@"Hide" target:self selector:@selector(hideAndShow:)];
    [self.dialog addButtonWithTitle:@"Next" target:self selector:@selector(showSuccess:) highlighted:YES];
    [self.dialog showOrUpdateAnimated:YES];
}

- (void)showSuccess:(id)sender {
    NSLog(@"success");
    
    self.dialog.title = @"Success";
    self.dialog.subtitle = nil;
    self.dialog.dialogStyle = XDDialogStyleSuccess;
    
    [self.dialog removeAllButtons];
    [self.dialog addButtonWithTitle:@"Success" target:self selector:@selector(hideAndShow:)];
    [self.dialog addButtonWithTitle:@"Next" target:self selector:@selector(showError:) highlighted:YES];
    [self.dialog showOrUpdateAnimated:YES];
}

- (void)showError:(id)sender {
    NSLog(@"error");
    
    [self.dialog resetLayout];
    
    self.dialog.title = @"Error";
    self.dialog.dialogStyle = XDDialogStyleError;
    
    [self.dialog addButtonWithTitle:@"Hide" target:self selector:@selector(hideAndShow:)];
    [self.dialog addButtonWithTitle:@"Next" target:self selector:@selector(showDefault:) highlighted:YES];
    [self.dialog showOrUpdateAnimated:YES];
}

- (IBAction)backClickAction:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [timer invalidate];

    double delayInSeconds = 0.5f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.dialog showOrUpdateAnimated:NO];
    });
}

@end
