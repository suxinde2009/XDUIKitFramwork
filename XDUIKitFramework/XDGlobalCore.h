//
//  XDGlobalCore.h
//  XDUIKitFramework
//
//  Created by admin on 12-8-9.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Creates a mutable array which does not retain references to the objects it contains.
 *
 * Typically used with arrays of delegates.
 */
NSMutableArray* XDCreateNonRetainingArray();

/**
 * Creates a mutable dictionary which does not retain references to the values it contains.
 *
 * Typically used with dictionaries of delegates.
 */
NSMutableDictionary* XDCreateNonRetainingDictionary();

/**
 * Tests if an object is an array which is not empty.
 */
BOOL XDIsArrayWithItems(id object);

/**
 * Tests if an object is a set which is not empty.
 */
BOOL XDIsSetWithItems(id object);

/**
 * Tests if an object is a string which is not empty.
 */
BOOL XDIsStringWithAnyText(id object);

/**
 * Swap the two method implementations on the given class.
 * Uses method_exchangeImplementations to accomplish this.
 */
void XDSwapMethods(Class cls, SEL originalSel, SEL newSel);
