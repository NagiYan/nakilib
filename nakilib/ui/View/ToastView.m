//
//  ToastView.m
//  Community
//
//  Created by BST on 13-6-15.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ToastView.h"
#import "GSizeUtil.h"
#import "ShapeFactory.h"

static int delayQueue = 0;

@implementation ToastView

+(void) showWithParent:(UIView*)parent text:(NSString*)text
{
    [ToastView showWithParent:parent text:text afterDelay:0.0f];
}

+(void) showWithParent:(UIView*)parent text:(NSString*)text afterDelay:(float)delay
{
    [ToastView showWithParent:parent text:text afterDelay:delay pos:150];
}

+(void) showWithParent:(UIView*)parent text:(NSString*)text afterDelay:(float)delay pos:(NSInteger)height
{
    ToastView* view = [[[ToastView alloc] initWithText:text delay:delay] autorelease];
    [parent addSubview:view];
    
    view.layer.borderColor = [[UIColor grayColor] CGColor];
    view.backgroundColor = [UIColor blackColor];
    view.textColor = [UIColor whiteColor];
    view.font = [UIFont systemFontOfSize:18.0f];
    view.textAlignment = NSTextAlignmentCenter;
    [ShapeFactory decorateLayerAllCornerWithRadius:10 forView:view];
    view.userInteractionEnabled = FALSE;
    view.numberOfLines = 0;
    
    CGSize parentSize = [parent frame].size;
    NSInteger contentHeight = [GSizeUtil getHeightForString:text withSysFontSize:18 maxWidth:parentSize.width - 80];
    
    view.frame = CGRectMake(30, parentSize.height - contentHeight - 40 - height, parentSize.width - 60, contentHeight + 40);
    
    if( [parent isKindOfClass:[UIScrollView class]] )
    {
        view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + ((UIScrollView*)parent).contentOffset.y, view.frame.size.width, view.frame.size.height);
    }
}

+(void) showWithParent:(UIView*)parent text:(NSString*)text pos:(NSInteger)height
{
    [ToastView showWithParent:parent text:text afterDelay:0.0 pos:height];
}

+(void) showWithParentTop:(UIView*)parent text:(NSString*)text
{
    [ToastView showWithParent:parent text:text pos:150];
}

-(id) initWithText:(NSString*)text delay:(float)delay
{
    // 根据排队，增加延时
    delay += delayQueue*2.0;
    delayQueue++;
    
    self = [super init];
    
    if( self )
    {
        self.text = text;

        self.alpha = 0.0;
        [self performSelector:@selector(displayToast:) withObject:nil afterDelay:delay];
    }
    
    return self;
}

-(void) displayToast:(id)object
{
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationDuration:0.5f];
    [UIView setAnimationDelegate: self];
    self.alpha = 0.8;
    [UIView commitAnimations];
    
    [self performSelector:@selector(dismissToast:) withObject:nil afterDelay:1.5f];
}

-(void) dismissToast:(id)object
{
    // 等到开始消失时从排队中清除
    delayQueue--;
    
    [UIView beginAnimations: nil context: nil];
    [UIView setAnimationDuration:0.5f];
    [UIView setAnimationDelegate: self];
    [UIView setAnimationDidStopSelector:@selector(didDismissEnded:)];
    self.alpha = 0.0;
	[UIView commitAnimations];
}

-(void) didDismissEnded:(id) object
{
    [self removeFromSuperview];
}

@end
