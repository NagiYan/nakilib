//
//  GScreen.h
//  Nagi
//
//  Created by Nagi on 15-2-28.
//  Copyright (c) 2015年 Nagi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include "SingletonARC.h"

@interface GScreen : NSObject
DEFINE_SINGLETON_ARC(GScreen);

- (CGSize)GetDeviceFrame;
@end

#define GScreenWidth ([[GScreen sharedInstance] GetDeviceFrame].width)
#define GScreenHeight ([[GScreen sharedInstance] GetDeviceFrame].height + 20)
