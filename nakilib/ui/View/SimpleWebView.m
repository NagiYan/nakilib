//
//  SimpleWebView.m
//  west dean delicious
//
//  Created by westonnaki on 15/7/14.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//

#import "SimpleWebView.h"
#import "Masonry.h"
#import "pop.h"
#import "ReactiveCocoa.h"
#import "SquareLoadingView.h"

@interface SimpleWebView ()
@property (retain, nonatomic)UIView* background;
@end

@implementation SimpleWebView
{
    SquareLoadingView *activityIndicatorView;
}

- (void)showWithAnimation:(BOOL)animation result:(void(^)(NSInteger))result
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo([self superview]).with.insets(UIEdgeInsetsMake(([UIScreen mainScreen].applicationFrame.size.height + 20), 0, 0, 0));
    }];
    [self setBackgroundColor:[UIColor clearColor]];
    
    _background = [UIView new];
    [self addSubview:_background];
    [_background mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [_background setBackgroundColor:[UIColor clearColor]];
    
    [self addWebView:_url];
    [self addOKButton:result];
    if (_showCancelButton)
    {
        [self addCancelButton:result];
    }
    
    if (animation)
    {
        [UIView animateWithDuration:0.6
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [self mas_updateConstraints:^(MASConstraintMaker *make) {
                                 make.edges.equalTo([self superview]);
                             }];
                         }
                         completion:^(BOOL finished){
                             [[self background].layer pop_removeAllAnimations];
                             POPSpringAnimation* animColor = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
                             animColor.toValue = [UIColor colorWithWhite:0 alpha:0.7];
                             [[self background].layer pop_addAnimation:animColor forKey:@"animationColor"];
                         }];
    }
}

#pragma mark

- (void)addWebView:(NSURL*)url
{
    SAMWebView* webview = [SAMWebView new];
    [self addSubview:webview];
    [webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).with.offset(20);
        make.bottom.equalTo(self);//.with.offset(-20);
    }];
    
    [webview setDelegate:self];
    [webview setClipsToBounds:YES];
    webview.layer.cornerRadius = 5;
    webview.layer.masksToBounds = YES;
    
    activityIndicatorView = [[SquareLoadingView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 40.0f, 40.f)];
    [activityIndicatorView setCenter: CGPointMake([UIScreen mainScreen].applicationFrame.size.width/2, [UIScreen mainScreen].applicationFrame.size.height/2)];
    [self addSubview : activityIndicatorView];
    [activityIndicatorView setColor:[UIColor blackColor]];
    [webview loadURL:url ];
}

- (void)addOKButton:(void(^)(NSInteger))result
{
    UIButton* close = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 66, 66)];
    [close setCenter:CGPointMake([UIScreen mainScreen].applicationFrame.size.width- 50, [UIScreen mainScreen].applicationFrame.size.height - 50)];
    __block typeof(self) weakSelf = self;
    [[close rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        result(0);
        [weakSelf onClickOK];
    }];
    [self addSubview:close];
    close.layer.cornerRadius = 33;
    close.layer.masksToBounds = YES;
    [close setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    [close setTitle:@"确定" forState:UIControlStateNormal];
}

- (void)addCancelButton:(void(^)(NSInteger))result
{
    UIButton* close = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 66, 66)];
    [close setCenter:CGPointMake(50, [UIScreen mainScreen].applicationFrame.size.height - 70)];
    __block typeof(self) weakSelf = self;
    [[close rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        result(1);
        [weakSelf onClickOK];
    }];
    [self addSubview:close];
    close.layer.cornerRadius = 33;
    close.layer.masksToBounds = YES;
    [close setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    [close setTitle:@"取消" forState:UIControlStateNormal];
}

#pragma mark - event
- (void)onClickOK
{
    __block typeof(self) weakSelf = self;
    [[self background].layer pop_removeAllAnimations];
    POPSpringAnimation* animColor = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
    animColor.toValue = [UIColor colorWithWhite:0 alpha:0];
    [animColor setCompletionBlock:^(POPAnimation *ani, BOOL finished) {
        if (finished)
        {
            [UIView animateWithDuration:0.3
                                  delay:0.0
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 [self setFrame:CGRectMake([UIScreen mainScreen].applicationFrame.size.width - 50, [UIScreen mainScreen].applicationFrame.size.height - 50, 0, 0)];
                             }
                             completion:^(BOOL finishedX){
                                 [weakSelf removeFromSuperview];
                             }];
        }
    }];
    [[self background].layer pop_addAnimation:animColor forKey:@"animationColor"];
}

- (void)onClickCancel
{
    __block typeof(self) weakSelf = self;
    [[self background].layer pop_removeAllAnimations];
    POPSpringAnimation* animColor = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
    animColor.toValue = [UIColor colorWithWhite:0 alpha:0];
    [animColor setCompletionBlock:^(POPAnimation *ani, BOOL finished) {
        if (finished)
        {
            [UIView animateWithDuration:0.3
                                  delay:0.0
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 [self setFrame:CGRectMake(50, [UIScreen mainScreen].applicationFrame.size.height - 50, 0, 0)];
                             }
                             completion:^(BOOL finishedX){
                                 [weakSelf removeFromSuperview];
                             }];
        }
    }];
    [[self background].layer pop_addAnimation:animColor forKey:@"animationColor"];
}

#pragma mark - webview delegate
- (void)webViewDidStartLoad:(SAMWebView *)webView
{
    [activityIndicatorView beginAnimation];
}
- (void)webViewDidFinishLoad:(SAMWebView *)webView
{
    [activityIndicatorView stopAnimation];
}

- (void)webView:(SAMWebView *)webView didFailLoadWithError:(NSError *)error
{
    [activityIndicatorView stopAnimation];
}
@end
