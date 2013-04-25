//
//  NSURLConnection+Blocks.m
//  Methods
//
//  Created by Ulrik Damm on 30/9/11.
//  Copyright (c) 2011 Ulrik Damm. All rights reserved.
//

#import "BKDownload.h"

@interface NSURLConnectionBlocksDelegate : NSObject <NSURLConnectionDataDelegate> {
  BKDownloadDataCompletionBlock completion;
	NSMutableData *data;
}

- (id)initWithBlock:(BKDownloadDataCompletionBlock)block;

@end

@implementation BKDownload

- (id)init {
	[NSException raise:@"BKDownloadException" format:@"Do not alloc BKDownload!"];
	return nil;
}

+ (void)dataDownloadWithRequest:(NSURLRequest*)request completion:(BKDownloadDataCompletionBlock)completion {
	NSURLConnectionBlocksDelegate *delegate = [[[NSURLConnectionBlocksDelegate alloc] initWithBlock:completion] autorelease];

	[NSURLConnection connectionWithRequest:request delegate:delegate];
}

+ (void)imageDownloadWithRequest:(NSURLRequest*)request completion:(BKDownloadImageCompletionBlock)completion {
	[[self class] dataDownloadWithRequest:request completion:^(NSData *result, NSError *error) {
		completion(result == nil? nil: [UIImage imageWithData:result], error);
	}];
}

+ (void)stringDownloadWithRequest:(NSURLRequest*)request completion:(BKDownloadStringCompletionBlock)completion {
	[[self class] dataDownloadWithRequest:request completion:^(NSData *result, NSError *error) {
		completion(result == nil? nil: [[[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding] autorelease], error);
	}];
}

@end

@implementation NSURLConnectionBlocksDelegate

- (id)initWithBlock:(BKDownloadDataCompletionBlock)block {
	if ((self = [super init])) {
		completion = Block_copy(block);
		data = nil;
	}

	return [self retain];
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	data = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	completion(nil, error);
	[self release];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)newdata {
	[data appendData:newdata];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	completion(data, nil);
	[self release];
}

- (void)dealloc {
	Block_release(completion);
	[data release];

	[super dealloc];
}

@end

@implementation NSString (BKDownload)

- (NSURLRequest*)URLRequest {
	return [NSURLRequest requestWithURL:[NSURL URLWithString:self]];
}

@end
