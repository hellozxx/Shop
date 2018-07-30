//
//  DBShoppingCartDetail.h
//  Shop
//
//  Created by 朱啸 on 2018/5/4.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"

@interface DBShoppingCartDetail : NSObject
/**
 *  单例
 */
+ (instancetype) sharedInstance;
/**
 *  新建数据库+新建表
 */
- (void) LinkDatabaseAndAddToQueue;
/**
 *  新增购物车详情
 */
- (void) insetCart_Id:(NSString *)cart_id WithProduct_Id:(NSString *)product_id WithNumber:(NSString *)number;


/**
 *  条件查询数据--查询商品id,用于防止在购物车详情表内添加多个相同的商品
 */
- (BOOL) selectWithProduct_Id:(NSString *)product_id;



/**
 *  条件查询数据--查询商品id,然后修改对应的商品数量
 */
- (void) updateNumber:(NSString *)number WithProduct_Id:(NSString *)product_id;

/**
 *  删除商品
 */
- (void) deleteWithProduct_Id:(NSString *)product_id;


/**
 *  查询所有数据,根据product_id查询相关信息，用于购物车列表的的显示
 *
 */
- (void) selectAllMethod;

/**
 根据product_id查询相关信息，用于购物车列表的的显示
 */
//- (void) selectWithProduct_Id:(NSString *)product_id WithProduct_name:(NSString *)product_name WithProduct_IconImage:(NSString *)product_iconImage WithNumber:(NSString *)number WithProduct_Price:(NSString *)product_price;

@end
