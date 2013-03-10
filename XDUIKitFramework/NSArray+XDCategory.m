//
//  NSArray+XDCategory.m
//  XDUIKitFramework
//
//  Created by admin on 12-8-9.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import "NSArray+XDCategory.h"

// Core
#import "NSObject+XDCategory.h"
#import "XDCorePreprocessorMacros.h"

@implementation NSArray (XDCategory)

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)perform:(SEL)selector {
    NSArray *copy = [[NSArray alloc] initWithArray:self];
    NSEnumerator *e = [copy objectEnumerator];
    for(id delegate; (delegate = [e nextObject]); ) {
        if([delegate respondsToSelector:selector]) {
            [delegate performSelector:selector];
        }
    }
    [copy release];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)perform:(SEL)selector withObject:(id)p1 {
    NSArray *copy = [[NSArray alloc] initWithArray:self];
    NSEnumerator *e = [copy objectEnumerator];
    for(id delegate; (delegate = [e nextObject]); ) {
        if([delegate respondsToSelector:selector]){
            [delegate performSelector:selector withObject:p1];
        }
    }
    [copy release];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)perform:(SEL)selector withObject:(id)p1 withObject:(id)p2 {
    NSArray *copy = [[NSArray alloc] initWithArray:self];
    NSEnumerator *e = [copy objectEnumerator];
    for(id delegate; (delegate = [e nextObject]); ) {
        if([delegate respondsToSelector:selector]){
            [delegate performSelector:selector withObject:p1 withObject:p2];
        }
    }
    [copy release];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)perform:(SEL)selector withObject:(id)p1 withObject:(id)p2 withObject:(id)p3 {
    NSArray *copy = [[NSArray alloc] initWithArray:self];
    NSEnumerator *e = [copy objectEnumerator];
    for(id delegate; (delegate = [e nextObject]); ) {
        if([delegate respondsToSelector:selector]){
            [delegate performSelector:selector withObject:p1 withObject:p2 withObject:p3];
        }
    }
    [copy release];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)makeObjectsPerformSelector:(SEL)selector withObject:(id)p1 withObject:(id)p2 {
    for(id delegate in self) {
        [delegate performSelector:selector  withObject:p1 withObject:p2];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)makeObjectsPerformSelector: (SEL)selector withObject: (id)p1 withObject: (id)p2 withObject: (id)p3 {
    for(id delegate in self) {
        [delegate performSelector:selector withObject:p1 withObject:p2 withObject:p3];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)objectWithValue:(id)value forKey:(id)key {
    for(id object in self) {
        id propertyValue = [object valueForKey:key];
        if([propertyValue isEqual:value]) {
            return object;
        }
    }
    return nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)objectWithClass:(Class)cls {
    for(id object in self) {
        if([object isKindOfClass:cls]) {
            return object;
        }
    }
    return nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)containsObject:(id)object withSelector:(SEL)selector {
    for(id item in self) {
        if([[item performSelector:selector withObject:object] boolValue]) {
            return YES;
        } 
    }
    return  NO;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) firstObject{
	return [self objectAtIndex:0];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) randomObject{
	return [self objectAtIndex:arc4random() % [self count]];
}

@end
