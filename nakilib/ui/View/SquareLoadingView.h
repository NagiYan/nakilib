//
//  SquareLoadingView.h
//  west dean delicious
//
//  Created by westonnaki on 16/3/7.
//  Copyright © 2016年 westonnaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SquareLoadingView : UIView

// 颜色
@property (strong, nonatomic)UIColor* color;

// 动画图形间距
@property (assign, nonatomic)CGFloat margin;

#pragma mark

- (void)beginAnimation;

- (void)stopAnimation;

@end
