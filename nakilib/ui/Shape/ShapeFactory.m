//
//  ShapeFactory.m
//  Nagi
//
//  Created by Nagi on 15/3/23.
//  Copyright (c) 2015年 Nagi. All rights reserved.
//

#import "ShapeFactory.h"
#import "Masonry.h"

@implementation ShapeFactory

// 创建个圆形图层
+ (void)decorateShapeToCircle:(CAShapeLayer*)circle radius:(CGFloat)radius width:(NSInteger)width withcolor:(UIColor*)color
{
    //circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius) cornerRadius:radius].CGPath;
    
    circle.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius)
                                                 radius:radius - width/2
                                             startAngle:3.14*0.5
                                               endAngle:6.28+ 3.14*0.5
                                              clockwise:YES].CGPath;
    // Configure the apperence of the circle
    circle.fillColor = color.CGColor;
    circle.lineWidth = width;
    circle.lineCap = kCALineCapRound;
    circle.position = CGPointZero;
    circle.contentsScale = [[UIScreen mainScreen] scale];

}

+ (void)decorateShapeWithCorner:(UIRectCorner)position withRadius:(NSInteger)radius forView:(UIView*)view
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:position cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

+ (void)decorateLayerAllCornerWithRadius:(NSInteger)radius forView:(UIView*)view
{
    view.layer.cornerRadius = radius;
    view.layer.masksToBounds = YES;
}

+ (void)decorateImageAllCornerForView:(UIView*)view
{
    [ShapeFactory decorateImageAllCornerForView:view withColor:[UIColor whiteColor]];
    
}

+ (void)decorateImageAllCornerForView:(UIView*)view withColor:(UIColor*)color
{
    UIImage* image = [[UIImage imageNamed:@"shiled"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView* shiled = [UIImageView new];
    [shiled setImage:image];
    [shiled setTintColor:color];
    [view addSubview:shiled];
    [shiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
}

// 圆角矩形
+ (void)decorateImageAllCornerRectForView:(UIView *)view
{
    [ShapeFactory decorateImageAllCornerRectForView:view withColor:[UIColor whiteColor]];
}

// 圆角矩形
+ (void)decorateImageAllCornerRectForView:(UIView *)view withColor:(UIColor*)color
{
    UIImage* image = [[UIImage imageNamed:@"rect_shiled"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView* shiled = [UIImageView new];
    [shiled setImage:image];
    [shiled setTintColor:color];
    [view addSubview:shiled];
    [shiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
}

// 绘制虚线 水平
+ (void)warpToDashLineH:(UIView*)view lineColor:(UIColor*)color
{
    NSInteger length = view.frame.size.width;
    NSInteger width = view.frame.size.height;
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:view.bounds];
    [shapeLayer setPosition:view.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    shapeLayer.fillRule = kCAFillRuleEvenOdd;
    // 设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:[color CGColor]];
    
    // 3.0f设置虚线的宽度
    [shapeLayer setLineWidth:width];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    // 3=线的宽度 1=每条线的间距
    [shapeLayer setLineDashPattern:@[@(0.1), @(2*width)]];
    [shapeLayer setLineDashPhase:0.5];
    [shapeLayer setLineCap:kCALineCapRound];
    
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, width/2);
    CGPathAddLineToPoint(path, NULL, length,width/2);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    [[view layer] addSublayer:shapeLayer];
}
@end
