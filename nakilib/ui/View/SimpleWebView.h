//
//  SimpleWebView.h
//  west dean delicious
//
//  Created by westonnaki on 15/7/14.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SAMWebView.h>

@interface SimpleWebView : UIView<SAMWebViewDelegate>

@property (retain, nonatomic)NSURL* url;
@property (assign, nonatomic)BOOL showCancelButton;

- (void)showWithAnimation:(BOOL)animation result:(void(^)(NSInteger))result;
@end
