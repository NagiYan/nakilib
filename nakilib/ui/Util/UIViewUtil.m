//
//  UIViewUtil.m
//  Nagi
//
//  Created by Nagi on 15/4/7.
//  Copyright (c) 2015年 Nagi. All rights reserved.
//

#import "UIViewUtil.h"
#import "GScreen.h"

@implementation UIViewUtil

+ (void)freeSubViews:(UIView*)view
{
    //NSArray* views = [view subviews];
    
    while ([view subviews] && [[view subviews] count] > 0)
    {
        [[[view subviews] objectAtIndex:0] removeFromSuperview];
    }
    
    /*
    for (UIView* subview in views)
    {
        [subview removeFromSuperview];
    }
    */
}

// 释放某个视图的子视图，除了特定类型的视图
+ (void)freeSubViews:(UIView *)view beside:(Class)classType
{
    NSArray* subviews = [view subviews];
    for (UIView* sub in subviews)
    {
        if (![[sub class] isSubclassOfClass:classType])
        {
            [sub removeFromSuperview];
        }
    }
}

// 释放指定子视图
+ (void)freeSubViews:(UIView *)view byTag:(NSInteger)tag
{
    UIView* viewSub = [UIViewUtil getSubViewByTag:tag in:view];
                   
    while (viewSub)
    {
        [viewSub removeFromSuperview];
        viewSub = [UIViewUtil getSubViewByTag:tag in:view];
    }
}

// 释放指定子视图
+ (void)freeSubViews:(UIView *)view byTag:(NSInteger)tag class:(Class)class
{
    UIView* viewSub = [UIViewUtil getSubViewByTag:tag in:view andClass:class];
    
    while (viewSub)
    {
        [viewSub removeFromSuperview];
        viewSub = [UIViewUtil getSubViewByTag:tag in:view andClass:class];
    }
}

+ (__kindof UIView *)getSubViewByTag:(NSInteger)tag in:(UIView*)view recurison:(BOOL)recurison
{
    NSArray* views = [view subviews];
    for (UIView* subview in views)
    {
        if ([subview tag] == tag)
        {
            return subview;
        }
        else if (recurison)
        {
            UIView* find = [UIViewUtil getSubViewByTag:tag in:subview];
            if (find) {
                return find;
            }
        }
    }
    return nil;
}

// 使用tag查找第一个满足条件的子视图
+ (__kindof UIView *)getSubViewByTag:(NSInteger)tag in:(UIView*)view
{
    return [UIViewUtil getSubViewByTag:tag in:view recurison:NO];
}

// 使用tag查找第一个满足条件的子视图
+ (__kindof UIView *)getSubViewByTag:(NSInteger)tag in:(UIView*)view andClass:(Class)classtype
{
    NSArray* views = [view subviews];
    for (UIView* subview in views)
    {
        if ([subview tag] == tag && [subview isKindOfClass:classtype])
        {
            return subview;
        }
        else
        {
            UIView* find = [UIViewUtil getSubViewByTag:tag in:subview andClass:classtype];
            if (find) {
                return find;
            }
        }
    }
    
    return nil;
}

// 获取搜索视图的输入框对象
+ (UITextField*)GetTextViewOfSearchBar:(UISearchBar*)searchBar
{
    __block UITextField* find = nil;
    NSInteger numViews = [searchBar.subviews count];
    if (numViews == 1)
    {
        NSArray* subViews = [searchBar.subviews[0] subviews];
        [subViews enumerateObjectsUsingBlock:^(UIView*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if([obj isKindOfClass:[UITextField class]])
            {
                find = (UITextField*)obj;
                *stop = YES;
            }
        }];
    }
    else
    {
        NSArray* subViews = [searchBar subviews];
        for (UIView* view in subViews)
        {
            if([view isKindOfClass:[UITextField class]])
            {
                return (UITextField*)view;
            }
        }
    }
    
    return find;
}

// 获取搜索框的背景视图
+ (__kindof UIView *)getBackgroundViewOfSearchBar:(UISearchBar*)searchBar
{
    NSInteger numViews = [searchBar.subviews count];
    if (numViews == 1)
    {
        NSArray* subViews = [[searchBar.subviews objectAtIndex:0] subviews];
        for (UIView* view in subViews)
        {
            if(![view isKindOfClass:[UITextField class]])
            {
                return view;
            }
        }
    }
    else
    {
        NSArray* subViews = [searchBar subviews];
        for (UIView* view in subViews)
        {
            if(![view isKindOfClass:[UITextField class]])
            {
                return view;
            }
        }
    }
    
    return nil;
}

//获得某个范围内的屏幕图像
+ (UIImage *)imageFromView:(UIView *)theView
{
    CGRect rect = CGRectMake(0, 0, GScreenWidth, GScreenWidth);
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(rect);
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return  theImage;//[self getImageAreaFromImage:theImage atFrame:r];
}

+ (UIView*)GetScreenView:(UIView *)theView
{
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(GScreenWidth, GScreenHeight), YES, 0);     //设置截屏大小
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView* view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, GScreenWidth, GScreenHeight)];
    [view setImage:img];
    return view;
}

// 透明度渐变
+ (void)insertTransparentGradientForView:(UIView*)view
{
    UIColor *colorOne = [UIColor colorWithRed:(33/255.0)  green:(33/255.0)  blue:(33/255.0)  alpha:0.0];
    UIColor *colorTwo = [UIColor colorWithRed:(1/255.0)  green:(1/255.0)  blue:(1/255.0)  alpha:1.0];
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    
    //crate gradient layer
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    headerLayer.frame = view.bounds;
    
    [view.layer insertSublayer:headerLayer atIndex:0];
}


// 颜色渐变
+ (void)insertColorGradientForView:(UIView*)view withStartColor:(UIColor*)colorOne andEndColor:(UIColor*)colorTwo
{
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    headerLayer.frame = view.bounds;
    
    [view.layer insertSublayer:headerLayer above:0];
}

// 选图片
+ (void) selectPicture:(UIImagePickerControllerSourceType)source parentViewController:(UIViewController*)parent andDelegate:(id <UINavigationControllerDelegate, UIImagePickerControllerDelegate>)delegate
{
    //创建图片选择器
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    //指定源类型前，检查图片源是否可用
    if ([UIImagePickerController isSourceTypeAvailable:source])
    {
        //指定源的类型
        imagePicker.sourceType = source;
        
        //在选定图片之前，用户可以简单编辑要选的图片。包括上下移动改变图片的选取范围，用手捏合动作改变图片的大小等。
        imagePicker.allowsEditing = YES;
        
        //实现委托，委托必须实现UIImagePickerControllerDelegate协议，来对用户在图片选取器中的动作
        imagePicker.delegate = delegate;
        
        //设置完iamgePicker后，就可以启动了。用以下方法将图像选取器的视图“推”出来
        //[self presentModalViewController:imagePicker animated:YES];
        [parent presentViewController:imagePicker animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:nil message:@"相机不能用" delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
        [alert show];
    }
}

+ (UIViewController *)findViewController:(UIView *)sourceView
{
    id target = sourceView;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}
@end
