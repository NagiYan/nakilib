//
//  ContainerUtil.m
//  west dean delicious
//
//  Created by westonnaki on 15/5/20.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//

#import "ContainerUtil.h"

@implementation ContainerUtil

+ (id)dictionary:(NSDictionary*)data objectForKey:(NSString*)key
{
    if ([[data objectForKey:key] isEqual:[NSNull null]])
    {
        return nil;
    }
    return [data objectForKey:key];
}

+ (NSString*)readStringFromDictionary:(NSDictionary*)data objectForKey:(NSString*)key
{
    id value = [ContainerUtil dictionary:data objectForKey:key];
    if (value) {
        return value;
    }
    else
        return @"";
}

+(NSDictionary *)nullDic:(NSDictionary *)myDic
{
    __block NSMutableDictionary *resDic = [NSMutableDictionary new];
    [myDic enumerateKeysAndObjectsUsingBlock:^(NSString*  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [resDic setObject:[ContainerUtil changeType:obj] forKey:key];
    }];
    
    return resDic;
}

//将NSDictionary中的Null类型的项目转化成@""
+(NSArray *)nullArr:(NSArray *)myArr
{
    __block NSMutableArray *resArr = [NSMutableArray new];
    [myArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [resArr addObject:[ContainerUtil changeType:obj]];
    }];
    return resArr;
}

//将NSString类型的原路返回
+(NSString *)stringToString:(NSString *)string
{
    return string;
}

//将Null类型的项目转化成@""
+(NSString *)nullToString
{
    return @"";
}

//类型识别:将所有的NSNull类型转化成@""
+(id)changeType:(id)myObj
{
    if ([myObj isKindOfClass:[NSDictionary class]])
    {
        return [self nullDic:myObj];
    }
    else if([myObj isKindOfClass:[NSArray class]])
    {
        return [self nullArr:myObj];
    }
    else if([myObj isKindOfClass:[NSString class]])
    {
        return [self stringToString:myObj];
    }
    else if([myObj isKindOfClass:[NSNull class]])
    {
        return [self nullToString];
    }
    else
    {
        return myObj;
    }
}
@end
