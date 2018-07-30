//
//  OrderViewController.h
//  Shop
//
//  Created by 朱啸 on 2018/5/7.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderViewController : UIViewController

@property (strong, nonatomic) NSArray *orderTableData;  //订单列表
@property (assign, nonatomic) CGFloat totalPrice;   //BuyCarViewController中传过来的价格总和


@end
