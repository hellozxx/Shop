//
//  NSString+Time.h
//  Shop
//
//  Created by 朱啸 on 2018/5/11.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Time)

//获取当前时间戳方法(精确到分钟)

+(NSString *)getNowTimeTimestamp;

//获取当前时间戳方法(精确到秒)

+(NSString *)getNowTimeSSTimestamp;

@end
