//
//  FileUtil.h
//  Community
//
//  Created by BST on 13-6-5.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FileUtil : NSObject {
    
}

+(BOOL) isFileExits:(NSString*) filePath;

+(NSString*) getFullPathOfResourceFile:(NSString*) fileTitle ofType:(NSString*)type;

+(NSString*) getDirectoryPathCache;

+(NSString*) getDirectoryPathDocument;

+(NSString*) getFullPathOfFile:(NSString*) fileName;

+(NSString*) getFullPathOfFile:(NSString*) fileName ofType:(NSString*)type;

+ (BOOL)makeSurePath:(NSString*)path;

+ (void)addSkipBackupAttributeToPath:(NSString*)path;

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

+ (void)cleanPath:(NSString*)path;

// MB
+ (float)fileSizeAtPath:(NSString *)path;

// 获取缓存大小
+ (float)folderSizeAtPath:(NSString *)path;

// 清除目录
+ (void)clearCache:(NSString *)path;
@end