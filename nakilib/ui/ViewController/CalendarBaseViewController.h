//
//  CalendarBaseViewController.h
//  HealthManagement
//
//  Created by BST on 13-10-3.
//  Copyright (c) 2013年 BST. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HttpBaseViewController.h"
#import "Kal.h"

#define     TITLE_BAR_HEIGHT        44
#define     BOTTOM_BAR_HEIGHT       35

@interface CalendarBaseViewController : HttpBaseViewController <CalendarViewDelegate>
{
    KalViewController *kal;
}

- (void)loadCalendarView:(UIView*)parentView yPos:(int)yPos;

- (void)loadCalendarView:(UIView*)parentView yPos:(int)yPos withDate:(NSDate*)date;

- (IBAction)onClickCalendar;

- (void)didSelectedYear:(int)year Month:(int)month Day:(int)day;

@end
