//
//  UIView+ViewHierarchy.m
//  XDUIKitFramework
//
//  Created by admin.konnech on 13-2-20.
//  Copyright (c) 2013年 __MyCompany__. All rights reserved.
//

#import "UIView+ViewHierarchy.h"


void indentSubViewsHierarchyString(UIView *aView, int indent, NSMutableString *outString)
{
    for(int i = 0; i < indent; i++){
        [outString appendString:@"--"];
    }
    
    [outString appendFormat:@"[%2d] %@\n", indent, NSStringFromClass([aView class])];//[[aView class] description]];
    
    for (UIView *view in [aView subviews]){
        indentSubViewsHierarchyString(view, indent+1, outString);
    }
}


@implementation UIView (ViewHierarchy)

- (void)showViewHierarchy
{
    NSMutableString *outString = [[NSMutableString alloc] initWithCapacity:0];
    indentSubViewsHierarchyString(self, 0, outString);
    CFShow(outString);
    [outString release];
}

@end


/*
// Recursively travel down the view tree, increasing the indentation level for children
- (void) dumpView: (UIView *) aView atIndent: (int) indent into:(NSMutableString *) outstring
{
	for (int i = 0; i < indent; i++) [outstring appendString:@"--"];
	[outstring appendFormat:@"[%2d] %@\n", indent, NSStringFromClass([aView class])];//[[aView class] description]];
	for (UIView *view in [aView subviews]) [self dumpView:view atIndent:indent + 1 into:outstring];
}

// Start the tree recursion at level 0 with the root view
- (NSString *) displayViews: (UIView *) aView
{
	NSMutableString *outstring = [[NSMutableString alloc] init];
	[self dumpView: self.window atIndent:0 into:outstring];
	return [outstring autorelease];
}

// Show the tree
- (void) displayViews
{
	CFShow([self displayViews: self.window]);
}

*/