//
//  GScreen.m
//  Nagi
//
//  Created by Nagi on 15-2-28.
//  Copyright (c) 2015年 Nagi. All rights reserved.
//

#import "GScreen.h"


@implementation GScreen
IMPLEMENT_SINGLETON(GScreen);

- (CGSize)GetDeviceFrame
{
    return [UIScreen mainScreen].applicationFrame.size;
}

@end

