//
//  NSMutableArray+XDCategory.m
//  XDUIKitFramework
//
//  Created by admin on 12-8-9.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import "NSMutableArray+XDCategory.h"

// Core
#import "XDCorePreprocessorMacros.h"
#import "XDGlobalCore.h"

@implementation NSMutableArray (XDCategory)

- (void)addNonEmptyString:(NSString *)string{
    if(XDIsStringWithAnyText(string)){
        [self addObject:string];
    }
}

@end
