//
//  MyMessageNormalUser.h
//  Shop
//
//  Created by 朱啸 on 2018/5/8.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMessageNormalUser : UIView

@property (strong, nonatomic) UIButton *moreOrderButton;    //查看更多订单Button
@property (strong, nonatomic) UIButton *payButton;  //待付款button
@property (strong, nonatomic) UIButton *sendButton; //待发货button
@property (strong, nonatomic) UIButton *receiveButton;  //待收货button
@property (strong, nonatomic) UIButton *commentButton;  //待评价button
@property (strong, nonatomic) UIButton *afterSaleButton;    //售后button

@end
