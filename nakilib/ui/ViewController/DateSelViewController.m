//
//  DateSelViewController.m
//  HealthManagement
//
//  Created by BST on 13-10-16.
//  Copyright (c) 2013年 BST. All rights reserved.
//

#import "DateSelViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation DateSelViewController

+ (void)popupWithParentView:(UIView*)parentView textField:(UITextField*)textField type:(enum DateSelType)type
{
    [[DateSelViewController alloc] initWithParentView:parentView textField:textField type:type];
}

+ (void)popupWithParentView:(UIView*)parentView textField:(UITextField*)textField type:(enum DateSelType)type delegate:(id<DateSelDelegator>)delegate
{
    [[DateSelViewController alloc] initWithParentView:parentView textField:textField type:type delegate:delegate];
}

- (id)initWithParentView:(UIView*)parentView  textField:(UITextField*)textField  type:(enum DateSelType)type delegate:(id<DateSelDelegator>)delegate
{
    self = [self initWithParentView:parentView textField:textField type:type];
    
    _dateSelDelegator = delegate;
    
    return self;
}

- (id)initWithParentView:(UIView*)parentView  textField:(UITextField*)textField  type:(enum DateSelType)type
{
    self = [self initWithNibName:@"DateSelViewController" bundle:nil];
    if( self == nil )
        return self;

    _dateSelType = type;
    _dateTextField = textField;

    CGRect rect = parentView.frame;
    
    _maskView = [[[UIView alloc] initWithFrame:rect] autorelease];
    
    _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [parentView addSubview:_maskView];
    
    CGRect centerRt;
    
    centerRt.size = self.view.frame.size;
    centerRt.origin.x = (rect.size.width - self.view.frame.size.width)/2;
    centerRt.origin.y = (rect.size.height - centerRt.size.height)/2;
    self.view.frame = centerRt;
    
    [parentView addSubview:self.view];
    
    _dateSelDelegator = nil;

    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if( self )
    {
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.layer.borderWidth = 2;
    self.view.layer.cornerRadius = 5;
    self.view.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    _datePicker.layer.cornerRadius = 5;
    
    if( _dateSelType == kDateSelTypeDateTime )
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    else if( _dateSelType == kDateSelTypeDate )
        _datePicker.datePickerMode = UIDatePickerModeDate;
    else
        _datePicker.datePickerMode = UIDatePickerModeTime;

    _datePicker.maximumDate = [NSDate date];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onClickOK:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];;
    
    if( _dateSelType == kDateSelTypeDateTime )
    {
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//;
    } else if( _dateSelType == kDateSelTypeDate )
    {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    else
    {
        [dateFormatter setDateFormat:@"HH:mm"];//
    }
    
    NSString*   dateString = [dateFormatter stringFromDate:_datePicker.date];
    
    [_dateTextField setText:dateString];

    if( _dateSelDelegator != nil && [_dateSelDelegator respondsToSelector:@selector(dateSelViewDoneWithDateTime:)] )
    {
        [_dateSelDelegator dateSelViewDoneWithDateTime:dateString];
    }
    
    [self.view removeFromSuperview];
    [_maskView removeFromSuperview];
    [self release];
}

- (IBAction)onClickCancel:(id)sender
{
    [self.view removeFromSuperview];
    [_maskView removeFromSuperview];
    [self release];
}

- (void)dealloc
{
    [super dealloc];
}

@end
