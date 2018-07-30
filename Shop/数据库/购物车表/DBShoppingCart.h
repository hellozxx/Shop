//
//  DBShoppingCart.h
//  Shop
//
//  Created by 朱啸 on 2018/5/4.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"

@interface DBShoppingCart : NSObject
/**
 *  单例
 */
+(instancetype)sharedInstance;
/**
 *  新建数据库+新建表
 */
-(void)LinkDatabaseAndAddToQueue;
/**
 *  新增购物车
 */
-(void)insetCart_Id:(NSString *)cart_id WithUser_Id:(NSString *)user_id;


/**
 *  条件查询数据--查询购物车id,用于商品详情页面添加商品至购物车中
 */
-(NSString *)selectWithUser_Id:(NSString *)user_id;


/**
 *  查询所有数据
 *
 */
-(void)selectAllMethod;

@end
