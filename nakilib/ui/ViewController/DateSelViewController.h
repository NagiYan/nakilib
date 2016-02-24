//
//  DateSelViewController.h
//  HealthManagement
//
//  Created by BST on 13-10-16.
//  Copyright (c) 2013年 BST. All rights reserved.
//

#import <UIKit/UIKit.h>

enum DateSelType
{
    kDateSelTypeDateTime = 0,
    kDateSelTypeDate,
    kDateSelTypeTime
};

@protocol DateSelDelegator <NSObject>

@optional

- (void)dateSelViewDoneWithDateTime:(NSString*)strTime;

@end

@interface DateSelViewController : UIViewController
{
    UITextField*            _dateTextField;
    UIView*                 _maskView;
    
    enum DateSelType        _dateSelType;
    
    IBOutlet UIDatePicker*  _datePicker;
    
    id<DateSelDelegator>    _dateSelDelegator;
}

+ (void)popupWithParentView:(UIView*)parentView textField:(UITextField*)textField type:(enum DateSelType)type;

+ (void)popupWithParentView:(UIView*)parentView textField:(UITextField*)textField type:(enum DateSelType)type delegate:(id<DateSelDelegator>)delegate;

- (IBAction)onClickOK:(id)sender;

- (IBAction)onClickCancel:(id)sender;

@end
