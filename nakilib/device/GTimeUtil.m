//
//  GTimeUtil.m
//  Nagi
//
//  Created by Nagi on 15-3-6.
//  Copyright (c) 2015年 Nagi. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "GTimeUtil.h"

@interface GTimeUtil ()

// 时间格式转换缓存，一个可以省一毫秒
@property (retain, nonatomic)NSMutableDictionary* dataFormateCache;

@end

@implementation GTimeUtil
IMPLEMENT_SINGLETON(GTimeUtil);


// 是否是今天
- (BOOL)isToday:(int)year dateMonth:(int)month dateDay:(int)day
{
    NSDate* now = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond;
    
    NSDateComponents *dd = [cal components:unitFlags fromDate:now];
    BOOL isToday = ([dd year] == year) && ([dd month] == month) && ([dd day] == day);
    return isToday;
}

// 现在多大了
- (NSInteger)howOldNow:(int)year dateMonth:(int)month dateDay:(int)day
{
    NSDate* now = [NSDate date];
    return [self ageAtDate:now withBirthYear:year month:month day:day];
}

- (NSDate*)convertDateFromString:(NSString*)uiDate  withFormat:(NSString*)format
{
    if (!uiDate) {
        return nil;
    }
    NSDate* final = [self dataFormateCache][uiDate];
    if (final)
    {
        return final;
    }
    else
    {
        if (!format) {
            format = @"yyyy-MM-dd HH:mm:ss";
        }
        NSDateFormatter *formatter = [[NSDateFormatter new] autorelease];
        [formatter setDateFormat:format];
        NSDate *date = [formatter dateFromString:uiDate];
        [self dataFormateCache][uiDate] = date;
        return date;
    }
}

- (NSInteger)ageAtDate:(NSDate*)date withBirthYear:(int)year month:(int)month day:(int)day
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute |NSCalendarUnitSecond;
    
    NSDateComponents *dd = [cal components:unitFlags fromDate:date];
    int d_year = (int)[dd year] - year;
    if ([dd month] >= month && [dd day] >= day)
    {
        return  MAX(0, d_year);
    }
    else
    {
        return MAX(0, d_year - 1);
    }
}

- (NSString*)getCurDateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString*   curDateString = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter release];//------------------------------------
    
    return curDateString;
}

- (NSString*)getCurDateTimeString
{
    return  [self NSDateToString:[NSDate date] withFomart:nil];
}

- (NSString*)NSDateToString:(NSDate*)date withFomart:(NSString*)fomart
{
    if (!fomart || [fomart isEqual:@""])
    {
        fomart = @"yyyy-MM-dd HH:mm:ss";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:fomart];
    
    NSString*   dateString = [dateFormatter stringFromDate:date];
    [dateFormatter release];//------------------------------------
    
    return dateString;
}

- (void)updateAlarm:(BOOL)on at:(int)hour minute:(int)minute repeat:(int)repeat withStr:(NSString*)strBody
{
    NSDateComponents *c = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSWeekCalendarUnit|NSCalendarUnitWeekday fromDate:[NSDate date]];
    
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    localNotif.timeZone = [NSTimeZone localTimeZone];
    localNotif.alertBody = strBody;
    
    localNotif.alertAction = @"查看";
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    //localNotif.soundName = @"ringtone.mp3";
    
    c.hour = hour;
    c.minute = minute;
    c.second = 0;
    
    if( (repeat & 0x7F) == 0x7F )
    {
        NSDate* date = [[NSCalendar currentCalendar] dateFromComponents:c];
        
        localNotif.fireDate = date;
        localNotif.repeatInterval = NSCalendarUnitDay;
        
        if(on)
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
        else
            [[UIApplication sharedApplication] cancelLocalNotification:localNotif];
    }
    else
    {
        NSInteger curDay = c.day;
        NSInteger curWeekDay = c.weekday - 2;   // sunday : -1, monday : 0, ... saturday : 5
        if( curWeekDay < 0 )
            curWeekDay += 7;    // sunday : 6, monday : 0, ... saturday : 5
        
        if( repeat & (1<<curWeekDay)) {
            NSDate* date0 = [[NSCalendar currentCalendar] dateFromComponents:c];
            NSLog(@"weekday: %@", [date0 description]);
            
            localNotif.fireDate = date0;
            localNotif.repeatInterval = NSCalendarUnitWeekday;
            if(on)
                [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
            else
                [[UIApplication sharedApplication] cancelLocalNotification:localNotif];
        }
        
        
        
        for( int k = 0; k < 7; k++ )
        {
            if( !(repeat & (1<<k)) ) {
                continue;
            }
            
            if( k > curWeekDay )
                c.day = curDay + (k-curWeekDay);
            else
                c.day = curDay + (k-curWeekDay+7);
            
            NSDate* date = [[NSCalendar currentCalendar] dateFromComponents:c];
            
            NSLog(@"weekday: %@", [date description]);
            
            NSLog(@"switchon: %@", on ? @"YES" : @"NO");
            
            localNotif.fireDate = date;
            localNotif.repeatInterval = NSCalendarUnitWeekday;
            
            if(on)
                [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
            else
                [[UIApplication sharedApplication] cancelLocalNotification:localNotif];
        }
    }
    
    [localNotif release];
}

// 某日至今有多久
- (NSString *)intervalSinceNow: (NSDate *)fromdate
{
    if (!fromdate) {
        return @"";
    }
    NSString *timeString=@"";
    
    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
    NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
    
    //获取当前时间
    NSDate *adate = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: adate];
    NSDate *localeDate = [adate  dateByAddingTimeInterval: interval];
    
    double intervalTime = [fromDate timeIntervalSinceReferenceDate] - [localeDate timeIntervalSinceReferenceDate];
    long lTime = labs((long)intervalTime);
    //NSInteger iSeconds =  lTime % 60;
    NSInteger iMinutes = (lTime / 60) % 60;
    NSInteger iHours = labs(lTime/3600);
    NSInteger iDays = lTime/60/60/24;
    //NSInteger iMonth =lTime/60/60/24/30;
    NSInteger iYears = lTime/60/60/24/365;
    
    
    //NSLog(@"相差%ld年%ld月 或者 %ld日%ld时%ld分%ld秒", iYears,iMonth,iDays,iHours,iMinutes,iSeconds);
    
    if (iHours<1 && iMinutes>0)
    {
        timeString=[NSString stringWithFormat:@"%ld分",(long)iMinutes];
        
    }
    else if (iHours>0 && iDays<1)
    {
        timeString=[NSString stringWithFormat:@"%ld时",(long)iHours];
    }
    else if (iDays>0 && iYears<1)
    {
        timeString=[NSString stringWithFormat:@"%ld天",(long)iDays];
    }
    else
    {
        timeString=[NSString stringWithFormat:@"%.1g年",iDays/365.0];
    }
    
    return timeString;
}

// 某个时间到现在有多少秒
- (long)SecondIntervalSinceNow:(NSDate *)fromdate
{
    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
    NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
    
    //获取当前时间
    NSDate *adate = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: adate];
    NSDate *localeDate = [adate  dateByAddingTimeInterval: interval];
    
    double intervalTime = [fromDate timeIntervalSinceReferenceDate] - [localeDate timeIntervalSinceReferenceDate];
    long lTime = labs((long)intervalTime);
    
    return lTime;
}

- (NSString*)getTimeAgo:(NSString*)date
{
    NSDate* tdate = [self convertDateFromString:date withFormat:nil];
    long time = [self SecondIntervalSinceNow:tdate];
//    if (time >= 60*60*24*7)
//    {
//        return date;
//    }
    
    if (time < 60)
    {
        return [NSString stringWithFormat:@"%ld秒前", time];
    }
    else if (time < 60*60)
    {
        return [NSString stringWithFormat:@"%ld分钟前", time/60];
    }
    else if (time < 60*60*24)
    {
        return [NSString stringWithFormat:@"%ld小时前", time/60/60];
    }
    else
    {
        return [NSString stringWithFormat:@"%ld天前", time/60/60/24];
    }
}

#pragma mark -
- (NSMutableDictionary*)dataFormateCache
{
    if (!_dataFormateCache) {
        _dataFormateCache = [NSMutableDictionary new];
    }
    return _dataFormateCache;
}

@end
