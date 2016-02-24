//
//  FileUtil.m
//  Community
//
//  Created by BST on 13-6-5.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "FileUtil.h"
#include <sys/xattr.h>
#import "FileUtil.h"

@implementation FileUtil

+(BOOL) isFileExits:(NSString*) filePath
{
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    
    return fileExists;
}

+(NSString*) getFullPathOfResourceFile:(NSString*) fileTitle ofType:(NSString*)type
{
    return [[NSBundle mainBundle] pathForResource:fileTitle ofType:type];
}

+(NSString*) getDirectoryPathCache
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+(NSString*) getDirectoryPathDocument
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+(NSString*) getFullPathOfFile:(NSString*) fileName
{
    NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];

    return [NSString stringWithFormat:@"%@/%@", documentsDirectoryPath, fileName];
}

+(NSString*) getFullPathOfFile:(NSString*) fileName ofType:(NSString*)type
{
    NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    return [NSString stringWithFormat:@"%@/%@.%@", documentsDirectoryPath, fileName, type];
}

+ (BOOL)makeSurePath:(NSString*)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
}
//设置扩展属性
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    const char* filePath = [[URL path] fileSystemRepresentation];
    
    const char* attrName = "com.apple.MobileBackup";
    u_int8_t attrValue = 1;
    
    int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
    return result == 0;
}

+ (void)addSkipBackupAttributeToPath:(NSString*)path
{
    u_int8_t b = 1;
    const char* attrName = "com.apple.MobileBackup";
    setxattr([path fileSystemRepresentation], attrName, &b, 1, 0, 0);
}

+ (void)cleanPath:(NSString*)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //NSArray *contents = [fileManager contentsOfDirectoryAtPath:path error:NULL];
    //NSEnumerator *e = [contents objectEnumerator];
    NSError* error;
    [fileManager removeItemAtPath:path error:&error];
    /*
    NSString *filename;
    while ((filename = [e nextObject]))
    {
        [fileManager removeItemAtPath:[path stringByAppendingPathComponent:filename] error:NULL];
    }
     */
}

// MB
+ (float)fileSizeAtPath:(NSString *)path
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path])
    {
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

// 获取缓存大小
+ (float)folderSizeAtPath:(NSString *)path
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize = 0;
    if ([fileManager fileExistsAtPath:path])
    {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles)
        {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize += [FileUtil fileSizeAtPath:absolutePath];
        }
        
        return folderSize;
    }
    return 0;
}

// 清除缓存
+ (void)clearCache:(NSString *)path
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path])
    {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles)
        {
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}
@end
