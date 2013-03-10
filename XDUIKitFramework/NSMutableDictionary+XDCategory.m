//
//  NSMutableDictionary+XDCategory.m
//  XDUIKitFramework
//
//  Created by admin on 12-8-9.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import "NSMutableDictionary+XDCategory.h"

// Core
#import "XDCorePreprocessorMacros.h"
#import "XDGlobalCore.h"

@implementation NSMutableDictionary (XDCategory)

////////////////////////////////////////////////////////////////////////////
- (void)setNonEmptyString:(NSString*)string forKey:(id)key {
    if (XDIsStringWithAnyText(string)) {
        [self setObject:string forKey:key];
    }
}

@end
