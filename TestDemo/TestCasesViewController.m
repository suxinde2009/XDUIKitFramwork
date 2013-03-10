//
//  TestCasesViewController.m
//  XDUIKitFramework
//
//  Created by admin on 12-8-16.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import "TestCasesViewController.h"

#import "TestDialogViewController.h"
#import "TestButtonViewController.h"
#import "TestCircularProgressViewViewController.h"
#import "TestToastViewController.h"
#import "TestFXLabelViewController.h"
#import "GradientViewController.h"
#import "TestCloseButtonViewController.h"

//
#import "UIView+ViewHierarchy.h"

@interface TestCasesViewController ()

@end

@implementation TestCasesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.title = @"Test Cases";
    [super viewDidLoad];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(nil== cell){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    
    if(indexPath.row == 0) {
        cell.textLabel.text = @"XDDialog";
    }else if (indexPath.row == 1) {
        cell.textLabel.text = @"Glossy Buttons";
    }else if (indexPath.row == 2) {
        cell.textLabel.text = @"CircularProgressView";
    }else if (indexPath.row == 3) {
        cell.textLabel.text = @"Toast";
    }else if (indexPath.row == 4) {
        cell.textLabel.text = @"FXLabel";
    }else if (indexPath.row == 5) {
        cell.textLabel.text = @"GradientView";
    }else if (indexPath.row == 6) {
        cell.textLabel.text = @"CloseButton";
    }
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0) {
        
        TestDialogViewController *viewController = [[TestDialogViewController alloc] initWithNibName:@"TestDialogViewController" bundle:nil];
        [self presentModalViewController:viewController animated:YES];
        [viewController release];
    }else if (indexPath.row == 1) {
        TestButtonViewController *testBtnViewController = [[TestButtonViewController alloc] initWithNibName:@"TestButtonViewController" bundle:nil];
        [self presentModalViewController:testBtnViewController animated:YES];
        [testBtnViewController release];
    }else if (indexPath.row == 2) {
        TestCircularProgressViewViewController *testCircularProgressViewViewController = [[TestCircularProgressViewViewController alloc] initWithNibName:@"TestCircularProgressViewViewController" bundle:nil];
        [self presentModalViewController:testCircularProgressViewViewController animated:YES];
        [testCircularProgressViewViewController release];
    }else if (indexPath.row == 3) {
        TestToastViewController *testToastViewController = [[TestToastViewController alloc] initWithNibName:@"TestToastViewController" bundle:nil];
        [self presentModalViewController:testToastViewController animated:YES];
        [testToastViewController release];
    }else if (indexPath.row == 4) {
        TestFXLabelViewController *testFXLblViewController = [[TestFXLabelViewController alloc] initWithNibName:@"TestFXLabelViewController" bundle:nil];
        [self.navigationController pushViewController:testFXLblViewController animated:YES];
        //[self presentModalViewController:testFXLblViewController animated:YES];
        [testFXLblViewController release];
    }else if (indexPath.row == 5) {
        GradientViewController *gradientViewController = [[GradientViewController alloc] init];
        [self.navigationController pushViewController:gradientViewController animated:YES];
        //[self presentModalViewController:gradientViewController animated:YES];
        [gradientViewController release];
    }else if (indexPath.row == 6) {
        TestCloseButtonViewController *testCloseButtonViewController = [[TestCloseButtonViewController alloc] initWithNibName:@"TestCloseButtonViewController" bundle:nil];
        [self.navigationController pushViewController:testCloseButtonViewController animated:YES];
        //[testCloseButtonViewController release];
    }
}

@end
