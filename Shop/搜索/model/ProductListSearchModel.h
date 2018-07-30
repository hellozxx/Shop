//
//  ProductListSearchModel.h
//  Shop
//
//  Created by 朱啸 on 2018/5/4.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductListSearchModel : NSObject

@property (copy, nonatomic) NSString *product_id;
@property (copy, nonatomic) NSString *product_name;
@property (copy, nonatomic) NSString *product_iconimage;
@property (copy, nonatomic) NSString *product_categoryid;
@property (copy, nonatomic) NSString *product_price;
@property (copy, nonatomic) NSString *product_marketprice;
@property (copy, nonatomic) NSString *product_description;

@end
