//
//  HttpUtil.m
//  Nagi
//
//  Created by Nagi on 15-2-26.
//  Copyright (c) 2015年 Nagi. All rights reserved.
//

#import "HttpUtil.h"
#import "AFNetworking.h"
#import "UIProgressView+AFNetworking.h"

@implementation HttpUtil

IMPLEMENT_SINGLETON_ARC(HttpUtil);

- (NSData*) HttpPost:(NSString*)postString ServerUrl:(NSString*)url
{
    NSData      *postData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString    *postLength = [NSString stringWithFormat:@"%d", (int)[postData length]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0f];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    [request setHTTPBody:postData];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setTimeoutInterval:5.0f];
    
    [request setHTTPShouldHandleCookies:YES];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    [cookieStorage setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    
    NSError             *error;
    NSHTTPURLResponse   *response;
    NSData              *urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    return urlData;
}

- (NSData*) HttpGet:(NSString*)getString ServerUrl:(NSString*)url
{
    url = [NSString stringWithFormat:@"%@&%@", url, getString];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //第一步，创建URL
    //第二步，通过URL创建网络请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]
                                                                cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                            timeoutInterval:10];
    //NSURLRequest初始化方法第一个参数：请求访问路径，第二个参数：缓存协议，第三个参数：网络请求超时时间（秒）
//    其中缓存协议是个枚举类型包含：
//    NSURLRequestUseProtocolCachePolicy（基础策略）
//    NSURLRequestReloadIgnoringLocalCacheData（忽略本地缓存）
//    NSURLRequestReturnCacheDataElseLoad（首先使用缓存，如果没有本地缓存，才从原地址下载）
//    NSURLRequestReturnCacheDataDontLoad（使用本地缓存，从不下载，如果本地没有缓存，则请求失败，此策略多用于离线操作）
//    NSURLRequestReloadIgnoringLocalAndRemoteCacheData（无视任何缓存策略，无论是本地的还是远程的，总是从原地址重新下载）
//    NSURLRequestReloadRevalidatingCacheData（如果本地缓存是有效的则不下载，其他任何情况都从原地址重新下载）
    //第三步，连接服务器
    //[request setValue:@"IOS" forHTTPHeaderField:@"User-Agent"];
    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    return received;
}

-(void) HTTPFormPostAFH:(NSArray*)byteDatas withParams:(NSDictionary*)params ServerUrl:(NSString*)url
                  progress:(UIProgressView*)progress double:(NSInteger)timeout complate:(void(^)(id))callback
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = timeout;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:url
                                     parameters:params
                      constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                          [byteDatas enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
                              [formData appendPartWithFileData:[item objectForKey:@"data"]
                                                          name:[item objectForKey:@"key"]
                                                      fileName:[item objectForKey:@"fileName"]
                                                      mimeType:[item objectForKey:@"type"]];}];}
                                       progress:^(NSProgress * _Nonnull uploadProgress) {
                                           if (progress) {
                                               // 回到主队列刷新UI
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                   float percent = 1.0 * uploadProgress.completedUnitCount/uploadProgress.totalUnitCount;
                                                   [progress setProgress:percent];
                                               });
                                           }
                                       }
                                        success:^(NSURLSessionDataTask * _Nonnull _task, id  _Nonnull responseObject) {
        callback(responseObject);
    } failure:^(NSURLSessionDataTask * _Nonnull _task, NSError * _Nonnull error) {
        callback(nil);
    }];
}
@end
