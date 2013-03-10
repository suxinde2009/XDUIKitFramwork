//
//  NSDate+XDCategory.m
//  XDUIKitFramework
//
//  Created by admin on 12-8-9.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import "NSDate+XDCategory.h"

#import "XDCorePreprocessorMacros.h"
#import "XDGlobalCoreLocale.h"

@implementation NSDate (XDCategory)


///////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSDate*)dateWithToday {
    return [[NSDate date] dateAtMidnight];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSDate*)dateAtMidnight {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:[NSDate date]];
    NSDate *midnight = [gregorian dateFromComponents:comps];
    [gregorian release];
    return midnight;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)formatTime {
    static NSDateFormatter *formatter = nil;
    if(nil == formatter) {
        formatter = [[[NSDateFormatter alloc] init] autorelease];
        formatter.dateFormat = XDLocalizedString(@"h:mm a",@"");   
        formatter.locale = XDCurrentLocale(); 
    }
    return  [formatter stringFromDate:self];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)formatDate {
    static NSDateFormatter *formatter = nil;
    if(nil == formatter) {
        formatter = [[[NSDateFormatter alloc] init] autorelease];
        formatter.dateFormat = XDLocalizedString( @"EEEE, LLLL d, YYYY", @""); 
        formatter.locale = XDCurrentLocale();
    }
    return [formatter stringFromDate:self];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)formatShortTime {
    
    NSTimeInterval diff = abs([self timeIntervalSinceNow]);
    
    if(diff < XD_DAY) {
        return [self formatTime];
    } else if (diff < XD_5_DAYS) {
        static NSDateFormatter *formatter = nil;
        formatter = [[[NSDateFormatter alloc] init] autorelease];
        formatter.dateFormat = XDLocalizedString(@"EEEE", @"") ; 
        formatter.locale = XDCurrentLocale();
        
        return [formatter stringFromDate:self];
    } else {
        static NSDateFormatter *formatter = nil;
        if(nil == formatter) {
            formatter = [[[NSDateFormatter alloc] init] autorelease];
            formatter.dateFormat = XDLocalizedString(@"M/d/yy", @"") ; 
            formatter.locale = XDCurrentLocale();
        }
        return [formatter stringFromDate:self];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)formatDateTime {
    NSTimeInterval diff = abs([self timeIntervalSinceNow]);
    if (diff < XD_DAY) {
        return [self formatTime];
        
    } else if (diff < XD_5_DAYS) {
        static NSDateFormatter* formatter = nil;
        if (nil == formatter) {
            formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = XDLocalizedString( @"EEE h:mm a", @""); 
            formatter.locale = XDCurrentLocale();
        }
        return [formatter stringFromDate:self];
        
    } else {
        static NSDateFormatter* formatter = nil;
        if (nil == formatter) {
            formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = XDLocalizedString(@"MMM d h:mm a", @""); 
            formatter.locale = XDCurrentLocale();
        }
        return [formatter stringFromDate:self];
    }

}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)formatRelativeTime {
    NSTimeInterval elapsed = [self timeIntervalSinceNow];
    if(elapsed > 0){
        if(elapsed <= 1) {
            return XDLocalizedString(@"in just a moment", @"");
        }
        else if (elapsed < XD_MINUTE) {
            int seconds = (int)elapsed;
            return [NSString stringWithFormat:XDLocalizedString(@"in %d seconds", @""), seconds];
        }
        else if (elapsed < 2 * XD_MINUTE) {
            return XDLocalizedString(@"in about a minute",@"");
        }
        else if (elapsed < XD_HOUR) {
            int mins = (int)(elapsed/XD_MINUTE);
            return [NSString stringWithFormat:XDLocalizedString(@"in %d minutes", @""), mins];
        }
        else if (elapsed < 1.5 * XD_HOUR) {
            return  XDLocalizedString(@"in about an hour", @"");
        }
        else if (elapsed < XD_DAY) {
            int hours = (int)((elapsed + XD_HOUR/2)/XD_HOUR);
            return [NSString stringWithFormat:XDLocalizedString(@"in %d hours", @""), hours];
        }
        else {
            return [self formatDateTime];
        }
    }
    else {
        elapsed = -elapsed;
        
        if(elapsed <= 1) {
            return XDLocalizedString(@"just a moment ago", @"");
        }else if (elapsed < XD_MINUTE) {
            int seconds = (int)elapsed;
            return [NSString stringWithFormat:XDLocalizedString(@"%d seconds ago", @""), seconds];
        }else if (elapsed < 2*XD_MINUTE) {
            return XDLocalizedString(@"about a minute ago", @"");
        }else if (elapsed < XD_HOUR) {
            int mins = (int)(elapsed/XD_MINUTE);
            return [NSString stringWithFormat:XDLocalizedString(@"%d minutes ago", @""), mins];
        }else if (elapsed < 1.5*XD_HOUR) {
            return XDLocalizedString(@"about an hour ago", @"");
        }else if (elapsed < XD_DAY) {
            int hours = (int)((elapsed+XD_HOUR/2)/XD_HOUR);
            return [NSString stringWithFormat:XDLocalizedString(@"%d hours ago", @""), hours];
        } else {
            return [self formatDateTime];
        }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)formatShortRelativeTime {
    NSTimeInterval elapsed = abs([self timeIntervalSinceNow]);
    
    if(elapsed < XD_MINUTE) {
        return  XDLocalizedString(@"<1m", @"");
    }else if (elapsed < XD_HOUR) {
        int mins = (int)(elapsed / XD_MINUTE);
        return [NSString stringWithFormat:XDLocalizedString(@"%dm", @""), mins];
    }else if (elapsed < XD_DAY) {
        int hours = (int)((elapsed + XD_HOUR/2)/XD_HOUR);
        return [NSString stringWithFormat:XDLocalizedString(@"%dh", @""), hours];
    }else if (elapsed < XD_WEEK) {
        int day = (int)((elapsed + XD_DAY/2)/XD_DAY);
        return [NSString stringWithFormat:XDLocalizedString(@"%dd", @""), day];
    }else {
        return [self formatShortTime];
    }
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)formatDay:(NSDateComponents*)today yesterday:(NSDateComponents*)yesterday {
    NSDateFormatter *formatter = nil;
    if(nil == formatter) {
        formatter = [[[NSDateFormatter alloc] init] autorelease];
        formatter.dateFormat = XDLocalizedString(@"MMMM d", @"");
        formatter.locale = XDCurrentLocale();
    }
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *day = [cal components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:self];
    if(day.day == today.day && day.month == today.month && day.year == today.year) {
        return XDLocalizedString(@"Today", @"");
    }else if (day.day == yesterday.day && day.month == yesterday.month && day.year == yesterday.year) {
        return XDLocalizedString(@"Yesterday", @"");
    }else {
        return [formatter stringFromDate:self];
    }
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)formatMonth {
    NSDateFormatter *formatter = nil;
    if(nil == formatter) {
        formatter = [[[NSDateFormatter alloc] init] autorelease];
        formatter.dateFormat = XDLocalizedString(@"MMMM", @"");
        formatter.locale = XDCurrentLocale();
    }
    return [formatter stringFromDate:self];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)formatYear {
    NSDateFormatter *formatter = nil;
    if(nil == formatter) {
        formatter = [[[NSDateFormatter alloc] init] autorelease];
        formatter.dateFormat = XDLocalizedString(@"yyyy", @"");
        formatter.locale = XDCurrentLocale();
    }
    return [formatter stringFromDate:self];
}



@end
