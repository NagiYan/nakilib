//
//  TopBar.h
//  Nagi
//  通用的顶部导航栏
//  Created by Nagi on 15-2-11.
//  Copyright (c) 2015年 Nagi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopBar : UIView
{
    UILabel*    _labelTitle;
    UIButton*   _btnLeft;
    UIButton*   _btnRight;
}

// 以默认尺寸创建
- (id)initWithDefaultFrameAndColor:(UIColor*)color;
// 指定尺寸和颜色
- (id)initWithFrame:(CGRect)frame withColor:(UIColor*)color;

// 将按钮变成带灰底的圆形按钮
- (void)shapeButton;

// 设置半透明
- (void)makeAlpha:(float)alpha;

// 设置右侧按钮可见性
- (void)setRightButtonVisible:(BOOL)visible;

// 标题栏
@property (retain, nonatomic) UILabel* labelTitle;
// 左侧按钮
@property (retain, nonatomic) UIButton* buttonLeft;
// 右侧按钮
@property (retain, nonatomic) UIButton* buttonRight;
// 右侧按钮2
@property (retain, nonatomic) UIButton* buttonRight2nd;
@end

#define ACTIVE_HIDE_NAVIBAR \
- (void)viewWillAppear:(BOOL)animated{[[[self navigationController] navigationBar] setAlpha:0];\
    [super viewWillAppear:animated];\
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForegroundNotification) name: UIApplicationWillEnterForegroundNotification object:nil];}\
- (void)appWillEnterForegroundNotification{[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(hideNav) userInfo:nil repeats:NO];}\
- (void)hideNav{ [[[self navigationController] navigationBar] setAlpha:0];}\
- (void)viewDidDisappear:(BOOL)animated{[[NSNotificationCenter defaultCenter] removeObserver:self];\
    [super viewDidDisappear:animated];}
//- (void)viewWillDisappear:(BOOL)animated{[[[self navigationController] navigationBar] setHidden:NO];}

#define ACTIVE_HIDE_NAVIBAR_LITE \
- (void)appWillEnterForegroundNotification{[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(hideNav) userInfo:nil repeats:NO];}\
- (void)hideNav{ [[[self navigationController] navigationBar] setAlpha:0];}\
- (void)viewDidDisappear:(BOOL)animated{[[NSNotificationCenter defaultCenter] removeObserver:self];\
    [super viewDidDisappear:animated];}
//- (void)viewWillDisappear:(BOOL)animated{[[[self navigationController] navigationBar] setHidden:NO];}


#define ACTIVE_HIDE_NAVIBAR_DEEP \
- (void)viewWillAppear:(BOOL)animated{[[[self navigationController] navigationBar] setAlpha:0];\
[super viewWillAppear:animated];\
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForegroundNotification) name: UIApplicationWillEnterForegroundNotification object:nil];}\
- (void)appWillEnterForegroundNotification{[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(hideNav) userInfo:nil repeats:NO];}\
- (void)hideNav{ [[[self navigationController] navigationBar] setAlpha:0];}

#define ACTIVE_HIDE_NAVIBAR_LITE_LITE \
- (void)appWillEnterForegroundNotification{[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(hideNav) userInfo:nil repeats:NO];}\
- (void)hideNav{ [[[self navigationController] navigationBar] setAlpha:0];}

#define ACTIVE_HIDE_NAVIBAR_NO_WILL_APPERAR \
- (void)appWillEnterForegroundNotification{[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(hideNav) userInfo:nil repeats:NO];}\
- (void)hideNav{ [[[self navigationController] navigationBar] setAlpha:0];}\
- (void)viewDidDisappear:(BOOL)animated{[[NSNotificationCenter defaultCenter] removeObserver:self];\
    [super viewDidDisappear:animated];}
//- (void)viewWillDisappear:(BOOL)animated{[[[self navigationController] navigationBar] setHidden:NO];}

/*
- (void)viewWillAppear:(BOOL)animated
{
    [[[self navigationController] navigationBar] setAlpha:0];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForegroundNotification) name: UIApplicationWillEnterForegroundNotification object:nil];
}
*/