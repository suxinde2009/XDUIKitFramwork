//
//  GradientView.h
//  XDCalenderViewDemo
//
//  Created by admin on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradientView : UIView
{
    @private
    NSMutableArray *_colors;
}

@property (nonatomic, readonly, retain) NSMutableArray *colors;

- (id)initWithFrame:(CGRect)frame withColors:(NSArray *)colors;
- (void)setColors:(NSMutableArray *)colors;

@end
