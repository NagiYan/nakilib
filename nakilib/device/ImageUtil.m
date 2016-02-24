//
//  URLImageUtil.m
//  Community
//
//  Created by BST on 13-6-5.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "ImageUtil.h"
#import "EncodeUtil.h"
#import "FileUtil.h"

@implementation ImageUtil


+(UIImage *) loadImageFromURL:(NSString *)fileURL
{
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}

+(BOOL) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath
{
    NSString* finalPath = @"";
    BOOL state = [FileUtil makeSurePath:directoryPath];
    if( [[extension lowercaseString] isEqualToString:@"png"] )
    {
        finalPath = [directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"png"]];
        state = [UIImagePNGRepresentation(image) writeToFile:finalPath options:NSAtomicWrite error:nil];
        
    }
    else if( [[extension lowercaseString] isEqualToString:@"jpg"] || [[extension lowercaseString] isEqualToString:@"jpeg"] )
    {
        finalPath = [directoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]];
        state = [UIImageJPEGRepresentation(image, 1.0) writeToFile:finalPath options:NSAtomicWrite error:nil];
    }
    return state;
}

+(UIImage *) loadImage:(NSString *)fileName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath
{
    UIImage * result = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.%@", directoryPath, fileName, extension]];
    
    return result;
}

+(NSString*) loadImagePathFromURL:(NSString*)url
{
    if( url == nil || [url isEqualToString:@""] )
        return @"";
    
    NSRange range = [url rangeOfString:@"/" options:NSBackwardsSearch];
    
    NSString    *fileID = nil;
    
    if( range.length != 0 )
        fileID = [url substringFromIndex:range.location+1];
    else
        fileID = url;

    NSString    *fileName = [EncodeUtil stringToHexArray:fileID];
    NSString    *folderPath = [FileUtil getDirectoryPathCache];
    NSString    *filePath = [FileUtil getFullPathOfFile:fileName ofType:@"jpg"];
    
    if( [FileUtil isFileExits:filePath] )
        return filePath;
    
    UIImage *image = [ImageUtil loadImageFromURL:url];
    
    [ImageUtil saveImage:image withFileName:fileName ofType:@"jpg" inDirectory:folderPath];
    
    return filePath;
}

+(void) downloadImageToClientFromURL:(NSString*)url
{
    [ImageUtil loadImagePathFromURL:url];
}

+(UIImage*) loadImageFromClientByURL:(NSString*)url
{
    NSString*   filePath = [ImageUtil loadImagePathFromURL:url];
    UIImage*    image = [UIImage imageWithContentsOfFile:filePath];
    
    return image;
}

+(NSData*) getRawImageDataFromImage:(UIImage*)image ofType:(NSString*)type {
        
    if( [type isEqualToString:@"png"] || [type isEqualToString:@"PNG"] ) {
        return [NSData dataWithData:UIImagePNGRepresentation(image)];
    }
    
    return [NSData dataWithData:UIImageJPEGRepresentation(image, 1.0)];
}

+(void) setShadow:(UIView*)view allSide:(BOOL)allSide withBoard:(BOOL)with
{
    // 边框向内 阴影向外
    if (with)
    {
        //添加边框
        CALayer * layer = [view layer];
        layer.borderColor = [[UIColor whiteColor] CGColor];
        layer.borderWidth = 3.0f;
    }
    
    if (allSide)
    {
        //添加四个边阴影
        view.layer.shadowColor = [UIColor blackColor].CGColor;
        view.layer.shadowOffset = CGSizeMake(0, 0);
        view.layer.shadowOpacity = 0.5;
        view.layer.shadowRadius = 2.0;
    }
    else
    {
        view.layer.shadowColor = [UIColor blackColor].CGColor;
        view.layer.shadowOffset = CGSizeMake(4, 4);
        view.layer.shadowOpacity = 0.5;
        view.layer.shadowRadius = 2.0;
    }
}

+(CGColorRef) getColorFromRed:(int)red Green:(int)green Blue:(int)blue Alpha:(int)alpha
{
    CGFloat r = (CGFloat) red/255.0;
    CGFloat g = (CGFloat) green/255.0;
    CGFloat b = (CGFloat) blue/255.0;
    CGFloat a = (CGFloat) alpha/255.0;
    CGFloat components[4] = {r,g,b,a};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGColorRef color = (CGColorRef)[(id)CGColorCreate(colorSpace, components) autorelease];
    CGColorSpaceRelease(colorSpace);
    
    return color;
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

/**
*  剪切图片为正方形
*
*  @param image   原始图片比如size大小为(400x200)pixels
*  @param newSize 正方形的size比如400pixels
*
*  @return 返回正方形图片(400x400)pixels
*/
+ (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize
{
    CGAffineTransform scaleTransform;
    CGPoint origin;
    
    if (image.size.width > image.size.height) {
        //image原始高度为200，缩放image的高度为400pixels，所以缩放比率为2
        CGFloat scaleRatio = newSize / image.size.height;
        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
        //设置绘制原始图片的画笔坐标为CGPoint(-100, 0)pixels
        origin = CGPointMake(-(image.size.width - image.size.height) / 2.0f, 0);
    } else {
        CGFloat scaleRatio = newSize / image.size.width;
        scaleTransform = CGAffineTransformMakeScale(scaleRatio, scaleRatio);
        
        origin = CGPointMake(0, -(image.size.height - image.size.width) / 2.0f);
    }
    
    CGSize size = CGSizeMake(newSize, newSize);
    //创建画板为(400x400)pixels
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    } else {
        UIGraphicsBeginImageContext(size);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //将image原始图片(400x200)pixels缩放为(800x400)pixels
    CGContextConcatCTM(context, scaleTransform);
    //origin也会从原始(-100, 0)缩放到(-200, 0)
    [image drawAtPoint:origin];
    
    //获取缩放后剪切的image图片
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}
@end

