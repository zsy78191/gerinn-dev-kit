//
//  NSDate+Lunar.h
//  dev-kit-demo
//
//  Created by 张超 on 2018/5/30.
//  Copyright © 2018年 gerinn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Lunar)
/**
 返回当前日期是否是中国农历闰月

 @return 是否是闰月
 */
- (BOOL)lunar_isLeapMonth;


/**
 中国农历月份，不标注闰月

 @return 月份（1-12）
 */
- (NSInteger)lunar_month;


/**
 中国农历月份的中文描述，标注闰月

 @return 中文月份 （正月-腊月）
 */
- (NSString*)lunar_month_chinese;

- (NSInteger)lunar_year;
- (NSString*)lunar_year_chinese;

- (NSInteger)lunar_day;
- (NSString*)lunar_day_chinese;

/**
 获取中国农历上个月的同一天日期

 @return 日期
 */
- (NSDate*)lunar_lastMonthSameDay;


@end


@interface NSCalendar(ChineseLunar)

/**
 中国农历

 @return 这个类别的方法都要使用中国农历调用
 */
+ (instancetype)lunarCalendar;


/**
 根据公历年份获取农历干支描述

 @param year 公历年份
 @return 农历干支描述
 */
- (NSString*)lunar_yearChineseWithGregorianYear:(NSInteger)year;


/**
 根据公历年份获取月份数组

 @param year 公历年份
 @return 月份数组，有闰月的情况下，有十三个值
 */
- (NSArray <NSNumber*>*)lunar_monthWithGregorianYear:(NSInteger)year;


/**
 根据`lunar_monthWithGregorianYear`接口返回月份，获取月份描述

 @param month 月份序号
 @param year 公历年
 @return 月份描述
 */
- (NSString*)lunar_monthChineseWithLunarMonth:(NSInteger)month gregorianYear:(NSInteger)year;


/**
 根据公历年和农历月份获取天数组

 @param year 公历年
 @param month 农历月
 @return 天数数组（29个或30个）
 */
- (NSArray <NSNumber*>*)lunar_daysWithGregorianYear:(NSInteger)year lunarMonth:(NSInteger)month;


/**
 根据`lunar_daysWithGregorianYear`接口返回的天序号，返回中文描述

 @param day 天序号
 @param useShort 是否使用缩写，`二十`缩写`廿`
 @return 中文描述
 */
- (NSString*)lunar_dayChineseWithLunarDay:(NSInteger)day shortDes:(BOOL)useShort;


/**
 根据公历年，农历月，农历日生成NSDate

 @param year 公历年
 @param month 农历月
 @param day 农历日
 @return 返回日期
 */
- (NSDate*)lunar_getDayWithGregorianYear:(NSInteger)year lunarMonth:(NSInteger)month lunarDay:(NSInteger)day;

@end
