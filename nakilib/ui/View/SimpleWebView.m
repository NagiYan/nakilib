//
//  SimpleWebView.m
//  west dean delicious
//
//  Created by westonnaki on 15/7/14.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//

#import "SimpleWebView.h"
#import "UIView+ADGifLoading.h"
#import "Masonry.h"
#import "pop.h"
#import "GScreen.h"
#import "ShapeFactory.h"
#import "ReactiveCocoa.h"

@interface SimpleWebView ()
@property (retain, nonatomic)UIView* background;
@end

@implementation SimpleWebView
{
    UIImageView *activityIndicatorView;
}

- (void)showWithAnimation:(BOOL)animation result:(void(^)(NSInteger))result
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo([self superview]).with.insets(UIEdgeInsetsMake(GScreenHeight, 0, 0, 0));
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
    [ShapeFactory decorateLayerAllCornerWithRadius:5 forView:webview];
    
    activityIndicatorView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [activityIndicatorView setCenter: CGPointMake(GScreenWidth/2, GScreenHeight/2)] ;
    [activityIndicatorView ad_setLoadingImageGifName:@"ball.gif"];
    [self addSubview : activityIndicatorView] ;
    
    [webview loadURL:url ];
}

- (void)addOKButton:(void(^)(NSInteger))result
{
    UIButton* close = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 66, 66)];
    [close setCenter:CGPointMake(GScreenWidth- 50, GScreenHeight - 50)];
    __block typeof(self) weakSelf = self;
    [[close rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        result(0);
        [weakSelf onClickOK];
    }];
    [self addSubview:close];
    [ShapeFactory decorateLayerAllCornerWithRadius:33 forView:close];
    [close setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    [close setTitle:@"确定" forState:UIControlStateNormal];
}

- (void)addCancelButton:(void(^)(NSInteger))result
{
    UIButton* close = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 66, 66)];
    [close setCenter:CGPointMake(50, GScreenHeight - 70)];
    __block typeof(self) weakSelf = self;
    [[close rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        result(1);
        [weakSelf onClickOK];
    }];
    [self addSubview:close];
    [ShapeFactory decorateLayerAllCornerWithRadius:33 forView:close];
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
                                 [self setFrame:CGRectMake(GScreenWidth - 50, GScreenHeight - 50, 0, 0)];
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
                                 [self setFrame:CGRectMake(50, GScreenHeight - 50, 0, 0)];
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
    [activityIndicatorView ad_showLoading];
}
- (void)webViewDidFinishLoad:(SAMWebView *)webView
{
    [activityIndicatorView ad_hideLoading];
}

- (void)webView:(SAMWebView *)webView didFailLoadWithError:(NSError *)error
{
    [activityIndicatorView ad_hideLoading];
}
@end
