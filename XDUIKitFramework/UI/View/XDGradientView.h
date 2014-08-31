//
//  XDGradientView.h
//  XDUIKitFramework
//
//  Created by admin.konnech on 13-2-20.
//  Copyright (c) 2013年 __MyCompany__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XDGradientView : UIView
{
@private
    NSMutableArray *_colors;
}

@property (nonatomic, readonly, retain) NSMutableArray *colors;

- (id)initWithFrame:(CGRect)frame withColors:(NSArray *)colors;
- (void)setColors:(NSMutableArray *)colors;

@end
