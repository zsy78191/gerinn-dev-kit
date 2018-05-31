//
//  ViewController.m
//  dev-kit-demo
//
//  Created by 张超 on 2018/5/30.
//  Copyright © 2018年 gerinn. All rights reserved.
//

#import "ViewController.h"
#import "NSDate+Lunar.h"
#import "NSDate+Calculation.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSDateFormatter* f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy-MM-dd"];
    NSDate* d = [f dateFromString:@"2017-07-23"];
    NSLog(@"%@",d);
    NSLog(@"%@",[d lunar_lastMonthSameDay]);
    NSLog(@"%@",[d lunar_month_chinese]);
//    [d test];
    
    NSDate* d2 = [f dateFromString:@"2017-06-24"];
    NSLog(@"%@",d2);
    NSLog(@"%@",@([d2 lunar_isLeapMonth]));
//    [d2 test];
    
    NSLog(@"%@",[[NSCalendar lunarCalendar] lunar_yearChineseWithGregorianYear:2018]);
//    NSLog(@"%@",[[NSCalendar lunarCalendar] lunar_monthWithGregorianYear:2017]);
    NSLog(@"%@",[[NSCalendar lunarCalendar] lunar_monthChineseWithLunarMonth:7 gregorianYear:2017]);
    
    NSLog(@"%@",[[NSCalendar lunarCalendar] lunar_daysWithGregorianYear:2017 lunarMonth:6]);
    
    NSLog(@"%@",[[NSCalendar lunarCalendar] lunar_dayChineseWithLunarDay:24 shortDes:YES]);
    
    NSLog(@"%@",[[NSCalendar lunarCalendar] lunar_getDayWithGregorianYear:1989 lunarMonth:8 lunarDay:8]);
    
    NSDate* d3 = [NSDate date];
    NSLog(@"%@ %@ %@",[d3 lunar_year_chinese],[d3 lunar_month_chinese],[d3 lunar_day_chinese]);
    
    NSLog(@"%@",[f stringFromDate:[d3 calculate:NSCalendarUnitWeekOfYear value:1]]);
    NSLog(@"%@",[f stringFromDate:[d3 lunar_calculate:NSCalendarUnitMonth value:1]]);
    
    NSLog(@"%@",@([[f dateFromString:@"2018-05-31"] calculateFromDate:[f dateFromString:@"2018-11-12"] unit:NSCalendarUnitWeekday]));
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
