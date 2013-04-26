#import <Foundation/Foundation.h>

@interface NSDate (Utils)

- (NSDate *)offsetMonth:(int)numMonths;
- (NSDate *)offsetDay:(int)numDays;
- (NSDate *)offsetHours:(int)hours;
- (int)numDaysInMonth;
- (int)firstWeekDayInMonth;
- (int)year;
- (int)month;
- (int)day;

+ (NSDate *)dateStartOfDay:(NSDate *)date;
+ (NSDate *)dateStartOfWeek;
+ (NSDate *)dateEndOfWeek;

@end

@interface NSDate (Age)

+ (BOOL)isAgeBefore1900:(NSString *)birthDay;
+ (BOOL)isAgeOver18:(NSString *)birthDay;
+ (BOOL)isAgeOver16:(NSString *)birthDay;

@end

struct TKDateInformation {
  int day;
	int month;
	int year;
	
	int weekday;
	
	int minute;
	int hour;
	int second;
	
};
typedef struct TKDateInformation TKDateInformation;

@interface NSDate (TKCategory)

+ (NSDate *) yesterday;
+ (NSDate *) month;

- (NSDate *) monthDate;
- (NSDate *) lastOfMonthDate;



- (BOOL) isSameDay:(NSDate*)anotherDate;
- (int) monthsBetweenDate:(NSDate *)toDate;
- (NSInteger) daysBetweenDate:(NSDate*)d;
- (BOOL) isToday;


- (NSDate *) dateByAddingDays:(NSUInteger)days;
+ (NSDate *) dateWithDatePart:(NSDate *)aDate andTimePart:(NSDate *)aTime;

- (NSString *) monthString;
- (NSString *) yearString;


- (TKDateInformation) dateInformation;
- (TKDateInformation) dateInformationWithTimeZone:(NSTimeZone*)tz;
+ (NSDate*) dateFromDateInformation:(TKDateInformation)info;
+ (NSDate*) dateFromDateInformation:(TKDateInformation)info timeZone:(NSTimeZone*)tz;
+ (NSString*) dateInformationDescriptionWithInformation:(TKDateInformation)info;


@end
