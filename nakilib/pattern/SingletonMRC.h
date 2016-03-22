//
//  SingletonMRC.h
//  HealthManagement
//
//  Created by Nagi on 14-8-12.
//  Copyright (c) 2014年 Nagi. All rights reserved.
//

#ifndef HealthManagement_SingletonMRC_h
#define HealthManagement_SingletonMRC_h

// 声明单例接口
#define DEFINE_SINGLETON(_className)    \
+ (_className*)sharedInstance

// 实现单例接口
#if !__has_feature(objc_arc)
#define IMPLEMENT_SINGLETON(_className)     \
static _className* _sharedInstance = nil;   \
+ (_className*)sharedInstance{                      \
if (!_sharedInstance){                          \
_sharedInstance = [[_className alloc] init];\
}                                               \
return _sharedInstance;                         \
}                                                   \
- (void)releaseShared{                              \
if (_sharedInstance){                           \
[super release];                            \
_sharedInstance = nil;                      \
}                                               \
}                                                   \
+ (id)allocWithZone:(NSZone *)zone{                 \
@synchronized(self){                            \
if (_sharedInstance == nil){                \
_sharedInstance = [super allocWithZone:zone];\
return _sharedInstance;                 \
}                                           \
else                                        \
    return _sharedInstance;                         \
}                                               \
return nil;                                     \
}                                                   \
- (id)copyWithZone:(NSZone *)zone{                  \
return self;                                    \
}                                                   \
- (id)retain{                                       \
return self;                                    \
}                                                   \
- (NSUInteger)retainCount{                            \
return 1;                                       \
}                                                   \
- (oneway void)release{                             \
}                                                   \
- (id)autorelease{                                  \
return self;                                    \
}                                                   \
-(void)dealloc{                                     \
[super dealloc];                                \
}
#endif
#endif
