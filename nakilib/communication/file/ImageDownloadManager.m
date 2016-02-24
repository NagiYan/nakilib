//
//  ImageDownloadManager.m
//  HealthManagement
//
//  Created by Gareamac on 14-6-19.
//  Copyright (c) 2014年 Gareatech. All rights reserved.
//

#import "ImageDownloadManager.h"
#import "FileUtil.h"

@implementation ImageDownloadManager

+(UIImage *) getImageFromURL:(NSString *)fileURL
{
    NSLog(@"执行图片下载函数");
    UIImage * result;
    NSData * data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    [data release];
    return result;
}

+(void) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath
{
    if (!directoryPath || [directoryPath isEqualToString:@""])
    {
        directoryPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    }
    
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:directoryPath isDirectory:&isDir];
    if ( !(isDir && existed) )
    {
        [fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    [FileUtil addSkipBackupAttributeToPath:directoryPath];
    
    if ([[extension lowercaseString] isEqualToString:@"png"])
    {
        [UIImagePNGRepresentation(image) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]] options:NSAtomicWrite error:nil];
    }
    else if ([[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"])
    {
        NSError* er = [[NSError alloc] init];
        BOOL ret = [UIImageJPEGRepresentation(image, 1.0) writeToFile:[directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]] options:NSAtomicWrite error:&er];
        if (!ret)
        {
            //NSLog(@"%@", er);
        }
    }
    else
    {
        //ALog(@"Image Save Failed\nExtension: (%@) is not recognized, use (PNG/JPG)", extension);
        NSLog(@"文件后缀不认识");
    }
}


+(UIImage *) loadImage:(NSString *)fileName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath
{
    UIImage * result = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.%@", directoryPath, fileName, extension]];
    
    return result;
}

+ (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image)
    {
        newimage = nil;
    }
    
    else
    {
        UIGraphicsBeginImageContext(asize);
        [image drawInRect:CGRectMake(0, 0, asize.width, asize.height)];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return newimage;
}

+ (BOOL)imgExist:(NSString*)fileName inDirectory:(NSString *)directoryPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *filePath = [directoryPath stringByAppendingString:@"/"];
    filePath = [filePath stringByAppendingString:fileName];
    
    if(![fileManager fileExistsAtPath:filePath])
        return NO;
    
    return YES;
}

// 下载单张图片
+ (void)downLoadSaveImageWithThumb:(NSString*)imgPath name:(NSNumber*)pid dir:(NSString*)documentsDirectoryPath
{
    // 原图和缩略图
    NSString* bigName = [NSString stringWithFormat:@"%d_b", [pid intValue]];
    NSString* thumbName = [NSString stringWithFormat:@"%d_t", [pid intValue]];
    
    if ([ImageDownloadManager imgExist:[bigName stringByAppendingString:@".jpg"] inDirectory:documentsDirectoryPath])
    {
        return;
    }
    
    UIImage * imageBig = [ImageDownloadManager getImageFromURL:imgPath];
    UIImage * imageThumb = [ImageDownloadManager thumbnailWithImage:imageBig size:CGSizeMake(60, 60)];
    
    // 保存原图和缩略图
    [ImageDownloadManager saveImage:imageBig withFileName:bigName ofType:@"jpg" inDirectory:documentsDirectoryPath];
    [ImageDownloadManager saveImage:imageThumb withFileName:thumbName ofType:@"jpg" inDirectory:documentsDirectoryPath];
}

+ (UIImage*)getImageById:(NSInteger)pid _mode:(int)mode subDir:(NSString*)subDir
{
    NSString* imgName = nil;
    if (mode == 0)
    {
        // 默认为缓存图
        imgName = [NSString stringWithFormat:@"%d_t.jpg", pid];
    }
    else
    {
        imgName = [NSString stringWithFormat:@"%d_b.jpg", pid];
    }
    
    NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    documentsDirectoryPath = [documentsDirectoryPath stringByAppendingString:subDir];
    NSString *filestr = imgName;
    NSString *newstr = [documentsDirectoryPath stringByAppendingString:@"/"];
    newstr = [newstr stringByAppendingString:filestr];
    
    NSData *dd = [NSData dataWithContentsOfFile:newstr];
    UIImage* img = [UIImage imageWithData:dd];
    return img;
}

@end
