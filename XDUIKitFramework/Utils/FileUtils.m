//
//  FileUtils.m
//  TcpFileTransferDemo
//
//  Created by p2pmsg on 14-4-2.
//  Copyright (c) 2014年 P2P TECH. All rights reserved.
//

#import "FileUtils.h"


@implementation FileUtils


+ (BOOL)deleteFileAtPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDeleted = [fileManager removeItemAtPath:path error:nil];
    return isDeleted;
}

+ (void)createFileDirectory:(NSString *)dir
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isDir = FALSE;
    
    BOOL isDirExist = [fileManager fileExistsAtPath:dir
                                        isDirectory:&isDir];
    
    // 判断文件夹是否存在，不存在则创建对应文件夹
    if(!(isDirExist && isDir))
    {
        
        BOOL bCreateDir = [fileManager createDirectoryAtPath:dir
                                 withIntermediateDirectories:YES
                                                  attributes:nil
                                                       error:nil];
        
        if(!bCreateDir){
            
            NSLog(@"Create Directory Failed: %@", dir);
            
        }
        
        NSLog(@"Create Directory Successed: %@",dir);
        
    }
}


+ (void)createFileDirectories
{
    [FileUtils createFileDirectory:DOCUMENTS_AUDIO_FOLDER];
    [FileUtils createFileDirectory:DOCUMENTS_VIDEO_FOLDER];
    [FileUtils createFileDirectory:DOCUMENTS_VIDEO_IMG_FOLDER];
    [FileUtils createFileDirectory:DOCUMENTS_TPK_FOLDER];
    
    // 存放缓存图片文件
    [FileUtils createFileDirectory:DOCUMENTS_TEMP_IMAGES_FOLDER];
    
    // 存放异常文件
    [FileUtils createFileDirectory:DOCUMENTS_EXCEPTIONS_FOLDER];
}

+ (NSString *)audioFilePath:(NSString *)fileName
{
    return [DOCUMENTS_AUDIO_FOLDER stringByAppendingPathComponent:fileName];
}

+ (NSString *)videoFilePath:(NSString *)fileName;
{
    return [DOCUMENTS_VIDEO_FOLDER stringByAppendingPathComponent:fileName];
}

+ (NSString *)videoFileImgPath:(NSString *)fileName
{
    return [DOCUMENTS_VIDEO_IMG_FOLDER stringByAppendingPathComponent:fileName];
}

+ (NSString *)tpkFilePath:(NSString *)fileName
{
    return [DOCUMENTS_TPK_FOLDER stringByAppendingPathComponent:fileName];
}

+ (NSString *)tempImageFilePath:(NSString *)fileName
{
    return [DOCUMENTS_TEMP_IMAGES_FOLDER stringByAppendingPathComponent:fileName];
}

+ (NSInteger)getFileSize:(NSString*) path
{
    NSFileManager * filemanager = [[[NSFileManager alloc] init] autorelease];
    if([filemanager fileExistsAtPath:path]){
        NSDictionary * attributes = [filemanager attributesOfItemAtPath:path error:nil];
        NSNumber *theFileSize;
        if ( (theFileSize = [attributes objectForKey:NSFileSize]) )
            return  [theFileSize intValue]/1024;
        else
            return -1;
    }
    else
    {
        return -1;
    }
}

// 解压文件
+ (void)unZipFile:(NSString *)zipFilePath
  toUnzipFilePath:(NSString *)unzipFilePath
{
    ZipArchive *za = [[ZipArchive alloc] init];
    if ([za UnzipOpenFile:zipFilePath]) {
        BOOL rc = [za UnzipFileTo:unzipFilePath overWrite:YES];
        if (rc == YES) {
            NSFileManager *fm = [NSFileManager defaultManager];
            BOOL rmRC = [fm removeItemAtPath:zipFilePath error:nil];
            if (rmRC == FALSE) {
                NSLog(@"解压完成删除文件失败");
            }
        }
    }
    [za release];
}


+ (void)writeFile:(NSData *)fileData
           toPath:(NSString *)filePath
{
    [fileData writeToFile:filePath atomically:YES];

}

// 判断文件是否存在
+ (BOOL)isFileExistAtPath:(NSString *)path
{
    NSFileManager *fm = [NSFileManager defaultManager];
    return [fm fileExistsAtPath:path];
}


+ (BOOL)isDirExistAtPath:(NSString *)dirPath
{
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isExist = [fm fileExistsAtPath:dirPath
                            isDirectory:&isDir];
    
    if (isDir && isExist) {
        return YES;
    }
    return FALSE;
}

@end
