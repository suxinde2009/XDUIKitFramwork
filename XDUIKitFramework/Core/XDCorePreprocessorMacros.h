//
//  XDCorePreprocessorMacros.h
//  XDUIKitFramework
//
//  Created by admin on 12-8-9.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

///////////////////////////////////////////////////////////////////////////////////////////////////
// Code Management


/**
 * Borrowed from Apple's AvailabiltyInternal.h header. There's no reason why we shouldn't be
 * able to use this macro, as it's a gcc-supported flag.
 * Here's what we based it off of.
 * __AVAILABILITY_INTERNAL_DEPRECATED         __attribute__((deprecated))
 */

#define __XDDEPRECATED_METHOD __attribute__((deprecated))

/**
 * Add this macro before each category implementation, so we don't have to use
 * -all_load or -force_load to load object files from static libraries that only contain
 * categories and no classes.
 * See http://developer.apple.com/library/mac/#qa/qa2006/qa1490.html for more info.
 */
#define XD_FIX_CATEGORY_BUG(name) @interface XD_FIX_CATEGORY_BUG_##name @end \
                                  @implementation TT_FIX_CATEGORY_BUG_##name @end


///////////////////////////////////////////////////////////////////////////////////////////////////
// Flags

/**
 * For when the flag might be a set of bits, this will ensure that the exact set of bits in
 * the flag have been set in the value.
 */
#define IS_MASK_SET(value, flag)  (((value) & (flag)) == (flag))


///////////////////////////////////////////////////////////////////////////////////////////////////
// Time

#define XD_MINUTE 60
#define XD_HOUR   (60 * XD_MINUTE)
#define XD_DAY    (24 * XD_HOUR)
#define XD_5_DAYS (5 * XD_DAY)
#define XD_WEEK   (7 * XD_DAY)
#define XD_MONTH  (30.5 * XD_DAY)
#define XD_YEAR   (365 * XD_DAY)

///////////////////////////////////////////////////////////////////////////////////////////////////
// Safe releases

#define XD_RELEASE_SAFELY(__POINTER) {  \
    [__POINTER release];                \
     __POINTER = nil;                   \
}


#define XD_INVALIDATE_TIMER(__TIMER) {  \
    [__TIMER invalidate];               \
    __TIMER = nil;                      \
}

// Release a CoreFoundation object safely.
#define XD_RELEASE_CF_SAFELY(__REF) { \
    if (nil != (__REF)) {             \
        CFRelease(__REF);             \
        __REF = nil;                  \
    }                                 \
}


