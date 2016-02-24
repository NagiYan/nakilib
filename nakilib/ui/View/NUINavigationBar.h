//
//  NUINavigationBar.h
//  west dean delicious
//
//  Created by westonnaki on 15/5/15.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NUINavigationBar : UINavigationBar

// 以默认尺寸和颜色创建
- (id)initWithDefaultFrameAndColor;
// 指定尺寸和颜色
- (id)initWithFrame:(CGRect)frame withColor:(UIColor*)color;
// 标题栏
@property (retain, nonatomic) UILabel* labelTitle;
// 左侧按钮
@property (retain, nonatomic) UIBarButtonItem* buttonLeft;
// 右侧按钮
@property (retain, nonatomic) UIBarButtonItem* buttonRight;
// 右侧按钮2
@property (retain, nonatomic) UIBarButtonItem* buttonRight2nd;

@end
