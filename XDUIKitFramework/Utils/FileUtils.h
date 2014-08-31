//
//  FileUtils.h
//  TcpFileTransferDemo
//
//  Created by p2pmsg on 14-4-2.
//  Copyright (c) 2014年 P2P TECH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZipArchive.h"


#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define FILEPATH [DOCUMENTS_FOLDER stringByAppendingPathComponent:[self dateString]]

#define DOCUMENTS_AUDIO_FOLDER [DOCUMENTS_FOLDER stringByAppendingPathComponent:@"AudioDir"]
#define DOCUMENTS_VIDEO_FOLDER [DOCUMENTS_FOLDER stringByAppendingPathComponent:@"VideoDir"]
#define DOCUMENTS_VIDEO_IMG_FOLDER [DOCUMENTS_FOLDER stringByAppendingPathComponent:@"VideoImgDir"]
#define DOCUMENTS_TPK_FOLDER [DOCUMENTS_FOLDER stringByAppendingPathComponent:@"TpksDir"]
#define DOCUMENTS_DATABASE_FOLDER [DOCUMENTS_FOLDER stringByAppendingPathComponent:@"LocalDatabases"]

#define DOCUMENTS_TEMP_IMAGES_FOLDER [DOCUMENTS_FOLDER stringByAppendingPathComponent:@"TempImages"]
#define DOCUMENTS_EXCEPTIONS_FOLDER [DOCUMENTS_FOLDER stringByAppendingPathComponent:@"Exceptions"]

@interface FileUtils : NSObject

+ (BOOL)deleteFileAtPath:(NSString *)path;

+ (void)createFileDirectory:(NSString *)dir;

+ (void)createFileDirectories;

+ (NSString *)audioFilePath:(NSString *)fileName;

+ (NSString *)videoFilePath:(NSString *)fileName;
+ (NSString *)videoFileImgPath:(NSString *)fileName;

+ (NSString *)tpkFilePath:(NSString *)fileName;
+ (NSString *)tempImageFilePath:(NSString *)fileName;

+ (NSInteger) getFileSize:(NSString*) path;



////////////////////////////////
//  解压文件
////////////////////////////////
+ (void)unZipFile:(NSString *)zipFilePath
  toUnzipFilePath:(NSString *)unzipFilePath;


+ (void)writeFile:(NSData *)fileData
           toPath:(NSString *)filePath;



////////////////////////////////
//  检查文件是否存在
////////////////////////////////
+ (BOOL)isFileExistAtPath:(NSString *)path;


////////////////////////////////
//  检查文件夹是否存在
////////////////////////////////
+ (BOOL)isDirExistAtPath:(NSString *)dirPath;




@end
