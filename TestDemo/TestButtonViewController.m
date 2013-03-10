//
//  TestButtonViewController.m
//  testAll
//
//  Created by Water Lou on 05/06/2011.
//  Copyright 2011 First Water Tech Ltd. All rights reserved.
//

#import "TestButtonViewController.h"
#import "XDCorePreprocessorMacros.h"
#import "XDDebug.h"

#import "XDUIKitFramework.h"

@interface TestButtonViewController ()
- (UIColor *)translucentBlueColor;
- (CGColorSpaceRef)genericRGBSpace;
@end


@implementation TestButtonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	    
    

	// stand action sheet button
	XDGlossyButton *b = [[XDGlossyButton alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    [b setActionSheetButtonColor:[UIColor redColor]];
    b.enabled = TRUE;
    [b useWhiteLabel:YES];
    [b setTitle:@"Delete AllEE" forState:UIControlStateNormal | UIControlStateHighlighted];
    
    //[self.view addSubview:b];
    b.center = self.view.center;
    [b addTarget:self action:@selector(cancelClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
	b = (XDGlossyButton*) [self.view viewWithTag: 1001];
	[b setActionSheetButtonColor: [UIColor redColor]];

    
	// navigation bar button
	b = (XDGlossyButton*) [self.view viewWithTag: 1002];
	[b setNavigationButtonColor:[UIColor navigationBarButtonColor]];

	b = (XDGlossyButton*) [self.view viewWithTag: 1003];
	[b setNavigationButtonColor:[UIColor doneButtonColor]];

	// All non iPhone-like but nice buttons
	b = (XDGlossyButton*) [self.view viewWithTag: 1004];
	[b useWhiteLabel: YES]; b.tintColor = [UIColor darkGrayColor];
	[b setShadow:[UIColor blackColor] opacity:0.8 offset:CGSizeMake(0, 1) blurRadius: 4];

    b = (XDGlossyButton*) [self.view viewWithTag: 1017];
	[b useWhiteLabel: YES]; b.tintColor = [UIColor darkGrayColor];
	[b setShadow:[UIColor blackColor] opacity:0.8 offset:CGSizeMake(0, 1) blurRadius: 4];
    b.invertGradientOnSelected = YES;

    b = (XDGlossyButton*) [self.view viewWithTag: 1018];
	[b useWhiteLabel: YES]; b.tintColor = [UIColor purpleColor];
	[b setShadow:[UIColor blackColor] opacity:0.8 offset:CGSizeMake(0, 1) blurRadius: 4];
    [b setGradientType:XDGlossyButtonGradientTypeLinearSmoothExtreme];

    b = (XDGlossyButton*) [self.view viewWithTag: 1019];
	[b useWhiteLabel: YES]; b.tintColor = [UIColor brownColor];
	[b setShadow:[UIColor blackColor] opacity:0.8 offset:CGSizeMake(0, 1) blurRadius: 4];
    [b setGradientType:XDGlossyButtonGradientTypeLinearSmoothBrightToNormal];

    b = (XDGlossyButton*) [self.view viewWithTag: 1020];
	[b useWhiteLabel: YES];
    b.buttonCornerRadius = 2.0; b.buttonBorderWidth = 1.0f;
	[b setStrokeType: XDGlossyButtonStrokeTypeBevelUp];
    b.tintColor = b.borderColor = [UIColor colorWithRed:70.0f/255.0f green:105.0f/255.0f blue:192.0f/255.0f alpha:1.0f];
    
	b = (XDGlossyButton*) [self.view viewWithTag: 1005];
	[b useWhiteLabel: YES]; b.tintColor = [UIColor whiteColor];
	b.backgroundOpacity = 0.5;
	[b setShadow:[UIColor blackColor] opacity:0.8 offset:CGSizeMake(0, 1) blurRadius: 4];
	
	// App Store like buttons
	b = (XDGlossyButton*) [self.view viewWithTag: 1006];
	[b setNavigationButtonColor:[UIColor darkGrayColor]];

	b = (XDGlossyButton*) [self.view viewWithTag: 1007];
	b.enabled = NO;
	[b setNavigationButtonColor:[UIColor darkGrayColor]];
	
	// different extra shading (square one in the samples)
	b = (XDGlossyButton*) [self.view viewWithTag: 1008];
	b.tintColor = [UIColor greenColor];
	b.innerBorderWidth = 5.0f;
	b.buttonBorderWidth = 0.0f;
	b.buttonCornerRadius = 16.0f;

	b = (XDGlossyButton*) [self.view viewWithTag: 1009];
	b.tintColor = [UIColor blackColor];
	[b useWhiteLabel: YES];
	b.backgroundOpacity = 0.5;
	b.innerBorderWidth = 5.0f;
	b.buttonBorderWidth = 0.0f;
	b.buttonCornerRadius = 12.0f;
	[b setGradientType: XDGlossyButtonGradientTypeSolid];
	[b setExtraShadingType:XDGlossyButtonExtraShadingTypeRounded];
	
	b = (XDGlossyButton*) [self.view viewWithTag: 1010];
	b.tintColor = [UIColor darkGrayColor];
	[b useWhiteLabel: YES];
	b.innerBorderWidth = 5.0f;
	b.buttonBorderWidth = 0.0f;
	b.buttonCornerRadius = 0.0f;
	[b setGradientType: XDGlossyButtonGradientTypeSolid];
	[b setExtraShadingType:XDGlossyButtonExtraShadingTypeAngleLeft];
	b.backgroundOpacity  =0.5;

	b = (XDGlossyButton*) [self.view viewWithTag: 1013];
	b.tintColor = [UIColor blueColor];
	[b useWhiteLabel: YES];
	b.innerBorderWidth = 0.0f;
	b.buttonBorderWidth = 1.0f;
	b.buttonCornerRadius = 0.0f;
	[b setGradientType: XDGlossyButtonGradientTypeLinearSmoothStandard];
	[b setExtraShadingType:XDGlossyButtonExtraShadingTypeAngleRight];
	b.backgroundOpacity  =0.75;

	// create the sales badge button, using the subclass UIGBadgeButton
	{
		XDGBadgeButton *b = (XDGBadgeButton*) [self.view viewWithTag: 1014];
		[b useWhiteLabel:YES];
		b.tintColor = [UIColor redColor];
		[b setGradientType: XDGlossyButtonGradientTypeLinearSmoothBrightToNormal];
		b.borderColor = [UIColor whiteColor];
		b.buttonBorderWidth = 5;
		b.numberOfEdges = 16;
		[b setShadow:[UIColor blackColor] opacity:0.8 offset:CGSizeZero blurRadius: 2];
	}
	
	// left and right navigation bar (suggested 32px height to match OS's one)
	{
		XDGNavigationButton *b;
		b = (XDGNavigationButton*) [self.view viewWithTag: 1011];
		b.leftArrow = YES;
		[b setNavigationButtonColor:[UIColor navigationBarButtonColor]];
		
		b = (XDGNavigationButton*) [self.view viewWithTag: 1012];
		b.leftArrow = NO;
		[b setNavigationButtonColor:[UIColor navigationBarButtonColor]];
	}
    
    // for button using kXDGlossyButtonStrokeTypeInnerBevelDown, buttonBorderWidth better <= 4.0f 
    
    // SMS Send Button 
	b = (XDGlossyButton*) [self.view viewWithTag: 1015];
	b.tintColor = [UIColor doneButtonColor];
	[b useWhiteLabel: YES];
	b.innerBorderWidth = 0.0f;
	b.buttonBorderWidth = 1.0f;
	b.buttonCornerRadius = 12.0f;
	[b setGradientType:XDGlossyButtonGradientTypeLinearGlossyStandard];
	[b setStrokeType:XDGlossyButtonStrokeTypeInnerBevelDown];

    // big circle button 
	b = (XDGlossyButton*) [self.view viewWithTag: 1016];
	b.tintColor = [UIColor colorWithRed:0.9 green:0.4 blue:0.4 alpha:1.0];
	[b useWhiteLabel: YES];
	b.buttonBorderWidth = 2.0f;
	b.buttonCornerRadius = 40.0f;
	[b setGradientType: XDGlossyButtonGradientTypeLinearSmoothStandard];
	[b setStrokeType: XDGlossyButtonStrokeTypeInnerBevelDown];
    [b setExtraShadingType:XDGlossyButtonExtraShadingTypeRounded];
    [b addTarget:self action:@selector(cancelClickAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.view showViewHierarchy];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) viewWillAppear:(BOOL)animated {
	[super viewWillAppear: animated];
	// bug in iOS, if set transform in viewDidLoad, bounds is set wrongly
	XDGlossyButton *b = (XDGlossyButton*) [self.view viewWithTag: 1014];
	b.transform = CGAffineTransformMakeRotation(M_PI_2 / 3.0);
}


- (UIColor *)translucentBlueColor; 
{ 
	static CGColorRef translucentBlueRef = NULL; 
	if (translucentBlueRef == NULL) 
	{ 
		CGFloat values[4] = {0.13, 0.24, 0.44, 0.7}; 
		translucentBlueRef = CGColorCreate([self genericRGBSpace], values); 
	} 
    UIColor *translucentBlue = [UIColor colorWithCGColor:translucentBlueRef];
	return translucentBlue; 
}

- (CGColorSpaceRef)genericRGBSpace;
{ 
	static CGColorSpaceRef space = NULL; 
	if (space == NULL) 
	{ 
		space = CGColorSpaceCreateDeviceRGB();
	} 
	return space; 
}


- (IBAction)cancelClickAction:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
