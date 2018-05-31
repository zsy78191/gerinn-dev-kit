//
//  NSDate+Lunar.m
//  dev-kit-demo
//
//  Created by 张超 on 2018/5/30.
//  Copyright © 2018年 gerinn. All rights reserved.
//

#import "NSDate+Lunar.h"

@interface Lunar : NSObject
+ (instancetype)instance;
@property (nonatomic, strong, readonly) NSArray* CelestialStem;
@property (nonatomic, strong, readonly) NSArray* EarthlyBranches;
@property (nonatomic, strong, readonly) NSArray* CE;
@property (nonatomic, strong, readonly) NSArray* Month;
@property (nonatomic, strong, readonly) NSArray* Day;
@property (nonatomic, strong) NSCalendar* chineseLunarCalendar;
- (NSString*)CEAtIndex:(NSInteger)idx;
- (NSString *)dayAtIndex:(NSInteger)idx;
@end

@implementation Lunar
@synthesize CelestialStem = _CelestialStem;
@synthesize EarthlyBranches = _EarthlyBranches;
@synthesize CE = _CE;
@synthesize Month = _Month;
@synthesize Day = _Day;
+ (instancetype)instance
{
    static Lunar* _g_instance_lunar;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _g_instance_lunar = [[[self class] alloc] init];
    });
    return _g_instance_lunar;
}
- (NSCalendar *)chineseLunarCalendar
{
    if (!_chineseLunarCalendar) {
        _chineseLunarCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    }
    return _chineseLunarCalendar;
}
- (NSArray *)CelestialStem
{
    if (!_CelestialStem) {
        _CelestialStem = @[@"甲",@"乙",@"丙",@"丁",@"戊",@"己",@"庚",@"辛",@"壬",@"癸"];
    }
    return _CelestialStem;
}
- (NSArray *)EarthlyBranches
{
    if (!_EarthlyBranches) {
        _EarthlyBranches = @[@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥"];
    }
    return _EarthlyBranches;
}
- (NSArray *)Month
{
    if (!_Month) {
        _Month = @[@"正月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"冬月",@"腊月"];
    }
    return _Month;
}
- (NSArray *)Day
{
    if (!_Day) {
        _Day = @[@"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",@"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十",@"二十一",@"二十二",@"二十三",@"二十四",@"二十五",@"二十六",@"二十七",@"二十八",@"二十九",@"三十"];
    }
    return _Day;
}
- (NSArray *)CE
{
    if (!_CE) {
        NSMutableArray* m = [[NSMutableArray alloc] initWithCapacity:60];
        for (int i = 0; i < 60; i ++) {
            NSInteger dc = i%10;
            NSInteger de = i%12;
            [m addObject:[self.CelestialStem[dc] stringByAppendingString:self.EarthlyBranches[de]]];
        }
        _CE = [m copy];
    }
    return _CE;
}
- (NSString *)CEAtIndex:(NSInteger)idx
{
    if (idx <= 0 || idx > 60) {
        return @"";
    }
    return self.CE[idx-1];
}
- (NSString *)monthAtIndex:(NSInteger)idx
{
    if (idx <= 0 || idx > 12) {
        return @"";
    }
    return self.Month[idx-1];
}
- (NSString *)dayAtIndex:(NSInteger)idx
{
    if (idx<=0 || idx > 30) {
        return @"";
    }
    return self.Day[idx-1];
}
@end

@implementation NSDate (Lunar)

- (void)test {
    NSCalendar* c = [Lunar instance].chineseLunarCalendar;
    NSInteger era;
    NSInteger year;
    NSInteger month;
    NSInteger day;
    [c getEra:&era year:&year month:&month day:&day fromDate:self];
    NSLog(@"%@ %@ %@ %@",@(era),@(year),@(month),@(day));
}

- (NSDate *)lunar_lastMonthSameDay
{
    NSCalendar* c = [Lunar instance].chineseLunarCalendar;
    return [c dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:self options:NSCalendarMatchStrictly];
}

- (NSInteger)lunar_month
{
    NSCalendar* c = [Lunar instance].chineseLunarCalendar;
    return [c component:NSCalendarUnitMonth fromDate:self];
}

- (BOOL)lunar_isLeapMonth
{
    NSDate * d = [self lunar_lastMonthSameDay];
    return [d lunar_month] == [self lunar_month];
}

- (NSString *)lunar_month_chinese
{
    NSString* lunar = [[Lunar instance] monthAtIndex:[self lunar_month]];
    if ([self lunar_isLeapMonth]) {
        return [@"闰" stringByAppendingString:lunar];
    }
    return lunar;
}

- (NSInteger)lunar_year
{
    NSCalendar* c = [Lunar instance].chineseLunarCalendar;
    return [c component:NSCalendarUnitYear fromDate:self];
}

- (NSInteger)lunar_day
{
    NSCalendar* c = [Lunar instance].chineseLunarCalendar;
    return [c component:NSCalendarUnitDay fromDate:self];
}

- (NSString *)lunar_year_chinese
{
    return [[Lunar instance] CEAtIndex:[self lunar_year]];
}

- (NSString *)lunar_day_chinese
{
    return [[Lunar instance] dayAtIndex:[self lunar_day]];
}

@end


@implementation NSCalendar(ChineseLunar)

+ (instancetype)lunarCalendar
{
    return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
}

- (NSString *)lunar_yearChineseWithGregorianYear:(NSInteger)year
{
    NSAssert([self.calendarIdentifier isEqualToString:NSCalendarIdentifierChinese], @"luner need chinese canlander");
    NSInteger d = (year + 2697)%60;
    if (d < 0) {
        d = d + 60;
    }
    return [[Lunar instance] CEAtIndex:d];
}

- (NSDate*)lunar_firstDayWithGreorianYear:(NSInteger)year
{
    NSAssert([self.calendarIdentifier isEqualToString:NSCalendarIdentifierChinese], @"luner need chinese canlander");
    NSDateComponents* d = [[NSDateComponents alloc] init];
    [d setCalendar:self];
    [d setEra:(year + 2697)/60];
    [d setYear:(year + 2697)%60];
    [d setMonth:1];
    [d setDay:1];
    NSDate* date = [self dateFromComponents:d];
    return date;
}

- (NSArray<NSNumber *> *)lunar_monthWithGregorianYear:(NSInteger)year
{
    NSAssert([self.calendarIdentifier isEqualToString:NSCalendarIdentifierChinese], @"luner need chinese canlander");
    NSDate* firstDay = [self lunar_firstDayWithGreorianYear:year];
    NSDate* nextFirstDay = [self dateByAddingUnit:NSCalendarUnitYear value:1 toDate:firstDay options:NSCalendarMatchStrictly];
    NSDateComponents* c = [self components:NSCalendarUnitMonth fromDate:firstDay toDate:nextFirstDay options:NSCalendarMatchStrictly];
    NSMutableArray* a = [[NSMutableArray alloc] initWithCapacity:15];
    for (int i = 0; i < c.month; i ++) {
        [a addObject:@(i+1)];
    }
    return [a copy];
}

- (NSString *)lunar_monthChineseWithLunarMonth:(NSInteger)month gregorianYear:(NSInteger)year
{
    NSAssert([self.calendarIdentifier isEqualToString:NSCalendarIdentifierChinese], @"luner need chinese canlander");
    if (month <= 0) {
        month = 1;
    }
    if (month > 13) {
        month = 13;
    }
    NSDate* firstDay = [self lunar_firstDayWithGreorianYear:year];
    NSDate* nextMonthDay = [self dateByAddingUnit:NSCalendarUnitMonth value:month-1 toDate:firstDay options:NSCalendarMatchStrictly];
    NSLog(@"%@",nextMonthDay.lunar_month_chinese);
    return nil;
}

- (NSArray<NSNumber *> *)lunar_daysWithGregorianYear:(NSInteger)year lunarMonth:(NSInteger)month
{
    NSAssert([self.calendarIdentifier isEqualToString:NSCalendarIdentifierChinese], @"luner need chinese canlander");
    NSDate* firstDay = [self lunar_firstDayWithGreorianYear:year];
    NSDate* nextMonthFirstDay = [self dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:firstDay options:NSCalendarMatchStrictly];
    NSDateComponents* c = [self components:NSCalendarUnitDay fromDate:firstDay toDate:nextMonthFirstDay options:NSCalendarMatchStrictly];
    NSMutableArray* a = [[NSMutableArray alloc] initWithCapacity:15];
    for (int i = 0; i < c.day; i ++) {
        [a addObject:@(i+1)];
    }
    return [a copy];
}

- (NSString *)lunar_dayChineseWithLunarDay:(NSInteger)day shortDes:(BOOL)useShort
{
    NSAssert([self.calendarIdentifier isEqualToString:NSCalendarIdentifierChinese], @"luner need chinese canlander");
    NSString* d = [[Lunar instance] dayAtIndex:day];
    if (useShort) {
        d = [d stringByReplacingOccurrencesOfString:@"二十" withString:@"廿"];
    }
    return d;
}

- (NSDate *)lunar_getDayWithGregorianYear:(NSInteger)year lunarMonth:(NSInteger)month lunarDay:(NSInteger)day
{
    NSAssert([self.calendarIdentifier isEqualToString:NSCalendarIdentifierChinese], @"luner need chinese canlander");
    NSDate* firstDay = [self lunar_firstDayWithGreorianYear:year];
    NSDate* nextFirstDay = [self dateByAddingUnit:NSCalendarUnitMonth value:month-1 toDate:firstDay options:NSCalendarMatchStrictly];
    return [self dateByAddingUnit:NSCalendarUnitDay value:day-1 toDate:nextFirstDay options:NSCalendarMatchStrictly];
}
@end
