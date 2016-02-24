//
//  TimePickerView.m
//  west dean delicious
//
//  Created by westonnaki on 15/7/7.
//  Copyright (c) 2015年 westonnaki. All rights reserved.
//

#import "TimePickerView.h"

@implementation TimePickerView
{
    UIPickerView* pickerHour;
    UIPickerView* pickerMinute;
    UIPickerView* pickerSecond;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame withSeconds:(NSInteger)seconds
{
    self = [super initWithFrame:CGRectMake(0, 0, GScreenWidth, GScreenHeight)];
    if (self)
    {
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        [self initTime:seconds frame:frame];
    }
    return self;
}

#pragma mark - util
- (void)initTime:(NSInteger)seconds frame:(CGRect)frame
{
    UIView* backView = [[[UIView alloc] initWithFrame:frame] autorelease];
    [self addSubview:backView];
    [backView setTag:99];
    [backView setBackgroundColor:[UIColor whiteColor]];
    
    NSInteger perWidth = (frame.size.width - 20)/3*0.6;
    pickerHour = [[[UIPickerView alloc] initWithFrame:CGRectMake(10, 10, perWidth, frame.size.height - 20)] autorelease];
    pickerMinute = [[[UIPickerView alloc] initWithFrame:CGRectMake(10 + (frame.size.width - 20)/3, 10, perWidth, frame.size.height - 20)] autorelease];
    pickerSecond = [[[UIPickerView alloc] initWithFrame:CGRectMake(10 + (frame.size.width - 20)/3*2, 10, perWidth, frame.size.height - 20)] autorelease];
    [pickerHour setDelegate:self];
    [pickerMinute setDelegate:self];
    [pickerSecond setDelegate:self];
    
    [backView addSubview:pickerHour];
    [backView addSubview:pickerMinute];
    [backView addSubview:pickerSecond];
    
    UILabel* labelHour = [[[UILabel alloc] initWithFrame:CGRectMake(10 + (frame.size.width - 20)/3*0.6, 10, (frame.size.width - 20)/3*0.4, frame.size.height - 20)] autorelease];
    [backView addSubview:labelHour];
    [labelHour setText:@"时"];
    [labelHour setFont:SYSTEM_FONT(15)];
    [labelHour setTextAlignment:NSTextAlignmentCenter];
    
    UILabel* labelMinute = [[[UILabel alloc] initWithFrame:CGRectMake(10 + (frame.size.width - 20)/3*1.6, 10, (frame.size.width - 20)/3*0.4, frame.size.height - 20)] autorelease];
    [backView addSubview:labelMinute];
    [labelMinute setText:@"分"];
    [labelMinute setFont:SYSTEM_FONT(15)];
    [labelMinute setTextAlignment:NSTextAlignmentCenter];
    
    UILabel* labelSecond = [[[UILabel alloc] initWithFrame:CGRectMake(10 + (frame.size.width - 20)/3*2.6, 10, (frame.size.width - 20)/3*0.4, frame.size.height - 20)] autorelease];
    [backView addSubview:labelSecond];
    [labelSecond setText:@"秒"];
    [labelSecond setFont:SYSTEM_FONT(15)];
    [labelSecond setTextAlignment:NSTextAlignmentCenter];
    
    
    [pickerHour selectRow:seconds/3600/10 inComponent:0 animated:YES];
    [pickerHour selectRow:seconds/3600%10 inComponent:1 animated:YES];
    [pickerMinute selectRow:seconds%3600/60/10 inComponent:0 animated:YES];
    [pickerMinute selectRow:seconds%3600/60%10 inComponent:1 animated:YES];
    [pickerSecond selectRow:seconds%3600%60/10 inComponent:0 animated:YES];
    [pickerSecond selectRow:seconds%3600%60%10 inComponent:1 animated:YES];
}

- (NSInteger)getTime
{
    NSInteger seconds = 0;
    seconds += [pickerHour selectedRowInComponent:0]*10*3600;
    seconds += [pickerHour selectedRowInComponent:1]*3600;
    seconds += [pickerMinute selectedRowInComponent:0]*10*60;
    seconds += [pickerMinute selectedRowInComponent:1]*60;
    seconds += [pickerSecond selectedRowInComponent:0]*10;
    seconds += [pickerSecond selectedRowInComponent:1];
    
    return seconds;
}

#pragma mark -pickerView delegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    UIView* backView = [UIViewUtil getSubViewByTag:99 in:self];
    NSInteger perWidth = (backView.frame.size.width - 20)/3*0.3;
    return perWidth;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 25;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == pickerHour)
    {
        if (component == 0)
        {
            return 3;
        }
    }
    else
    {
        if (component == 0)
        {
            return 7;
        }
    }
    
    return 10;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    NSInteger perWidth = (GScreenWidth - 20)/3*0.6;
    
    UILabel *myView = nil;
    
    myView = [[[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, perWidth, 30)] autorelease];
    
    myView.textAlignment = NSTextAlignmentCenter;
    
    myView.text = [NSString stringWithFormat:@"%ld", (long)row];
    
    myView.font = [UIFont systemFontOfSize:14];         //用label来设置字体大小
    
    myView.backgroundColor = [UIColor clearColor];
        

    return myView;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

}


@end
