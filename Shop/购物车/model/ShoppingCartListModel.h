//
//  ShoppingCartListModel.h
//  Shop
//
//  Created by 朱啸 on 2018/5/5.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCartListModel : NSObject

@property (copy,nonatomic) NSString *cart_id;
@property (copy, nonatomic) NSString *product_id;
@property (copy, nonatomic) NSString *product_iconimage;
@property (copy, nonatomic) NSString *product_name;
@property (copy, nonatomic) NSString *number;
@property (copy, nonatomic) NSString *product_price;
@property (assign, nonatomic) BOOL isSelectButton;



@end
