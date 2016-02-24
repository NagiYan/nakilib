//
//  TopBar.m
//  Nagi
//  通用的新消息数目标签
//  Created by Nagi on 15-2-11.
//  Copyright (c) 2015年 Nagi. All rights reserved.
//

#import "ColorUtil.h"
#import "Topbar.h"
#import "Masonry.h"
#import "GScreen.h"
#import "ColorDefine.h"
#import "ShapeFactory.h"

@implementation TopBar
{
    UIView* line;
    UIView* bkgRight;
    UIView* background;
}

- (id)initWithDefaultFrameAndColor:(UIColor*)color
{
    return [self initWithFrame:CGRectMake(0, 0, [[GScreen sharedInstance] GetDeviceFrame].width, 64) withColor:color];
}

- (id)initWithFrame:(CGRect)frame withColor:(UIColor*)color
{
    self = [super initWithFrame:frame];
    if (self)
    {
        background = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)] autorelease];
        [self addSubview:background];
        
        // 设置背景色
        [background setBackgroundColor:UICOLOR_BKG_NAV];
        [self setBackgroundColor:[UIColor clearColor]];
        
        // 标题
        _labelTitle = [[[UILabel alloc] initWithFrame:CGRectMake(GScreenWidth/2-60, 20, 120, 44)] autorelease];
        [self addSubview:_labelTitle];
        
        // 左侧按钮
        _buttonLeft = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] autorelease];
        [self addSubview:_buttonLeft];
        [_buttonLeft setImageEdgeInsets:UIEdgeInsetsMake(6, 6, 6, 6)];
        [_buttonLeft mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(5);
            make.top.mas_equalTo(20);
            make.width.mas_equalTo(44);
            make.height.mas_equalTo(44);
        }];
        
        // 右侧第一个按钮
        _buttonRight = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] autorelease];
        [self addSubview:_buttonRight];
        [_buttonRight setImageEdgeInsets:UIEdgeInsetsMake(6, 6, 6, 6)];
        [_buttonRight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-5);
            make.top.mas_equalTo(20);
            make.width.mas_equalTo(44);
            make.height.mas_equalTo(44);
        }];
        
        // 右侧第二个按钮
        _buttonRight2nd = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)] autorelease];
        [self addSubview:_buttonRight2nd];
        [_buttonRight2nd setImageEdgeInsets:UIEdgeInsetsMake(6, 6, 6, 6)];
        [_buttonRight2nd mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-64);
            make.top.mas_equalTo(20);
            make.width.mas_equalTo(44);
            make.height.mas_equalTo(44);
        }];
        
        [_labelTitle setHidden:YES];
        [_buttonLeft setHidden:YES];
        [_buttonRight setHidden:YES];
        [_buttonRight2nd setHidden:YES];
        
        [_labelTitle setTextAlignment:NSTextAlignmentCenter];
        _labelTitle.font = [UIFont fontWithName:@"Helvetica" size:20];
        [_labelTitle setTextColor:color];
        
        [_buttonLeft setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        
        line = [[[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 1, GScreenWidth, 1)] autorelease];
        [line setBackgroundColor:UICOLOR_BKG_NAV_LINE];
        [self addSubview:line];
    }
    
    
    return self;
}

// 设置右侧按钮可见性
- (void)setRightButtonVisible:(BOOL)visible
{
    [[self buttonRight] setHidden:!visible];
    [bkgRight setHidden:!visible];
}

// 将按钮变成带灰底的圆形按钮
- (void)shapeButton
{    
    if (![[self buttonLeft] isHidden])
    {
        // 左侧按钮背景
        UIView* bkgLeft = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)] autorelease];
        [self addSubview:bkgLeft];
        [bkgLeft mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.mas_left).with.offset(11);
            make.top.equalTo(self.mas_top).with.offset(26);
            make.width.mas_equalTo(32);
            make.height.mas_equalTo(32);
        }];
        [ShapeFactory decorateLayerAllCornerWithRadius:16 forView:bkgLeft];
        [bkgLeft setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.6]];
        [self bringSubviewToFront:[self buttonLeft]];
    }

    if (![[self buttonRight] isHidden])
    {
        // 右侧按钮背景
        bkgRight = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)] autorelease];
        [self addSubview:bkgRight];
        [bkgRight mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-11);
            make.top.equalTo(self.mas_top).with.offset(26);
            make.width.mas_equalTo(32);
            make.height.mas_equalTo(32);
        }];
        [ShapeFactory decorateLayerAllCornerWithRadius:16 forView:bkgRight];
        [bkgRight setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.6]];
        [self bringSubviewToFront:[self buttonRight]];
    }
    
    if (![[self buttonRight2nd] isHidden])
    {
        // 右侧按钮背景
        UIView* bkgRight2 = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)] autorelease];
        [self addSubview:bkgRight2];
        [bkgRight2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_right).with.offset(-102);
            make.top.equalTo(self.mas_top).with.offset(26);
            make.width.mas_equalTo(32);
            make.height.mas_equalTo(32);
        }];
        [ShapeFactory decorateLayerAllCornerWithRadius:16 forView:bkgRight2];
        [bkgRight2 setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.6]];
        [self bringSubviewToFront:[self buttonRight2nd]];
    }
}

// 设置半透明
- (void)makeAlpha:(float)alpha
{
    UIColor* color = [background backgroundColor];
    [background setBackgroundColor:[ColorUtil makeColorAlpha:color alpha:alpha]];
    [line setBackgroundColor:[ColorUtil makeColorAlpha:UICOLOR_BKG_NAV_LINE alpha:alpha]];
    
    UIColor* colorTitle = [_labelTitle textColor];
    [_labelTitle setTextColor:[ColorUtil makeColorAlpha:colorTitle alpha:alpha]];
}

@end
