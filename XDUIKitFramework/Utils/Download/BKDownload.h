//
//  NSURLConnection+Blocks.h
//  Methods
//
//  Created by Ulrik Damm on 30/9/11.
//  Copyright (c) 2011 Ulrik Damm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BKDownloadDataCompletionBlock)(NSData *result, NSError *error);
typedef void(^BKDownloadImageCompletionBlock)(UIImage *result, NSError *error);
typedef void(^BKDownloadStringCompletionBlock)(NSString *result, NSError *error);

@interface BKDownload : NSObject

+ (void)dataDownloadWithRequest:(NSURLRequest*)request completion:(BKDownloadDataCompletionBlock)completion;
+ (void)imageDownloadWithRequest:(NSURLRequest*)request completion:(BKDownloadImageCompletionBlock)completion;
+ (void)stringDownloadWithRequest:(NSURLRequest*)request completion:(BKDownloadStringCompletionBlock)completion;

@end

@interface NSString (BKDownload)

- (NSURLRequest*)URLRequest;

@end
