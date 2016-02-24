//
//  GSizeUtil.h
//  Nagi
//
//  Created by Nagi on 15/3/26.
//  Copyright (c) 2015年 Nagi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GSizeUtil : NSObject
// 获取某字符串的显示宽度
+ (NSInteger)getWidthForString:(NSString*)string withFont:(UIFont*)font maxWidth:(NSInteger)width;

// 获取某字符串的显示高度
+ (NSInteger)getHeightForString:(NSString*)string withFont:(UIFont*)font maxWidth:(NSInteger)width;

// 获取某字符串的显示尺寸
+ (CGSize)getSizeForString:(NSString*)string withFont:(UIFont*)font maxWidth:(NSInteger)width;

// 获取某字符串的显示宽度
+ (NSInteger)getWidthForString:(NSString*)string withSysFontSize:(NSInteger)fontSize maxWidth:(NSInteger)width;

// 获取某字符串的显示高度
+ (NSInteger)getHeightForString:(NSString*)string withSysFontSize:(NSInteger)fontSize maxWidth:(NSInteger)width;

// 获取某字符串的显示尺寸
+ (CGSize)getSizeForString:(NSString*)string withSysFontSize:(NSInteger)fontSize maxWidth:(NSInteger)width;

// AttributedString

// 获取某字符串的显示宽度
+ (NSInteger)getWidthForString:(NSAttributedString*)string maxWidth:(NSInteger)width;

// 获取某字符串的显示高度
+ (NSInteger)getHeightForString:(NSAttributedString*)string maxWidth:(NSInteger)width;

// 获取某字符串的显示尺寸
+ (CGSize)getSizeForString:(NSAttributedString*)string maxWidth:(NSInteger)width;

@end
