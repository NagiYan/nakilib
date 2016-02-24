//
//  ColorUtil.m
//  west dean delicious
//
//  Created by westonnaki on 15/6/4.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//

#import "ColorUtil.h"

@implementation ColorUtil
// 设置已有的某种颜色的透明色
+ (UIColor*)makeColorAlpha:(UIColor*)color alpha:(float)alpha
{
    CGColorRef colorRef = color.CGColor;
    NSInteger numberComponents = CGColorGetNumberOfComponents(colorRef);
    const CGFloat *components = CGColorGetComponents(colorRef);
    if (numberComponents == 2)
    {
        UIColor* newColor = [UIColor colorWithWhite:components[0] alpha:alpha];
        return newColor;
    }
    else if (numberComponents == 4)
    {
        UIColor* newColor = [UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:alpha];
        return newColor;
    }
    return color;
}
@end
