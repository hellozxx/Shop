//
//  NSString+Time.m
//  Shop
//
//  Created by 朱啸 on 2018/5/11.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "NSString+Time.h"

@implementation NSString (Time)

//获取当前时间戳方法(精确到分钟)

+(NSString *)getNowTimeTimestamp{
    
    //获取当前时间日期
    NSDate *date=[NSDate date];
    NSDateFormatter *format1=[[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"yyyy-MM-dd hh:mm"];
    NSString *dateStr;
    dateStr=[format1 stringFromDate:date];
    return dateStr;
}

//获取当前时间戳方法(精确到秒)

+(NSString *)getNowTimeSSTimestamp{
    
    //获取当前时间日期
    NSDate *date=[NSDate date];
    NSDateFormatter *format1=[[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *dateStr;
    dateStr=[format1 stringFromDate:date];
    return dateStr;
}

@end
