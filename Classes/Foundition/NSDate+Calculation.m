//
//  NSDate+Calculation.m
//  dev-kit-demo
//
//  Created by 张超 on 2018/5/31.
//  Copyright © 2018年 gerinn. All rights reserved.
//

#import "NSDate+Calculation.h"

@implementation NSDate (Calculation)

- (NSDate *)calculate:(NSCalendarUnit)unit value:(NSInteger)value
{
    NSCalendar* c = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    return [c dateByAddingUnit:unit value:value toDate:self options:NSCalendarMatchStrictly];
}

- (NSDate *)lunar_calculate:(NSCalendarUnit)unit value:(NSInteger)value
{
    NSCalendar* c = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    return [c dateByAddingUnit:unit value:value toDate:self options:NSCalendarMatchStrictly];
}

- (NSInteger)calculateFromDate:(NSDate *)date unit:(NSCalendarUnit)unit
{
    NSCalendar* c = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents* dc = [c components:unit fromDate:date toDate:self options:NSCalendarWrapComponents];
    return [dc valueForComponent:unit];
}

@end
