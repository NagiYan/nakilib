//
//  GSizeUtil.m
//  Nagi
//
//  Created by Nagi on 15/3/26.
//  Copyright (c) 2015年 Nagi. All rights reserved.
//

#import "GSizeUtil.h"

@implementation GSizeUtil
// 获取某字符串的显示宽度
+ (NSInteger)getWidthForString:(NSString*)string withSysFontSize:(NSInteger)fontSize maxWidth:(NSInteger)width
{
    return ceilf([GSizeUtil getSizeForString:string withSysFontSize:fontSize maxWidth:width].width);
}

// 获取某字符串的显示高度
+ (NSInteger)getHeightForString:(NSString*)string withSysFontSize:(NSInteger)fontSize maxWidth:(NSInteger)width
{
    return ceilf([GSizeUtil getSizeForString:string withSysFontSize:fontSize maxWidth:width].height);
}

// 获取某字符串的显示尺寸
+ (CGSize)getSizeForString:(NSString*)string withSysFontSize:(NSInteger)fontSize maxWidth:(NSInteger)width
{
    UIFont* font = [UIFont fontWithName:@"Helvetica" size:fontSize];
    return [GSizeUtil getSizeForString:string withFont:font maxWidth:width];
}

// 获取某字符串的显示宽度
+ (NSInteger)getWidthForString:(NSString*)string withFont:(UIFont*)font maxWidth:(NSInteger)width
{
    return ceilf([GSizeUtil getSizeForString:string withFont:font maxWidth:width].width);
}

// 获取某字符串的显示高度
+ (NSInteger)getHeightForString:(NSString*)string withFont:(UIFont*)font maxWidth:(NSInteger)width
{
    return ceilf([GSizeUtil getSizeForString:string withFont:font maxWidth:width].height);
}

// 获取某字符串的显示尺寸
+ (CGSize)getSizeForString:(NSString*)string withFont:(UIFont*)font maxWidth:(NSInteger)width
{
    if (width == 0)
    {
        width = 320;
    }
    //return [string sizeWithFont:font forWidth:width lineBreakMode:NSLineBreakByCharWrapping];
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, INT_MAX)
                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                    attributes:@{NSFontAttributeName:font}
                                       context:nil];
    
    return rect.size;
}

// 获取某字符串的显示宽度
+ (NSInteger)getWidthForString:(NSAttributedString*)string maxWidth:(NSInteger)width
{
    return ceilf([GSizeUtil getSizeForString:string maxWidth:width].width);
}

// 获取某字符串的显示高度
+ (NSInteger)getHeightForString:(NSAttributedString*)string maxWidth:(NSInteger)width
{
    return ceilf([GSizeUtil getSizeForString:string maxWidth:width].height);
}

// 获取某字符串的显示尺寸
+ (CGSize)getSizeForString:(NSAttributedString*)string maxWidth:(NSInteger)width
{
    if (width == 0)
    {
        width = 320;
    }
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, INT_MAX)
                                       options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                       context:nil];
    
    return rect.size;
}
@end
