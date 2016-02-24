//
//  SimpleAnimation.m
//  west dean delicious
//
//  Created by westonnaki on 15/8/6.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//

#import "SimpleAnimation.h"

@implementation SimpleAnimation

// 添加放大缩小动画
+ (void)addScaleUpDownAnimation:(UIView*)view
{
    CAKeyframeAnimation *keyUpAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    keyUpAnimation.values = @[@(0.1),@(1.0),@(1.5)];
    keyUpAnimation.keyTimes = @[@(0.0),@(0.5),@(0.8),@(1.0)];
    keyUpAnimation.calculationMode = kCAAnimationLinear;
    [view.layer addAnimation:keyUpAnimation forKey:@"show"];
}

@end
