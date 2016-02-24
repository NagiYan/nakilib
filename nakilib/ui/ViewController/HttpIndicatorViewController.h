//
//  HttpIndicatorViewController.h
//  west dean delicious
//
//  Created by westonnaki on 15/5/25.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HttpIndicatorViewController : UIViewController

// 进入加载模式
- (void)requestBegin;

// 重试模式
- (void)showRetryMode;

// 加载成功
- (void)requestFinish;
@end
