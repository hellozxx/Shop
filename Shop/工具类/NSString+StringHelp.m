//
//  NSString+StringHelp.m
//  Shop
//
//  Created by 朱啸 on 2018/5/3.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "NSString+StringHelp.h"

@implementation NSString (StringHelp)

//Label有可能占用多行，在此取出高度
+ (CGFloat) returnLabelTextHeight:(NSString *)text width:(CGFloat)width fontSize:(UIFont *)font{
    CGSize textSize = CGSizeMake(width, MAXFLOAT);
    CGFloat height = [text boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height;
    return height;
}

@end
