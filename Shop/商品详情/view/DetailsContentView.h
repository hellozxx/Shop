//
//  DetailsContentView.h
//  Shop
//
//  Created by 朱啸 on 2018/5/3.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^returnContentHeightBlock)(CGFloat height);

@interface DetailsContentView : UIView
@property (strong, nonatomic) NSArray *contentArray;    //存放数据model的数组;
@property (copy, nonatomic) NSString *productID;    //传过来的productID
@property (copy, nonatomic) returnContentHeightBlock heightBlock;   //回调给viewController的值--view的高度

@end
