//
//  StringUtil.m
//  west dean delicious
//
//  Created by westonnaki on 15/5/22.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//

#import "StringUtil.h"

@implementation StringUtil

#pragma mark - 字符串校验

#define MOBILE @"^1[3578]\\d{9}$"
#define MIDDLE_NUMBER_ALPHA @"^(?=.*[0-9].*)(?=.*[a-zA-Z].*).{6,20}$"
#define MIDDLE_NUMBER_SYMBOL @"^(?=.*[0-9].*)(?=.*[-_.=;:!@#$%^&*()+/?><].*).{6,20}$"
#define MIDDLE_ALPHA_SYMBOL @"^(?=.*[a-zA-Z].*)(?=.*[-_.;:=!@#$%^&*()+/?><].*).{6,20}$"
// 校验字符串是否是中国手机号
+ (BOOL)regexChinaPhoneNumber:(NSString*)data 
{
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if ([regextestmobile evaluateWithObject:data] == YES)
    {
        return YES;
    }
    return NO;
}

+ (BOOL)regexContainerNumberAndAlpha:(NSString*)data
{
    NSPredicate *regextestnumberalpha = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MIDDLE_NUMBER_ALPHA];
    if ([regextestnumberalpha evaluateWithObject:data] == YES)
    {
        return YES;
    }
    NSPredicate *regextestnumbersymbol = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MIDDLE_NUMBER_SYMBOL];
    if ([regextestnumbersymbol evaluateWithObject:data] == YES)
    {
        return YES;
    }
    NSPredicate *regextestalphasymbol = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MIDDLE_ALPHA_SYMBOL];
    if ([regextestalphasymbol evaluateWithObject:data] == YES)
    {
        return YES;
    }
    return NO;
}

// 是否是url
+ (BOOL)regexUrl:(NSString*)data
{
    NSRange range = [data rangeOfString:@"http"];
    if (range.length != 0)
    {
        return YES;
    }
    return NO;
}
@end
