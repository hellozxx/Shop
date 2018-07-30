//
//  WaitSendView.h
//  Shop
//
//  Created by 朱啸 on 2018/5/11.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaitSendTableView.h"

@interface WaitSendView : UIView

@property (strong, nonatomic) WaitSendTableView *waitSendTable;   //待付款tableview
@property (strong, nonatomic) UILabel *orderLabel;  //订单号Label
@property (strong, nonatomic) UILabel *priceLabel;
@property (assign, nonatomic) int cellCount;

@end
