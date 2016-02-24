//
//  StringUtil.h
//  west dean delicious
//
//  Created by westonnaki on 15/5/22.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtil : NSObject

// 校验字符串是否是中国手机号
+ (BOOL)regexChinaPhoneNumber:(NSString*)data;

// 校验字符串是否包同时含数字和字母
+ (BOOL)regexContainerNumberAndAlpha:(NSString*)data;

// 是否是url
+ (BOOL)regexUrl:(NSString*)data;
@end
