//
//  ProgressView.h
//  west dean delicious
//
//  Created by westonnaki on 15/7/15.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView
// 初始化
- (id)initWithColor:(UIColor*)color;

// 设置进度
- (void)setPos:(float)pos;

// 设置信息
- (void)setText:(NSString*)text;

@property (retain, nonatomic)UIProgressView* progressView;
@end
