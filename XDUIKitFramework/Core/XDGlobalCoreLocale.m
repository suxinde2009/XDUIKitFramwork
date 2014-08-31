//
//  XDGlobalCoreLocale.m
//  XDUIKitFramework
//
//  Created by admin on 12-8-10.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import "XDGlobalCoreLocale.h"

#import "XDDebug.h"

///////////////////////////////////////////////////////////////////////////////////
NSLocale* XDCurrentLocale() {
    NSArray *languages = [NSLocale preferredLanguages];
    if(languages.count > 0) {
        NSString *currentLanguage = [languages objectAtIndex:0];
        return [[[NSLocale alloc] initWithLocaleIdentifier:currentLanguage] autorelease];
    } else {
        return [NSLocale currentLocale];
    }
}


///////////////////////////////////////////////////////////////////////////////////
NSString* XDLocalizedString(NSString* key, NSString* comment) {
    return NSLocalizedString(key, comment);
}
 

///////////////////////////////////////////////////////////////////////////////////
NSString* XDDescriptionForError(NSError* error) {
    XDDINFO(@"ERROR: %@", error);
    
    if([error.domain isEqualToString:NSURLErrorDomain]) {
       if (error.code == NSURLErrorTimedOut) {
           return XDLocalizedString(@"Connection Time Out", @"");
       }else if (error.code == NSURLErrorNotConnectedToInternet) {
           return XDLocalizedString(@"No Internet Connection", @"");
       }else {
           return XDLocalizedString(@"Connection Error", @"");
       }
    }
    return XDLocalizedString(@"Error", @"");
    
}


///////////////////////////////////////////////////////////////////////////////////
NSString* XDFormatInteger(NSInteger num) {
    NSNumber *number = [NSNumber numberWithInt:num];
    NSNumberFormatter *formatter  = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *formatted = [formatter stringFromNumber:number];
    [formatter release];
    return formatted;
}
