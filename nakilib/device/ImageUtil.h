//
//  URLImageUtil.h
//  Community
//
//  Created by BST on 13-6-5.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageUtil : NSObject {
    
}

+(UIImage *) loadImageFromURL:(NSString *)fileURL;

+(BOOL) saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath;

+(UIImage *) loadImage:(NSString *)fileName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath;

+(NSString*) loadImagePathFromURL:(NSString*)url;

+(void) downloadImageToClientFromURL:(NSString*)url;

+(UIImage*) loadImageFromClientByURL:(NSString*)url;

+(NSData*) getRawImageDataFromImage:(UIImage*)image ofType:(NSString*)type;

+ (void)setShadow:(UIView*)view allSide:(BOOL)allSide withBoard:(BOOL)with;

+(CGColorRef) getColorFromRed:(int)red Green:(int)green Blue:(int)blue Alpha:(int)alpha;

+ (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize;

+ (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize;

+ (UIImage*) convertImageToGreyScale:(UIImage*) image;
@end
