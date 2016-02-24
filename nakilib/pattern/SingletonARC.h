//
//  SignletonARC.h
//  west dean delicious
//
//  Created by westonnaki on 15/12/16.
//  Copyright © 2015年 westonnaki. All rights reserved.
//

#ifndef SignletonARC_h
#define SignletonARC_h

// 声明单例接口
#define DEFINE_SINGLETON_ARC(_className)    \
+ (_className*)sharedInstance;

#define IMPLEMENT_SINGLETON_ARC(_className) \
+ (_className*)sharedInstance{\
static _className* sharedSingleton = nil;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^(void){\
sharedSingleton = [[_className alloc] init];\
});\
return sharedSingleton;\
}\

#endif /* SignletonARC_h */
