//
//  NSString+XDCategory.h
//  XDUIKitFramework
//
//  Created by admin on 12-8-10.
//  Copyright (c) 2012年 __MyCompany__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "XDCorePreprocessorMacros.h" // For __XDDEPRECATED_METHOD

/**
 * Doxygen does not handle categories very well
 */
@interface NSString (XDCategory)

/**
 * Determines if the string contains only whitespace and newlines.
 */
- (BOOL)isWhitespaceAndNewlines;

/**
 * Determines if the string is empty or contains only whitespace.
 * @deprecated Use TTIsStringWithAnyText() instead. Updating your use of
 * this method is non-trivial. See the note below.
 *
 * Notes for updating your use of isEmptyOrWhitespace:
 *
 * if (!textField.text.isEmptyOrWhitespace) {
 *
 * becomes
 *
 * if (TTIsStringWithAnyText(textField.text) && !textField.text.isWhitespaceAndNewlines) {
 *
 * and
 *
 * if (textField.text.isEmptyOrWhitespace) {
 *
 * becomes
 *
 * if (0 == textField.text.length || textField.text.isWhitespaceAndNewlines) {
 */
- (BOOL)isEmptyOrWhitespace __XDDEPRECATED_METHOD;

/**
 * Parses a URL query string into a dictionary.
 *
 * @deprecated Use queryContentsUsingEncoding: instead.
 */
- (NSDictionary*)queryDictionaryUsingEncoding:(NSStringEncoding)encoding __XDDEPRECATED_METHOD;

/**
 * Parses a URL query string into a dictionary where the values are arrays.
 */
- (NSDictionary*)queryContentsUsingEncoding:(NSStringEncoding)encoding;

/**
 * Parses a URL, adds query parameters to its query, and re-encodes it as a new URL.
 */
- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query;

/**
 * Parses a URL, adds urlEncoded query parameters to its query, and re-encodes it as a new URL.
 *
 * This method encodes keys and values of query using [NSString urlEncoded] and calls
 * stringByAddingQueryDictionary with the resulting dictionary.
 *
 * @throw NSInvalidArgumentException If any value or key does not respond to urlEncoded.
 */
- (NSString*)stringByAddingURLEncodedQueryDictionary:(NSDictionary*)query;

/**
 * Returns a URL Encoded String
 */
- (NSString*)urlEncoded;

/**
 * Returns a string with all HTML tags removed.
 */
- (NSString*)stringByRemovingHTMLTags;

/**
 * Calculate the md5 hash of this string using CC_MD5.
 *
 * @return md5 hash of this string
 */
@property (nonatomic, readonly) NSString* md5Hash;

/**
 * Calculate the SHA1 hash of this string using CommonCrypto CC_SHA1.
 *
 * @return NSString with SHA1 hash of this string
 */
@property (nonatomic, readonly) NSString* sha1Hash;


/**
 * Judge the email is valid
 *
 * @return a BOOL variable
 */
- (BOOL) isEmail;

@end


@interface NSString (Utils)

- (CGSize)wrapString:(float)width
            fontSize:(float)fontSize
           isDefault:(BOOL)isDefault;

- (float)wrapStringHeight:(float)width
                 fontSize:(float)fontSize
                isDefault:(BOOL)isDefault;

- (CGSize)getWrapSize:(float)fontSize
                width:(float)width
            isDefault:(BOOL)isDefault;

+ (BOOL)isNullOrEmpty:(NSString *)string;
- (NSString *)decodeXML;
- (NSString *)encodeXML;  

+ (NSString *)htmlEncode:(NSString *)string;
+ (NSString *)htmlDecode:(NSString *)string;
- (BOOL)startWith:(NSString *)s;

+ (BOOL)validateEmail:(NSString *)emailAddress;

+(NSString *)dateString;

- (NSString *) md5HexDigest;
+ (NSString *)trim:(NSString *)string;

- (NSString *)URLEncodedString; 
- (NSString*)URLDecodedString;

+ (NSString *)reverseString:(NSString *)string;
- (BOOL)isSubString:(NSString *)string;
- (BOOL)isSubString:(NSString *)string options:(NSStringCompareOptions)mask;

- (BOOL)caseInsensitiveSameTo:(NSString *)string;

@end
