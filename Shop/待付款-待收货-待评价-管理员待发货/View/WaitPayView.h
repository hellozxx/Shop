//
//  WaitPayView.h
//  Shop
//
//  Created by 朱啸 on 2018/5/10.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaitPayTableView.h"
#import "OrderAdressView.h" //收货地址View

typedef void(^payBtnBlock)(void);
typedef void(^returnProductBlock)(void);

@interface WaitPayView : UIView

@property (strong, nonatomic) WaitPayTableView *waitPayTable;   //待付款tableview
@property (strong, nonatomic) UILabel *orderLabel;  //订单号Label
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UIButton *payButton;
@property (strong, nonatomic) OrderAdressView *addressView; //收货地址View
@property (strong, nonatomic) UILabel *courierLabel;    //快递单号Label
@property (strong, nonatomic) UIButton *afterSaleButton; //退货Button

@property (strong, nonatomic) NSString *orderID;    //接收controller传过来的订单号
@property (strong, nonatomic) payBtnBlock payButtonBlock;   //payButton的block，在controller中实现点击事件
@property (strong, nonatomic) returnProductBlock returnProductButtonBlock;  //afterSaleButton的block，在controller中实现点击事件

@property (assign, nonatomic) int cellCount;



@end
