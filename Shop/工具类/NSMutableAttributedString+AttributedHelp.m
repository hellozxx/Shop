//
//  NSMutableAttributedString+AttributedHelp.m
//  Shop
//
//  Created by 朱啸 on 2018/5/4.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "NSMutableAttributedString+AttributedHelp.h"

@implementation NSMutableAttributedString (AttributedHelp)

//拼接价格
+ (NSMutableAttributedString *) makeListPriceText:(NSString *)nowPrice WithMarketPrice:(NSString *)marketPrice {
    //当前价格(需要手动添加人民币符号)
    NSString *presentPrice = [NSString stringWithFormat:@"￥%@ ",nowPrice];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:presentPrice
                                                                               attributes:@{NSForegroundColorAttributeName:RGB(230, 51, 37),
                                                                                            NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0]
                                                                                            }];
    
    //过去价格(需要手动添加人民币符号)
    //    NSString *oldString = [NSString stringWithFormat:@"%@ ",_singleModel.product_price];
    NSString *price = [NSString stringWithFormat:@"￥%@ ",marketPrice];
    NSMutableAttributedString *oldPrice = [[NSMutableAttributedString alloc] initWithString:price
                                                                                 attributes:@{NSForegroundColorAttributeName:RGB(132, 132, 132),
                                                                                              NSFontAttributeName:[UIFont systemFontOfSize:12.0],
                                                                                              NSStrikethroughStyleAttributeName:@(2)}];
    //把两个价格拼接一下
    [string insertAttributedString:oldPrice atIndex:string.length];
    //把拼接完成的string返回
    return string;
}

@end
