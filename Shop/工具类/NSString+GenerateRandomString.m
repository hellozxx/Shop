//
//  NSString+GenerateRandomString.m
//  Shop
//
//  Created by 朱啸 on 2018/5/6.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "NSString+GenerateRandomString.h"

@implementation NSString (GenerateRandomString)

+ (NSString *) characterLength:(NSInteger)number {
    char data[number];
    
    for (int x=0;x < number;data[x++] = (char)('A' + (arc4random_uniform(26))));
    
    NSString *randomStr = [[NSString alloc] initWithBytes:data length:number encoding:NSUTF8StringEncoding];
    
    
    NSString *string = [NSString stringWithFormat:@"%@",randomStr];
    
    
    //    Log(@"获取随机字符串 %@",string);
    
    NSDate *date = [NSDate date];//这个是NSDate类型的日期，所要获取的年月日都放在这里；
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;//这句是说你要获取日期的元素有哪些。获取年就要写NSYearCalendarUnit，获取小时就要写NSHourCalendarUnit，中间用|隔开；
    
    NSDateComponents *d = [cal components:unitFlags fromDate:date];//把要从date中获取的unitFlags标示的日期元素存放在NSDateComponents类型的d里面；
    //然后就可以从d中获取具体的年月日了；
    NSInteger year = [d year];
    NSInteger month = [d month];
    NSInteger day  =  [d day];
    NSInteger hour = [d hour];
    NSInteger minute = [d minute];
    NSInteger second = [d second];
    //    Log(@"year:%ld,month:%ld,day:%ld,hour:%ld,minute:%ld,second:%ld",(long)year,(long)month,(long)day,(long)hour,(long)minute,(long)second);
    
    NSString *stringCode = [NSString stringWithFormat:@"%@%ld%ld%ld%ld%ld",string,(long)year,(long)month,(long)day,(long)hour,(long)minute,(long)second];
    Log(@"%@",stringCode);
    return stringCode;
}

@end
