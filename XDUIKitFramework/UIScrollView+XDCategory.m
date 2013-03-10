//
//  UIScrollView+XDCategory.m
//  XDUIKitFramework
//
//  Created by admin on 12-8-14.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import "UIScrollView+XDCategory.h"

@implementation UIScrollView (XDCategory)

- (void)scrollToTop{
    self.contentOffset = CGPointMake(0.0f, 0.0f);
}

@end
