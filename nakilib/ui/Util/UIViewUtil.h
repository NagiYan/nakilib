//
//  UIViewUtil.h
//  Nagi
//
//  Created by Nagi on 15/4/7.
//  Copyright (c) 2015年 Nagi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIViewUtil : NSObject

// 释放某个视图的全部子视图
+ (void)freeSubViews:(UIView*)view;

// 释放某个视图的子视图，除了特定类型的视图
+ (void)freeSubViews:(UIView *)view beside:(Class)classType;

// 释放指定子视图
+ (void)freeSubViews:(UIView *)view byTag:(NSInteger)tag;

// 释放指定子视图
+ (void)freeSubViews:(UIView *)view byTag:(NSInteger)tag class:(Class)class;

// 使用tag查找第一个满足条件的子视图
+ (__kindof UIView *)getSubViewByTag:(NSInteger)tag in:(UIView*)view;
+ (__kindof UIView *)getSubViewByTag:(NSInteger)tag in:(UIView*)view recurison:(BOOL)recurison;

// 使用tag查找第一个满足条件的子视图
+ (__kindof UIView *)getSubViewByTag:(NSInteger)tag in:(UIView*)view andClass:(Class)classtype;

// 获取搜索视图的输入框对象 已经显示后调用才有效
+ (UITextField*)GetTextViewOfSearchBar:(UISearchBar*)searchBar;

// 获取搜索框的背景视图
+ (__kindof UIView *)getBackgroundViewOfSearchBar:(UISearchBar*)searchBar;

// 获取屏幕截图
+ (UIView*)GetScreenView:(UIView *)theView;

// 透明度渐变
+ (void)insertTransparentGradientForView:(UIView*)view;

// 颜色渐变
+ (void)insertColorGradientForView:(UIView*)view withStartColor:(UIColor*)colorOne andEndColor:(UIColor*)colorTwo;

// 选图片
+ (void)selectPicture:(UIImagePickerControllerSourceType)source parentViewController:(UIViewController*)parent andDelegate:(id <UINavigationControllerDelegate, UIImagePickerControllerDelegate>)delegate;

// 获取视图的VC
+ (UIViewController *)findViewController:(UIView *)sourceView;
@end
