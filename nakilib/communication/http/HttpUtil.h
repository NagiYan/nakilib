//
//  HttpUtil.h
//  Nagi
//
//  Created by Nagi on 15-2-26.
//  Copyright (c) 2015年 Nagi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingletonMRC.h"

@interface HttpUtil : NSObject

DEFINE_SINGLETON(HttpUtil);

// 同步HTTP POST请求
- (NSData*) HttpPost:(NSString*)postString ServerUrl:(NSString*)url;

// 同步HTTP GET请求
- (NSData*) HttpGet:(NSString*)getString ServerUrl:(NSString*)url;

// 使用AFHTTP框架进行表单数据请求
-(void) HTTPFormPostAFH:(NSArray*)byteDatas withParams:(NSDictionary*)params ServerUrl:(NSString*)url
                  progress:(UIProgressView*)progress double:(NSInteger)timeout complate:(void(^)(id))callback;
@end
