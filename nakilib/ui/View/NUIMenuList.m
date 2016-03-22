//
//  NUIMenuList.m
//  west dean delicious
//
//  Created by westonnaki on 15/6/9.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//

#import "NUIMenuList.h"
#import "ReactiveCocoa.h"
#import "UIGestureRecognizer+ReactiveCocoa.h"
#import "GScreen.h"
#import "ShapeFactory.h"
#import "ColorDefine.h"
#import "Chameleon.h"

@interface NUIMenuList ()<UIGestureRecognizerDelegate>

@end

@implementation NUIMenuList
{
    
}

- (void)makeWindow
{
    [self setFrame:[[UIScreen mainScreen] bounds]];
    [self setWindowLevel:UIWindowLevelStatusBar];
    [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0]];
    [self initSelection];
    [self doShowWithAnimation];
    [self makeKeyAndVisible];
    
    UITapGestureRecognizer *recognizer = [UITapGestureRecognizer rac_recognizer];
    [recognizer setDelegate:self];
    recognizer.cancelsTouchesInView = NO;
    [self addGestureRecognizer:recognizer];
    __block typeof(self) weakSelf = self;
    [[recognizer rac_signal] subscribeNext:^(UITapGestureRecognizer *sender){
        [weakSelf doHideWithAnimation];
    }];
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return ![touch.view isKindOfClass:[UIButton class]];
}


//
- (void)initSelection
{
    // 总高度
    NSInteger itemHeight = 50;
    NSInteger height = [[self sourceData] count] * itemHeight;
    
    UIView* container = [[UIView alloc] initWithFrame:CGRectMake(20, GScreenHeight/2 - height/2, GScreenWidth - 40, height)];
    [self addSubview:container];
    [container setBackgroundColor:[UIColor whiteColor]];
    [ShapeFactory decorateLayerAllCornerWithRadius:3 forView:container];
    
    for (int i = 0; i < [[self sourceData] count]; ++i)
    {
        NSString* text = [[self sourceData] objectAtIndex:i];
        UIButton* selection = [[UIButton alloc] initWithFrame:CGRectMake(0, itemHeight*i, container.frame.size.width, itemHeight)];
        [selection setTitleColor:(i == [self indexSelected])?[UIColor blackColor]:UICOLOR_TEXT_GREY forState:UIControlStateNormal];
        [selection setTitle:text forState:UIControlStateNormal];
        selection.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        selection.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        [selection setTag:i];
        [selection addTarget:self action:@selector(onClickItem:) forControlEvents:UIControlEventTouchUpInside];
        [container addSubview:selection];
        
        if (i != [[self sourceData] count] - 1)
        {
            UIView* line = [[UIView alloc] initWithFrame:CGRectMake(0, itemHeight*(i + 1) - 1, container.frame.size.width, 1)];
            [container addSubview:line];
            [line setBackgroundColor:FlatWhite];
        }
    }
    
}

- (void)doShowWithAnimation
{
    [self setFrame:CGRectMake(0, GScreenHeight - 1, GScreenWidth, 1)];
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self setFrame:CGRectMake(0, 0, GScreenWidth, GScreenHeight)];
                     }
                     completion:^(BOOL finished)
     {
         [UIView animateWithDuration:0.3
                               delay:0.0
                             options:UIViewAnimationOptionCurveEaseInOut
                          animations:^{
                              [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
                          }
                          completion:^(BOOL finished2)
          {
              
          }];
     }];
}

- (void)doHideWithAnimation
{
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0]];
                     }
                     completion:^(BOOL finished)
     {
         [UIView animateWithDuration:0.3
                               delay:0.0
                             options:UIViewAnimationOptionCurveEaseInOut
                          animations:^{
                              [self setFrame:CGRectMake(0, GScreenHeight - 1, GScreenWidth, 1)];
                          }
                          completion:^(BOOL finished2)
          {
              [self resignKeyWindow];
              [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
          }];
     }];
}

- (void)onClickItem:(id)sender
{
    NSInteger index = [sender tag];
    [[self menuDelegate] didSelectItem:self index:index];
    
    [self doHideWithAnimation];
}
@end
