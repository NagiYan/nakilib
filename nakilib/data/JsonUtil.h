//
//  JsonUtil.h
//  west dean delicious
//
//  Created by westonnaki on 15/5/29.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HXAddtions)

+(NSString *) jsonStringWithString:(NSString *) string;

+(NSString*) Data2jsonString:(id)object;

+(NSString*)Container2JsonString:(id)container withFormat:(BOOL)format;
@end
