//
//  NUINavigationBar.m
//  west dean delicious
//
//  Created by westonnaki on 15/5/15.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//

#import "NUINavigationBar.h"

@interface NUINavigationBar ()
{
}

@end

@implementation NUINavigationBar

- (id)initWithDefaultFrameAndColor
{
    return [self initWithFrame:CGRectMake(0, 0, [[GScreen sharedInstance] GetDeviceFrame].width, 64) withColor:FlatThemeColor];
}

- (id)initWithFrame:(CGRect)frame withColor:(UIColor*)color
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        // 设置背景色
        [self setBackgroundColor:[UIColor whiteColor]];
        
        //创建一个导航栏集合
        UINavigationItem* navItem = [[[UINavigationItem alloc] initWithTitle:@""] autorelease];
        _labelTitle = [[[UILabel alloc] initWithFrame:CGRectMake(GScreenWidth/2-60, 20, 120, 44)] autorelease];
        [_labelTitle setTextAlignment:NSTextAlignmentCenter];
        [_labelTitle setTextColor:FlatThemeColor];
        [_labelTitle setFont:[UIFont fontWithName:@"Helvetica" size:20]];
        [navItem setTitleView:_labelTitle];

        [self setButtonLeft:[[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil] autorelease]];
        [self setButtonRight:[[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil] autorelease]];
        [self setButtonRight2nd:[[[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil] autorelease]];

        [self pushNavigationItem:navItem animated:NO];
        [navItem setLeftBarButtonItem:[self buttonLeft]];
        [navItem setRightBarButtonItems:[NSArray arrayWithObjects:[self buttonRight], [self buttonRight2nd], nil]];
    }
    return self;
}

@end
