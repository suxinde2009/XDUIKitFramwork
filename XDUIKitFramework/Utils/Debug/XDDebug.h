//
//  XDDebug.h
//  XDUIKitFramework
//
//  Created by admin on 12-8-10.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

/**
 * Original From: Three20 Debugging tools.
 *
 * Provided in this header are a set of debugging tools. This is meant quite literally, in that
 * all of the macros below will only function when the DEBUG preprocessor macro is specified.
 *
 * XDDASSERT(<statement>);
 * If <statement> is false, the statement will be written to the log and if you are running in
 * the simulator with a debugger attached, the app will break on the assertion line.
 *
 * XDDPRINT(@"formatted log text %d", param1);
 * Print the given formatted text to the log.
 *
 * XDDPRINTMETHODNAME();
 * Print the current method name to the log.
 *
 * XDDCONDITIONLOG(<statement>, @"formatted log text %d", param1);
 * If <statement> is true, then the formatted text will be written to the log.
 *
 * XDDINFO/XDDWARNING/XDDERROR(@"formatted log text %d", param1);
 * Will only write the formatted text to the log if TTMAXLOGLEVEL is greater than the respective
 * XDD* method's log level. See below for log levels.
 *
 * The default maximum log level is XDLOGLEVEL_WARNING.
 */

#define XDLOGLEVEL_INFO        5
#define XDLOGLEVEL_WARNING     3
#define XDLOGLEVEL_ERROR       1

#ifndef XDMAXLOGLEVEL
    #define XDMAXLOGLEVEL XDLOGLEVEL_WARNING
#endif

// The general purpose logger. This ignores logging levels.
#ifdef DEBUG
    #define XDDPRINT(xx, ...) NSLog(@"%s(%d): " xx, __PRETTY_FUCTION__, __LINE__, ##__VA_ARGS__)
#else
    #define XDDPRINT(xx, ...) ((void)0)
#endif


// Print the current method's name
#define XDDPRINTMETHODNAME() XDDPRINT(@"%s", __PRETTY_FUCTION__)

// Debug-only assertions.
#ifdef DEBUG

#import <TargetConditionals.h>

#ifdef TARGET_IPHONE_SIMULATOR

    int XDIsInDebugger();

    #define XDDASSERT(xx)                                       \
    if(!(xx)) {                                                 \
        XDDPRINT(@"XDDASSERT failed: %s", #xx);                 \
        if(XDIsInDebugger()) {                                  \
            __asm__("int $3\n" : : );                           \
        };                                                      \
    } 

#else

    #define XDDASSERT(xx)                                       \
    if(!(xx)) {                                                 \
        XDDPRINT(@"XDDASSERT failed: %s", #xx);                 \
    }

#endif

#else
    #define XDDASSERT(xx) ((void)0)
#endif

#if XDLOGLEVEL_ERROR <= XDMAXLOGLEVEL
    #define XDDERROR(xx, ...) XDDPRINT(xx, ##__VA_ARGS__)
#else
    #define XDDERROR(xx, ...) ((void)0)
#endif


#if XDLOGLEVEL_WARNING <= XDMAXLOGLEVEL
    #define XDDWARNING(xx, ...) XDDPRINT(xx, ##__VA_ARGS__)
#else
    #define XDDWARNING(xx, ...) ((void)0)
#endif

#if XDLOGLEVEL_INFO <= XDMAXLOGLEVEL
    #define XDDINFO(xx, ...) XDDPRINT(xx, ##__VA_ARGS__)
#else
    #define XDDINFO(xx, ...) ((void)0)
#endif

#ifdef DEBUG
    #define XDDCONDITIONLOG(condition, xx, ...)               \
        if((condition)) {                                     \
            XDDPRINT(xx, ##__VA_ARGS__);                      \
        }
#else
    #define XDDCONDITIONLOG(condition, xx, ...) ((void)0)
#endif








