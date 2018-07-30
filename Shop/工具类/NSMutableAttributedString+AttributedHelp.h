//
//  NSMutableAttributedString+AttributedHelp.h
//  Shop
//
//  Created by 朱啸 on 2018/5/4.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (AttributedHelp)

//拼接价格
+ (NSMutableAttributedString *) makeListPriceText:(NSString *)nowPrice WithMarketPrice:(NSString *)marketPrice;

@end
