//
//  JsonUtil.m
//  west dean delicious
//
//  Created by westonnaki on 15/5/29.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//

#import "JsonUtil.h"

@implementation NSString (HXAddtions)

+(NSString *) jsonStringWithString:(NSString *) string
{
    return [NSString stringWithFormat:@"\"%@\"",
            [[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""]
            ];
}

+(NSString*)Data2jsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:0 // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData)
    {
        NSLog(@"Got an error: %@", error);
    }
    else
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

+ (NSString*)Container2JsonString:(id)container withFormat:(BOOL)format
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:container options:NSJSONWritingPrettyPrinted error:nil];
    NSString* itemsJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    if (!format)
    {
        itemsJson = [itemsJson stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        itemsJson = [itemsJson stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        itemsJson = [itemsJson stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    return itemsJson;
}


@end
