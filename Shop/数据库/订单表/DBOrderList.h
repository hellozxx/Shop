//
//  DBOrderList.h
//  Shop
//
//  Created by 朱啸 on 2018/5/7.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBOrderList : NSObject
/**
 *  单例
 */
+(instancetype)sharedInstance;
/**
 *  新建数据库+新建表
 */
-(void)LinkDatabaseAndAddToQueue;
/**
 *  新增订单列表
 */
-(void)insetWithUser_Id:(NSString *)user_id WithTotalPrice:(NSString *)totalprice WithStatus:(NSString *)status;
/**
 *  条件查询数据--查询订单id
 */
-(NSString *)selectOrder_IDWithUser_Id:(NSString *)user_id;

/**
 *  条件查询数据--查询订单总金额
 */
-(NSString *)selectTotalPriceWithOrder_Id:(NSString *)order_id;

/**
 *  更新数据--更新订单状态
 */
-(void)updateStatusWithOrder_Id:(NSString *)order_id WithStaus:(NSString *)status;

/**
 *  条件查询数据--查询订单状态
 */
-(void)selectStatusWithStatus:(NSString *)status;


/**
 *  查询所有数据
 *
 */
-(void)selectAllMethod;

@end
