//
//  ManagerView.h
//  Shop
//
//  Created by 朱啸 on 2018/5/12.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManagerView : UIView

@property (strong, nonatomic) UIButton *moreOrderButton;    //查看更多订单Button
@property (strong, nonatomic) UIButton *addProductButton;  //增加商品button
@property (strong, nonatomic) UIButton *deleteProductButton;  //删除商品button
@property (strong, nonatomic) UIButton *updateProductButton;  //更新商品button
@property (strong, nonatomic) UIButton *sendButton; //待发货button
@property (strong, nonatomic) UIButton *afterSaleButton;    //售后Button
@property (strong, nonatomic) UIButton *addForumButton; //增加帖子Button

@end
