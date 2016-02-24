//
//  ColorUtil.h
//  west dean delicious
//
//  Created by westonnaki on 15/6/4.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ColorUtil : NSObject
// 设置已有的某种颜色的透明色
+ (UIColor*)makeColorAlpha:(UIColor*)color alpha:(float)alpha;

@end
