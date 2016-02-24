//
//  LoadingView.h
//  west dean delicious
//
//  Created by westonnaki on 15/6/26.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _LoadingViewStyle
{
    LoadingViewStyleBall        ,
    LoadingViewStylePlane       ,
}LoadingViewStyle;

@interface LoadingView : UIView

- (id)initWithFrame:(CGRect)frame andStyle:(LoadingViewStyle)style;

@property (assign, nonatomic) LoadingViewStyle viewStyle;

@end
