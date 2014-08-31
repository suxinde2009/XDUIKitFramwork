/*
 The MIT License (MIT)
 
 Copyright (c) 2013 SuXinDe (Email: suxinde2009@126.com)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import "XDFileDownloadManager.h"

@implementation XDFileDownloadManager

@synthesize delegate = mDelegate;
@synthesize title = mTitle;

- (id)init
{
    if (self = [super init]) {
        UIWindow *window = [[UIApplication sharedApplication] windows][0];
        mLoadingDialog = [[XDDialog alloc] initWithWindow:window];
        mProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, 220.0f, 21.0f)];
        mDownloadedData = [[NSMutableData alloc] initWithCapacity:0];
    }
    return self;
}

- (id)initWithFileUrl:(NSString *)fileUrl
  downloadToDirectory:(NSString *)fileDir
{
    if (self = [super init]) {
        
        UIWindow *window = [[UIApplication sharedApplication] windows][0];
        mLoadingDialog = [[XDDialog alloc] initWithWindow:window];
        mProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, 220.0f, 21.0f)];
        mDownloadedData = [[NSMutableData alloc] initWithCapacity:0];
        
        mFileUrl = [[NSURL URLWithString:fileUrl] retain];
        mFileDir = [[NSString stringWithFormat:@"%@", fileDir] retain];
    }
    return self;
}


- (void)setFileUrl:(NSString *)fileUrl
{
    if (mFileUrl) {
        [mFileUrl release];
        mFileUrl = nil;
    }
    
    mFileUrl = [[NSURL URLWithString:fileUrl] retain];
    
}


- (void)setFileName:(NSString *)fileName
{
    if (mFileName) {
        [mFileName release];
        mFileName = nil;
    }
    mFileName = [[NSString stringWithFormat:@"%@", fileName] retain];
}

- (void)setFilePath:(NSString *)filePath
{
    if (mFilePath) {
        [mFilePath release];
        mFilePath = nil;
    }
    
    mFilePath = [[NSString stringWithFormat:@"%@", filePath] retain];
}

- (void)setFileDirecotry:(NSString *)fileDir
{
    if (mFileDir) {
        [mFileDir release];
        mFileDir = nil;
    }
    
    mFileDir = [[NSString stringWithFormat:@"%@", fileDir] retain];
}


- (void)cancelDownloading
{
    [self stopDownloading];
    
    if (mURLConnection) {
        [mURLConnection cancel];
        [mURLConnection release];
        mURLConnection = nil;
    }
    
	NSError *error;
	//NSString *filePath = [NSString stringWithFormat:@"%@",mFileName];
    //NSString *filePath = [mFileDir stringByAppendingPathComponent:mFileName];
	if([[NSFileManager defaultManager] fileExistsAtPath:mFileDir]){
		[[NSFileManager defaultManager] removeItemAtPath:mFileDir error:&error];
	}
    
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(downloadManagerDataDownloadCancelled:)])
    {
        [self.delegate downloadManagerDataDownloadCancelled:mFileDir];
    }
    
}

+ (instancetype)sharedInstance
{
    static XDFileDownloadManager *__sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[XDFileDownloadManager alloc] init];
    });
    return __sharedInstance;
}


- (void)startDownloading
{
    [self cancelDownloading];
    
    [mDownloadedData setLength:0];
    
    mLoadingDialog.dialogStyle = XDDialogStyleCustomView;
    [mLoadingDialog removeAllControls];
    mLoadingDialog.title = mFileName;
    mLoadingDialog.title = mTitle;
    mLoadingDialog.subtitle = [NSString stringWithFormat:@"0.0 KB / 0.0 KB"];
    mLoadingDialog.customView = mProgressView;
    
    mProgressView.progress = 0.0f;
    
    [mLoadingDialog addButtonWithTitle:@"Cancel"
                                target:self
                              selector:@selector(cancelDownloading)];
    
    [mLoadingDialog showOrUpdateAnimated:YES];
    
    
    mURLConnection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:mFileUrl] delegate:self];
}


- (void)stopDownloading
{
    [mLoadingDialog hideAnimated:YES];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	mCurrentDownloadedFileSize = 0;
    mTotalFileSize = [response expectedContentLength];
	
	// Check for bad connection
	if ([response expectedContentLength] < 0) {
		NSString *reason = [NSString stringWithFormat:@"Invalid URL [%@]", [mFileUrl absoluteString]];
		DELEGATE_CALLBACK(downloadManagerDataDownloadFailed:, reason);
		[connection cancel];
		return;
	}

    
	if ([response suggestedFilename]) {
		//DELEGATE_CALLBACK(downloadManagerDidReceiveData:, [response suggestedFilename]);
        mFileName = [[response suggestedFilename] retain];
	}
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [mDownloadedData appendData:data];
	mCurrentDownloadedFileSize = mCurrentDownloadedFileSize + [data length];
    float progress = ((float) mCurrentDownloadedFileSize) / mTotalFileSize;
    mProgressView.progress = progress;
    
	
    const float bytes = 1024.0f;
    const float MB_bytes = bytes * bytes;
    
    float currentDownLoadKbs = mCurrentDownloadedFileSize / MB_bytes;
    float totolFileKbs = mTotalFileSize / MB_bytes;
    
    
    NSLog(@"%@", [NSString stringWithFormat:@"%f MB / %f MB", currentDownLoadKbs, totolFileKbs]);
    
    mLoadingDialog.title = mTitle;
    mLoadingDialog.subtitle = [NSString stringWithFormat:@"%f MB / %f MB", currentDownLoadKbs, totolFileKbs];
    [mLoadingDialog setNeedsDisplay];

}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSAssert(mFileDir != nil, @"下载文件路夹未指定");
    NSString *filePath = [mFileDir stringByAppendingPathComponent:mFileName];
    [FileUtils writeFile:mDownloadedData toPath:filePath];
    
    [self stopDownloading];

    if (mURLConnection) {
        [mURLConnection cancel];
        [mURLConnection release];
        mURLConnection = nil;
    }
    
    
    DELEGATE_CALLBACK(downloadManagerDataDownloadDone:, filePath);
    
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    DELEGATE_CALLBACK(downloadManagerDataDownloadFailed:, error.localizedDescription);
    
    [self cancelDownloading];
}

- (void)writeToFile:(NSData *)fileData name:(NSString *)name
{
    
    NSString *filePath = [DOCUMENTS_FOLDER stringByAppendingPathComponent:name];
    
    [FileUtils writeFile:fileData toPath:filePath];
    
}

@end
