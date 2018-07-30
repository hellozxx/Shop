//
//  NSString+GenerateRandomString.h
//  Shop
//
//  Created by 朱啸 on 2018/5/6.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (GenerateRandomString)

//生成随机数：number位字母+年月日时分秒，用于购物车id、订单号
+ (NSString *) characterLength:(NSInteger)number;

@end
