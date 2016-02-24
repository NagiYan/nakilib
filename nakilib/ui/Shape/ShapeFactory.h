//
//  ShapeFactory.h
//  Nagi
//
//  Created by Nagi on 15/3/23.
//  Copyright (c) 2015年 Nagi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/CAShapeLayer.h>
#import <QuartzCore/CAAnimation.h>
#import <QuartzCore/CAMediaTimingFunction.h>

@interface ShapeFactory : NSObject

+ (void)decorateShapeToCircle:(CAShapeLayer*)circle radius:(CGFloat)radius width:(NSInteger)width withcolor:(UIColor*)color;

// 唯一可指定边角的方式 会与自动布局冲突 性能最低
+ (void)decorateShapeWithCorner:(UIRectCorner)position withRadius:(NSInteger)radius forView:(UIView*)view;

// 性能一般
+ (void)decorateLayerAllCornerWithRadius:(NSInteger)radius forView:(UIView*)view;;

// 性能高， 但是背景必须单色 默认白色
+ (void)decorateImageAllCornerForView:(UIView*)view;

// 性能高， 但是背景必须单色
+ (void)decorateImageAllCornerForView:(UIView*)view withColor:(UIColor*)color;

// 圆角矩形
+ (void)decorateImageAllCornerRectForView:(UIView *)view;

// 圆角矩形
+ (void)decorateImageAllCornerRectForView:(UIView *)view withColor:(UIColor*)color;

// 绘制虚线 水平
+ (void)warpToDashLineH:(UIView*)view lineColor:(UIColor*)color;
@end
