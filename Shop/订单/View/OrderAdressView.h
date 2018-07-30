//
//  OrderAdressView.h
//  Shop
//
//  Created by 朱啸 on 2018/5/7.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^gotoEditAdressBlock)(void);

@interface OrderAdressView : UIView

@property (strong, nonatomic) UIButton *editAdress; //修改地址

@property (strong, nonatomic) UILabel *consigneeLabel;    //收货人姓名
@property (strong, nonatomic) UILabel *addressLabel;  //地址信息
@property (strong, nonatomic) UILabel *phoneLabel;    //电话号码
@property (strong, nonatomic) UILabel *noAddressLabel;  //没有收货地址

@property (copy, nonatomic) gotoEditAdressBlock gotoEditAdress; //去编辑收货地址回调，用于编辑收货地址按钮的单击事件

@end
