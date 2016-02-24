//
//  MasonryUtil.m
//  west dean delicious
//
//  Created by westonnaki on 15/11/2.
//  Copyright © 2015年 westonnaki. All rights reserved.
//

#import "MasonryUtil.h"
#import "Masonry.h"

@implementation MasonryUtil

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/**
*  将若干view等宽布局于容器containerView中
*
*  @param views         viewArray
*  @param containerView 容器view
*  @param LRpadding     距容器的左右边距
*  @param viewPadding   各view的左右边距
*/
+(void)makeEqualWidthViews:(NSArray *)views inView:(UIView *)containerView LRpadding:(CGFloat)LRpadding viewPadding:(CGFloat)viewPadding
{
    __block UIView *lastView = nil;
    [views enumerateObjectsUsingBlock:^(UIView*  _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        [containerView addSubview:view];
        if (lastView)
        {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(containerView);
                make.left.equalTo(lastView.mas_right).offset(viewPadding);
                make.width.equalTo(lastView);
            }];
        }
        else
        {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(containerView).offset(LRpadding);
                make.top.bottom.equalTo(containerView);
            }];
        }
        lastView=view;
    }];
     
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(containerView).offset(-LRpadding);
    }];
}

@end
