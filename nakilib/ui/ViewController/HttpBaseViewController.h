//
//  HttpBaseViewController.h
//  HealthManagement
//
//  Created by BST on 13-10-17.
//  Copyright (c) 2013年 BST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface HttpBaseViewController : UIViewController
{
    MBProgressHUD   *HUD;
}

- (void)showBusyDialogWithTitle:(NSString*)strTitle;

- (void)showBusyDialog;

- (void)hideBusyDialog;

@end
