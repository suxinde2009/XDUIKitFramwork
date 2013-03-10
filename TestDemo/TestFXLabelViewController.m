//
//  TestFXLabelViewController.m
//  XDUIKitFramework
//
//  Created by admin on 12-9-12.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import "TestFXLabelViewController.h"
#import "XDUIKitFramework.h"

@interface TestFXLabelViewController ()

@end

@implementation TestFXLabelViewController

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
    [self.view setBackgroundColor:[UIColor grayColor]];
    
    firstLabel = [[FXLabel alloc] init];
    firstLabel.frame = CGRectMake(40, 40, 240, 80);
    firstLabel.backgroundColor = [UIColor clearColor];
    firstLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:35];
    firstLabel.text = @"第一种效果";
    firstLabel.textColor = [UIColor grayColor];
    firstLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.8f];
    firstLabel.shadowOffset = CGSizeMake(1.0f, 2.0f);
    firstLabel.shadowBlur = 1.0f;
    firstLabel.innerShadowColor = [UIColor colorWithWhite:0.0f alpha:0.8f];
    firstLabel.innerShadowOffset = CGSizeMake(1.0f, 2.0f);    
    [self.view addSubview:firstLabel];
    
    secondLabel = [[FXLabel alloc] init];
    secondLabel.frame = CGRectMake(40, 140, 240, 80);
    secondLabel.backgroundColor = [UIColor clearColor];
    secondLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:35];
    secondLabel.text = @"第二种效果";
    secondLabel.textColor = [UIColor whiteColor];
    secondLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.75f];
    secondLabel.shadowOffset = CGSizeMake(0.0f, 5.0f);
    secondLabel.shadowBlur = 5.0f;
    [self.view addSubview:secondLabel];
    
    thirdyLabel = [[FXLabel alloc] init];
    thirdyLabel.frame = CGRectMake(40, 240, 240, 80);
    thirdyLabel.backgroundColor = [UIColor clearColor];
    thirdyLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:35];
    thirdyLabel.text = @"第三种效果";
    thirdyLabel.gradientStartColor = [UIColor redColor];
    thirdyLabel.gradientEndColor = [UIColor blackColor];    
    [self.view addSubview:thirdyLabel];
    
    fourthLabel = [[FXLabel alloc] init];
    fourthLabel.frame = CGRectMake(40, 340, 240, 80);
    fourthLabel.backgroundColor = [UIColor clearColor];
    fourthLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:35];
    fourthLabel.text = @"第四种效果";
    fourthLabel.shadowColor = [UIColor blackColor];
    fourthLabel.shadowOffset = CGSizeZero;
    fourthLabel.shadowBlur = 20.0f;
    fourthLabel.innerShadowColor = [UIColor yellowColor];
    fourthLabel.innerShadowOffset = CGSizeMake(1.0f, 2.0f);
    fourthLabel.gradientStartColor = [UIColor redColor];
    fourthLabel.gradientEndColor = [UIColor yellowColor];
    fourthLabel.gradientStartPoint = CGPointMake(0.0f, 0.5f);
    fourthLabel.gradientEndPoint = CGPointMake(1.0f, 0.5f);  
    [self.view addSubview:fourthLabel];
    
    [self.view showViewHierarchy];
}



@end
