//
//  BKTimer.h
//  Methods
//
//  Created by Ulrik Damm on 30/9/11.
//  Copyright (c) 2011 Ulrik Damm. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BKTimerCompletionBlock)(void);
typedef BOOL(^BKTimerRepeatingCompletionBlock)(void);

@interface BKTimer : NSObject

+ (void)timerWithDelay:(NSTimeInterval)delay completion:(BKTimerCompletionBlock)completion;
+ (void)repeatingTimerWithDelay:(NSTimeInterval)delay completion:(BKTimerRepeatingCompletionBlock)completion;

@end
