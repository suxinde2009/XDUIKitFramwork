//
//  XDMarkupStripper.h
//  XDUIKitFramework
//
//  Created by admin on 12-8-10.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#if __IPHONE_4_0 && __IPHONE_4_0 <= __IPHONE_OS_VERSION_MAX_ALLOWED
@interface XDMarkupStripper : NSObject <NSXMLParserDelegate> {
#else
@interface XDMarkupStripper : NSObject {
#endif
 
@private
    NSMutableArray *_strings;
}
    
- (NSString *)parse:(NSString *)string;
    
@end
