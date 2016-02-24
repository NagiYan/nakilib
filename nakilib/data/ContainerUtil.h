//
//  ContainerUtil.h
//  west dean delicious
//
//  Created by westonnaki on 15/5/20.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContainerUtil : NSObject

+ (id)dictionary:(NSDictionary*)data objectForKey:(NSString*)key;

+ (NSString*)readStringFromDictionary:(NSDictionary*)data objectForKey:(NSString*)key;

+(NSDictionary *)nullDic:(NSDictionary *)myDic;

+(NSArray *)nullArr:(NSArray *)myArr;
@end
