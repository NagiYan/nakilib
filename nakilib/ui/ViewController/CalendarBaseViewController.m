//
//  CalendarBaseViewController.m
//  HealthManagement
//
//  Created by BST on 13-10-3.
//  Copyright (c) 2013年 BST. All rights reserved.
//

#import "CalendarBaseViewController.h"

@interface CalendarBaseViewController ()

@end

@implementation CalendarBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void)dealloc
{
    [kal release];
    
    [super dealloc];
}

- (void)loadCalendarView:(UIView*)parentView yPos:(int)yPos
{
    kal = [[KalViewController alloc] initWithParent:self];
    //[self.view addSubview:kal.view];
    [parentView addSubview:kal.view];

    CGRect rect = kal.view.frame;
    rect.origin.y = yPos;
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)
    {
        rect.origin.y -= 20;
    }
    kal.view.frame = rect;
    [kal switchToWeekView];
}

- (void)loadCalendarView:(UIView*)parentView yPos:(int)yPos withDate:(NSDate*)date
{
    kal = [[KalViewController alloc] initWithParent:self andDate:date];
    //[self.view addSubview:kal.view];
    [parentView addSubview:kal.view];
    
    CGRect rect = kal.view.frame;
    rect.origin.y = yPos;
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)
    {
        rect.origin.y -= 20;
    }
    kal.view.frame = rect;
    [kal switchToWeekView];
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

- (void)onClickCalendar
{
    if( [kal isWeekView] )
        [kal switchToMonthView];
    else
        [kal switchToWeekView];
}

- (void)didSelectedYear:(int)year Month:(int)month Day:(int)day
{
    
}

@end