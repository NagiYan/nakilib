//
//  ProgressView.m
//  west dean delicious
//
//  Created by westonnaki on 15/7/15.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//

#import "ProgressView.h"
#import "GScreen.h"
#import "FontUtil.h"

@implementation ProgressView
{
    UIView* maskView;
    UILabel* infoLabel;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

// 初始化
- (id)initWithColor:(UIColor*)color
{
    self = [super initWithFrame:CGRectMake(0, 0, GScreenWidth, GScreenHeight)];
    
    if (self)
    {
        maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, GScreenWidth, GScreenHeight)];
        [maskView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.6]];
        [self addSubview:maskView];
        
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(20, GScreenHeight*0.4, GScreenWidth - 40, 3)];
        [maskView addSubview:_progressView];
        [_progressView setProgress:0 animated:YES];
        [_progressView setTintColor:color];
        
        infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, GScreenHeight*0.4 - 30, GScreenWidth - 20, 21)];
        [infoLabel setTextColor:[UIColor colorWithWhite:1 alpha:1]];
        [infoLabel setFont:SYSTEM_FONT(14)];
        [infoLabel setTextAlignment:NSTextAlignmentCenter];
        [infoLabel setText:@""];
        [maskView addSubview:infoLabel];
    }
    
    return self;
}

// 设置进度
- (void)setPos:(float)pos
{
    [_progressView setProgress:pos animated:YES];
}

// 设置信息
- (void)setText:(NSString*)text
{
    [infoLabel setText:text];
}
@end
