//
//  HttpIndicatorViewController.m
//  west dean delicious
//
//  Created by westonnaki on 15/5/25.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//

#import "HttpIndicatorViewController.h"
#import "GScreen.h"

@interface HttpIndicatorViewController ()
{
    UIActivityIndicatorView* indicator;
    UILabel*    labelMessage;
    UIButton*   btnRetry;
}
@end

@implementation HttpIndicatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)initUI
{
    [[self view] setFrame:CGRectMake(0, 0, GScreenWidth, GScreenHeight)];
    [labelMessage setFrame:CGRectMake(10, 100, GScreenWidth - 20, 21)];
    [btnRetry setFrame:CGRectMake(10, 130, GScreenWidth - 20, 100)];
    [indicator setFrame:CGRectMake(GScreenWidth/2 - 22, 200, 44, 44)];
    
}

// 进入加载模式
- (void)requestBegin
{
    [labelMessage setText:@"正在加载,请稍候..."];
    [btnRetry setHidden:YES];
    [indicator startAnimating];
}

// 重试模式
- (void)showRetryMode
{
    [labelMessage setText:@"正在尝试重新连接服务器..."];
    [btnRetry setHidden:YES];
    [indicator startAnimating];
    [indicator setHidden:NO];
}

// 加载成功
- (void)requestFinish
{
    [labelMessage setHidden:YES];
    [indicator stopAnimating];
    [indicator setHidden:YES];
}
@end
