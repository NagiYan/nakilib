//
//  ImageDownloadManager.h
//  HealthManagement
//
//  Created by Gareamac on 14-6-19.
//  Copyright (c) 2014年 Gareatech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageDownloadManager : NSObject
+ (UIImage *)getImageFromURL:(NSString *)fileURL;
+ (void)saveImage:(UIImage *)image withFileName:(NSString *)imageName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath;
+ (UIImage *)loadImage:(NSString *)fileName ofType:(NSString *)extension inDirectory:(NSString *)directoryPath;
+ (UIImage *)thumbnailWithImage:(UIImage *)image size:(CGSize)asize;
+ (BOOL)imgExist:(NSString*)fileName inDirectory:(NSString *)directoryPath;
+ (void)downLoadSaveImageWithThumb:(NSString*)imgPath name:(NSNumber*)pid dir:(NSString*)documentsDirectoryPath;
+ (UIImage*)getImageById:(NSInteger)pid _mode:(int)mode subDir:(NSString*)subDir;
@end
