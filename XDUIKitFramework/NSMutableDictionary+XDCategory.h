//
//  NSMutableDictionary+XDCategory.h
//  XDUIKitFramework
//
//  Created by admin on 12-8-9.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//



@interface NSMutableDictionary (XDCategory)

/**
 * Adds a string on the condition that it's non-nil and non-empty.
 */
- (void)setNonEmptyString:(NSString*)string forKey:(id)key;

@end
