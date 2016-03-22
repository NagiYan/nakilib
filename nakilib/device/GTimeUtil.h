//
//  GTimeUtil.h
//  Nagi
//
//  Created by Nagi on 15-3-6.
//  Copyright (c) 2015年 Nagi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingletonARC.h"

@interface GTimeUtil : NSObject
DEFINE_SINGLETON_ARC(GTimeUtil);

// 是否是今天
- (BOOL)isToday:(int)year dateMonth:(int)month dateDay:(int)day;

// 现在多大了
- (NSInteger)howOldNow:(int)year dateMonth:(int)month dateDay:(int)day;

// 获取当前日期
- (NSString*)getCurDateString;

// 获取当前时间
- (NSString*)getCurDateTimeString;

// 设置闹铃
- (void)updateAlarm:(BOOL)on at:(int)hour minute:(int)minute repeat:(int)repeat withStr:(NSString*)strBody;

// 字符串转日期
- (NSDate*)convertDateFromString:(NSString*)uiDate withFormat:(NSString*)format;

// 日期转字符串
- (NSString*)NSDateToString:(NSDate*)date withFomart:(NSString*)fomart;

// 某日的年龄
- (NSInteger)ageAtDate:(NSDate*)date withBirthYear:(int)year month:(int)month day:(int)day;

// 某日至今有多久
- (NSString *)intervalSinceNow:(NSDate *)fromdate;

// 某个时间到现在有多少秒
- (long)SecondIntervalSinceNow:(NSDate *)fromdate;

// 多久之前
- (NSString*)getTimeAgo:(NSString*)date;
@end
