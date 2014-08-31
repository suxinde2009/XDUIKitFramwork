//
//  XDGlobalCoreLocale.h
//  XDUIKitFramework
//
//  Created by admin on 12-8-10.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Gets the current system locale chosen by the user.
 *
 * This is necessary because [NSLocale currentLocale] always returns en_US.
 */
NSLocale* XDCurrentLocale();

/**
 * @return A localized string from the Three20 bundle.
 */
NSString* XDLocalizedString(NSString* key, NSString* comment);

/**
 * @return A localized description for NSURLErrorDomain errors.
 *
 * Error codes handled:
 * - NSURLErrorTimedOut
 * - NSURLErrorNotConnectedToInternet
 * - All other NSURLErrorDomain errors fall through to "Connection Error".
 */
NSString* XDDescriptionForError(NSError* error);

/**
 * @return The given number formatted as XX,XXX,XXX.XX
 *
 * TODO(jverkoey 04/19/2010): This should likely be locale-aware.
 */
NSString* XDFormatInteger(NSInteger num);