//
//  HttpBaseViewController.m
//  HealthManagement
//
//  Created by BST on 13-10-17.
//  Copyright (c) 2013年 BST. All rights reserved.
//

#import "HttpBaseViewController.h"

@interface HttpBaseViewController ()

@end

@implementation HttpBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showBusyDialogWithTitle:(NSString*)strTitle
{
    if( HUD != nil )
    {
        return;
    }
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = strTitle;
    [self.view bringSubviewToFront:HUD];
    HUD.removeFromSuperViewOnHide = true;
    [HUD show:YES];
}

- (void)showBusyDialog
{
    [self showBusyDialogWithTitle:@"正在加载"];
}

- (void)hideBusyDialog
{
    [HUD hide:YES];
    [HUD removeFromSuperview];
    HUD = nil;
}

@end
