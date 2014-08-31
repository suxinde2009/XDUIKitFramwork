//
//  XDEntityTables.h
//  XDUIKitFramework
//
//  Created by admin on 12-8-10.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * Standard entity tables for use with XML parsers.
 *
 * Supported entity tables: ISO 8859-1.
 *
 * Each table is a dictionary of entity names to NSData objects containing the character.
 */
@interface XDEntityTables : NSObject {
    NSDictionary *_iso88591;
}

/**
 * Entity table for ISO 8859-1.
 */
@property (nonatomic, readonly) NSDictionary* iso88591;

// singleton
+ (id)shareInstance;
+ (void)releaseSharedInstance;

@end
