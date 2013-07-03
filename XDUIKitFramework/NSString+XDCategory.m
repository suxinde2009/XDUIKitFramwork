//
//  NSString+XDCategory.m
//  XDUIKitFramework
//
//  Created by admin on 12-8-10.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//

#import "NSString+XDCategory.h"

// Core
#import "XDCorePreprocessorMacros.h"
#import "NSData+XDCategory.h"
#import "XDMarkupStripper.h"

@implementation NSString (XDCategory)


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isWhitespaceAndNewlines {
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for(NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if(![whitespace characterIsMember:c]) {
            return NO;
        }
    }
    return YES;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Deprecated - https://github.com/facebook/three20/issues/367
 */

- (BOOL)isEmptyOrWhitespace {
    // A nil or NULL string is not the same as an empty string
    return 0 == self.length || !([self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)stringByRemovingHTMLTags {
    XDMarkupStripper *stripper = [[[XDMarkupStripper alloc] init] autorelease];
    return [stripper parse:self];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Copied and pasted from http://www.mail-archive.com/cocoa-dev@lists.apple.com/msg28175.html
 * Deprecated
 */

- (NSDictionary*)queryDictionaryUsingEncoding:(NSStringEncoding)encoding {
    NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    NSScanner* scanner = [[[NSScanner alloc] initWithString:self] autorelease];
    while (![scanner isAtEnd]) {
        NSString* pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count == 2) {
            NSString* key = [[kvPair objectAtIndex:0]
                             stringByReplacingPercentEscapesUsingEncoding:encoding];
            NSString* value = [[kvPair objectAtIndex:1]
                               stringByReplacingPercentEscapesUsingEncoding:encoding];
            [pairs setObject:value forKey:key];
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:pairs];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSDictionary*)queryContentsUsingEncoding:(NSStringEncoding)encoding {
    NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    NSScanner* scanner = [[[NSScanner alloc] initWithString:self] autorelease];
    while (![scanner isAtEnd]) {
        NSString* pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count == 1 || kvPair.count == 2) {
            NSString* key = [[kvPair objectAtIndex:0]
                             stringByReplacingPercentEscapesUsingEncoding:encoding];
            NSMutableArray* values = [pairs objectForKey:key];
            if (nil == values) {
                values = [NSMutableArray array];
                [pairs setObject:values forKey:key];
            }
            if (kvPair.count == 1) {
                [values addObject:[NSNull null]];
                
            } else if (kvPair.count == 2) {
                NSString* value = [[kvPair objectAtIndex:1]
                                   stringByReplacingPercentEscapesUsingEncoding:encoding];
                [values addObject:value];
            }
        }
    }
    return [NSDictionary dictionaryWithDictionary:pairs];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query {
    NSMutableArray* pairs = [NSMutableArray array];
    for (NSString* key in [query keyEnumerator]) {
        NSString* value = [query objectForKey:key];
        value = [value stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
        value = [value stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
        NSString* pair = [NSString stringWithFormat:@"%@=%@", key, value];
        [pairs addObject:pair];
    }
    
    NSString* params = [pairs componentsJoinedByString:@"&"];
    if ([self rangeOfString:@"?"].location == NSNotFound) {
        return [self stringByAppendingFormat:@"?%@", params];
        
    } else {
        return [self stringByAppendingFormat:@"&%@", params];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)stringByAddingURLEncodedQueryDictionary:(NSDictionary*)query {
    NSMutableDictionary* encodedQuery = [NSMutableDictionary dictionaryWithCapacity:[query count]];
    
    for (NSString* key in [query keyEnumerator]) {
        NSParameterAssert([key respondsToSelector:@selector(urlEncoded)]);
        NSString* value = [query objectForKey:key];
        NSParameterAssert([value respondsToSelector:@selector(urlEncoded)]);
        value = [value urlEncoded];
        key = [key urlEncoded];
        [encodedQuery setValue:value forKey:key];
    }
    
    return [self stringByAddingQueryDictionary:encodedQuery];
}


///////////////////////////////////////////////////////////////////////////////////////////////////

- (id)urlEncoded {
    CFStringRef cfUrlEncodedString = CFURLCreateStringByAddingPercentEscapes(NULL, 
                                                                             (CFStringRef)self, 
                                                                             NULL, 
                                                                             (CFStringRef)@"!#$%&'()*+,/:;=?@[]", 
                                                                             kCFStringEncodingUTF8);
    NSString *urlEncoded = [NSString stringWithString:(NSString *)cfUrlEncodedString];
    CFRelease(cfUrlEncodedString);
    return urlEncoded;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)md5Hash {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md5Hash];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)sha1Hash {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha1Hash];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL) isEmail{
	
    NSString *emailRegEx = @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"  
                           @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" 
	                       @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"  
	                       @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"  
	                       @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"  
	                       @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"  
 	                       @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";  
	
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];  
    return [regExPredicate evaluateWithObject:[self lowercaseString]];  
}

@end


#import <CommonCrypto/CommonDigest.h>

#define RANDOM_CHAR_SET @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

#define RANDOM_SEED() srandom(time(NULL))
#define RANDOM_INT(__MIN__,__MAX__) ((__MIN__)+random()%((__MAX__+1)-(__MIN__)))

@implementation NSString (Utils)
+ (BOOL)isNullOrEmpty:(NSString *)string
{
	if(string==nil) return TRUE;
	if(string.length==0) return TRUE;
	return FALSE;
}

+ (BOOL)validateEmail:(NSString *)emailAddress
{
	if([NSString isNullOrEmpty:emailAddress])
		return FALSE;
	
	NSString *stricterFilterString = 
                                     @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"  
                                     @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" 
                                     @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"  
                                     @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"  
                                     @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"  
                                     @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"  
                                     @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    //@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";  
    NSString *emailRegex = stricterFilterString ? stricterFilterString : laxString;  
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    return [emailTest evaluateWithObject:emailAddress];  
}


- (NSString *)decodeXML
{
    if(self == nil){
        return @"";
    }
	NSString *xmlString = self;
	xmlString = [xmlString stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
	xmlString = [xmlString stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
	xmlString = [xmlString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
	xmlString = [xmlString stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
	xmlString = [xmlString stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
	//NSXmlString
	return xmlString;
}

- (NSString *)encodeXML
{
    if(self == nil){
        return @"";
    }
	NSString *xmlString = self;
	xmlString = [xmlString stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
	xmlString = [xmlString stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
	xmlString = [xmlString stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
	xmlString = [xmlString stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
	xmlString = [xmlString stringByReplacingOccurrencesOfString:@"'" withString:@"&apos;"];
	//NSXmlString
	return xmlString;
}

- (CGSize)getWrapSize:(CGFloat)fontSize width:(CGFloat)width isDefault:(BOOL)isDefault
{
    CGSize constraintSize = CGSizeMake(width,MAXFLOAT);
    CGSize expectedSize = [self sizeWithFont:(isDefault?[UIFont systemFontOfSize:fontSize]:[UIFont boldSystemFontOfSize:fontSize])
                           constrainedToSize:constraintSize
                               lineBreakMode:UILineBreakModeWordWrap];
    return expectedSize;
}

//
+ (NSString *)htmlEncode:(NSString *)string
{
    if (string == nil) {
        return @"";
    }
	NSString *text = [string stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
	text = [text stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
	text = [text stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
	text = [text stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
	text = [text stringByReplacingOccurrencesOfString:@"'" withString:@"&#309;"];
	//text = [text stringByReplacingOccurrencesOfString:@"" withString:@"&nbsp;"];
	return text;
}

+ (NSString *)htmlDecode:(NSString *)string
{
    if (string == nil) {
        return nil;
    }
	NSString *text = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
	text = [text stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
	text = [text stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
	text = [text stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
	text = [text stringByReplacingOccurrencesOfString:@"&#309;" withString:@"'"];
	text = [text stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
	return text;
}

- (BOOL)startWith:(NSString *)s
{
	if ([self length] >= [s length] && [[self substringToIndex:[s length]] isEqualToString:s])
		return YES;
	return FALSE;
}


+ (NSString *)dateString
{
	// return a formatted string for a file name
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	formatter.dateFormat = @"yyMMddhhmmss";
    //NSLog(@"DateString:%@",[formatter stringFromDate:[NSDate date]]);
	return [formatter stringFromDate:[NSDate date]];
}

- (NSString *) md5HexDigest
{
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

+ (NSString *)trim:(NSString *)string
{
    if(string == nil) return nil;
    if(string.length == 0) return string;
    NSString *s = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return [NSString stringWithFormat:@"%@",s];
}

- (NSString *)URLEncodedString 
{
    NSString *result = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (CFStringRef)self,
                                                                           NULL,
																		   CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                           kCFStringEncodingUTF8);
    [result autorelease];
	return result;
}

- (NSString*)URLDecodedString
{
	NSString *result = (NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
																						   (CFStringRef)self,
																						   CFSTR(""),
																						   kCFStringEncodingUTF8);
    [result autorelease];
	return result;	
}


+ (NSString *)reverseString:(NSString *)string
{
    const char *cString = [string cStringUsingEncoding:NSUTF8StringEncoding];
    int length = string.length;
    char *tempCString = (char *)malloc(sizeof(char)*length);
    for(int i = 0; i < length; i++)
    {
        tempCString[i] = cString[length-i-1];
    }
    
    NSString *tempString = [NSString stringWithFormat:@"%s", tempCString];
    free(tempCString);
    
    return tempString;
}

- (BOOL)isSubString:(NSString *)string
{
    NSRange range = [self rangeOfString:string];
    if(range.location == NSNotFound)
        return FALSE;
    return TRUE;
}

- (BOOL)isSubString:(NSString *)string options:(NSStringCompareOptions)mask
{
    NSRange range = [self rangeOfString:string options:mask];
    if(range.location == NSNotFound)
        return FALSE;
    return TRUE;
}

- (BOOL)caseInsensitiveSameTo:(NSString *)string
{
    return [[self lowercaseString] isEqualToString:[string lowercaseString]];
}

@end
