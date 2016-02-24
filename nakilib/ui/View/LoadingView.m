//
//  LoadingView.m
//  west dean delicious
//
//  Created by westonnaki on 15/6/26.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame andStyle:(LoadingViewStyle)style
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 设定位置和大小
        CGRect frameV = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        NSString *gif;
        if (LoadingViewStyleBall == style)
        {
            gif = @"ball.gif";
        }
        else if(LoadingViewStylePlane == style)
        {
            gif = @"plane.gif";
        }
        
        //frameV.size = [UIImage imageNamed:gif].size;

        // view生成
        UIWebView *webView = [[[UIWebView alloc] initWithFrame:frameV] autorelease];
        webView .opaque = NO;
        webView.userInteractionEnabled = NO;//用户不可交互
        //webView.scalesPageToFit = YES;
        [self addSubview:webView];
        
        NSString *html = [NSString stringWithFormat:@"<html><head><body><img src=\"%@\"  height=\"%.0f\" width=\"%.0f\"><body></head></html>"
                          , gif, frame.size.width, frame.size.height];
        NSString *path = [[NSBundle mainBundle] resourcePath];
        NSURL *baseURL = [NSURL fileURLWithPath:path];
        [webView loadHTMLString:html baseURL:baseURL];
    }
    
    return self;
}

@end
