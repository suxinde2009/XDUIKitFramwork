//
//  BKTimer.m
//  Methods
//
//  Created by Ulrik Damm on 30/9/11.
//  Copyright (c) 2011 Ulrik Damm. All rights reserved.
//

#import "BKTimer.h"

@interface BKTimer ()
@property (nonatomic, strong) BKTimerCompletionBlock nonRepeatBlock;
@property (nonatomic, strong) BKTimerRepeatingCompletionBlock repeatBlock;
@property (nonatomic, assign) BOOL repeating;
@property (nonatomic, retain) NSTimer *timer;
@end

@interface BKTimer (internal)


- (id)initWithDelay:(NSTimeInterval)delay completion:(id)completion repeats:(BOOL)repeats;
- (void)timerDone;

@end

@implementation BKTimer

@synthesize timer = _timer,
            nonRepeatBlock = _nonRepeatBlock,
            repeatBlock = _repeatBlock,
            repeating = _repeating;

+ (void)timerWithDelay:(NSTimeInterval)delay completion:(BKTimerCompletionBlock)completion {
    (void) [[[self class] alloc] initWithDelay:delay completion:completion repeats:NO];
}

+ (void)repeatingTimerWithDelay:(NSTimeInterval)delay completion:(BKTimerRepeatingCompletionBlock)completion {
  (void) [[[self class] alloc] initWithDelay:delay completion:completion repeats:YES];
}

@end

@implementation BKTimer (internal)

- (id)initWithDelay:(NSTimeInterval)delay completion:(id)completion repeats:(BOOL)repeats {
	if ((self = [super init])) {
		if (repeats) {
			_repeatBlock = completion;
		} else {
			_nonRepeatBlock = completion;
		}

		_repeating = repeats;

		self.timer = [NSTimer scheduledTimerWithTimeInterval:delay target:self selector:@selector(timerDone) userInfo:nil repeats:repeats];
	}

	return self;
}

- (void)timerDone {
	if (_repeating) {
		BOOL cont = _repeatBlock();

		if (!cont) {
			[_timer invalidate];
		}
	} else {
		_nonRepeatBlock();
	}
}

- (void)dealloc {
    _repeatBlock = nil;
    _nonRepeatBlock = nil;
}

@end
