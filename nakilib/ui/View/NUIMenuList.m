//
//  NUIMenuList.m
//  west dean delicious
//
//  Created by westonnaki on 15/6/9.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//

#import "NUIMenuList.h"

#define NHeight [UIScreen mainScreen].bounds.size.height
#define NWidth [UIScreen mainScreen].bounds.size.width
#define hsb(h,s,b) [UIColor colorWithHue:h/360.0f saturation:s/100.0f brightness:b/100.0f alpha:1.0]

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
    
    [self addGestureRecognizer:[self createTapGesture]];
}

- (UITapGestureRecognizer*)createTapGesture
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [tapGestureRecognizer setDelegate:self];
    return tapGestureRecognizer;
}

-(void)onTap:(UITapGestureRecognizer*)tap
{
    [self doHideWithAnimation];
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
    
    UIView* container = [[UIView alloc] initWithFrame:CGRectMake(20, NHeight/2 - height/2, NWidth - 40, height)];
    [self addSubview:container];
    [container setBackgroundColor:[UIColor whiteColor]];
    container.layer.cornerRadius = 3;
    container.layer.masksToBounds = YES;
    
    for (int i = 0; i < [[self sourceData] count]; ++i)
    {
        NSString* text = [[self sourceData] objectAtIndex:i];
        
        UIButton* selection = [[UIButton alloc] initWithFrame:CGRectMake(0, itemHeight*i, container.frame.size.width, itemHeight)];
        [selection setTitleColor:(i == [self indexSelected])?[UIColor blackColor]:[UIColor colorWithRed:162.0/255 green:162.0/255 blue:162.0/255 alpha:1.0] forState:UIControlStateNormal];
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
            [line setBackgroundColor:hsb(192, 2, 95)];
        }
    }
    
}

- (void)doShowWithAnimation
{
    __weak typeof(self) weakSelf = self;
    // 北京逐渐变暗
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [weakSelf setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
                     }
                     completion:^(BOOL finished2){}];
    
    self.layer.opacity = 0;
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         weakSelf.layer.opacity = 1;
                     }
                     completion:^(BOOL finished){}];
}

- (void)doHideWithAnimation
{
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         [weakSelf setBackgroundColor:[UIColor colorWithWhite:0 alpha:0]];
                     }
                     completion:^(BOOL finished){}];
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         weakSelf.layer.opacity = 0;
                     }
                     completion:^(BOOL finished2)
     {
         [weakSelf resignKeyWindow];
         [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
     }];
}

- (void)onClickItem:(id)sender
{
    NSInteger index = [sender tag];
    [[self menuDelegate] didSelectItem:self index:index];
    
    [self doHideWithAnimation];
}
@end
