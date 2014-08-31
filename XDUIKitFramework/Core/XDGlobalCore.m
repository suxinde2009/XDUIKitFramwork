//
//  XDGlobalCore.m
//  XDUIKitFramework
//
//  Created by admin on 12-8-9.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import "XDGlobalCore.h"

#import <objc/runtime.h>

// No-ops for non-retaining objects.
static const void* XDRetainNoOp(CFAllocatorRef allocator, const void *value) { return value; }
static void XDReleaseNoOp(CFAllocatorRef allocator, const void *value) { }

//////////////////////////////////////////////////////////////////
NSMutableArray* XDCreateNonRetainingArray(){
    CFArrayCallBacks callbacks = kCFTypeArrayCallBacks;
    callbacks.retain = XDRetainNoOp;
    callbacks.release = XDReleaseNoOp;
    return (NSMutableArray *)CFArrayCreateMutable(nil, 0, &callbacks);
}



//////////////////////////////////////////////////////////////////
NSMutableDictionary* XDCreateNonRetainingDictionary(){
    CFDictionaryKeyCallBacks keyCallBacks = kCFTypeDictionaryKeyCallBacks;
    CFDictionaryValueCallBacks callbacks = kCFTypeDictionaryValueCallBacks;
    callbacks.retain = XDRetainNoOp;
    callbacks.release = XDReleaseNoOp;
    return (NSMutableDictionary *)CFDictionaryCreateMutable(nil, 0, &keyCallBacks, &callbacks);
}


//////////////////////////////////////////////////////////////////
BOOL XDIsArrayWithItems(id object){
    return ([object isKindOfClass:[NSArray class]] && [(NSArray *)object count] > 0);
}

//////////////////////////////////////////////////////////////////
BOOL XDIsSetWithItems(id object){
    return ([object isKindOfClass:[NSSet class]] && [(NSSet *)object count] > 0);
}

//////////////////////////////////////////////////////////////////
BOOL XDIsStringWithAnyText(id object){
    return ([object isKindOfClass:[NSString class]] && [(NSString *)object length] > 0);
}

//////////////////////////////////////////////////////////////////
void XDSwapMethods(Class cls, SEL originalSel, SEL newSel){
    Method originalMethod = class_getInstanceMethod(cls, originalSel);
    Method newMethod = class_getInstanceMethod(cls, newSel);
    method_exchangeImplementations(originalMethod, newMethod);
}