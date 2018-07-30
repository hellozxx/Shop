//
//  DBOrderDetail.h
//  Shop
//
//  Created by 朱啸 on 2018/5/7.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBOrderDetail : NSObject

/**
 *  单例
 */
+(instancetype)sharedInstance;
/**
 *  新建数据库+新建表
 */
-(void)LinkDatabaseAndAddToQueue;
/**
 *  新增订单详情列表
 */
-(void)insetOrder_Id:(NSString *)order_id WithProduct_Id:(NSString *)product_id WithNumber:(NSString *)number WithReceivingAddress_Id:(NSString *)receivingaddress_id;
///**
// *  条件查询数据--查询订单总金额
// */
//-(NSString *)selectTotalPriceWithOrder_Id:(NSString *)order_id;
/**
 *  条件查询数据--查询订单中的product_id
 */
-(NSMutableArray *)selectProduct_IdWithOrder_Id:(NSString *)order_id;

/**
 *  条件查询数据--查询订单中的product_id的个数
 */
-(NSString *)selectNumberWithOrder_Id:(NSString *)order_id WithProduct_Id:(NSString *)product_id;

/**
 *  条件查询数据--查询订单中的收货地址id
 */
-(NSString *)selectReceivingAddress_IdWithOrder_Id:(NSString *)order_id;

/**
 *  更新数据--更新订单的物流单号
 */
-(void)updateStatusWithOrder_Id:(NSString *)order_id WithCourier_Id:(NSString *)courier_id;

/**
 *  条件查询数据--查询订单中的物流单号
 */
-(NSString *)selectCourier_IdWithOrder_Id:(NSString *)order_id;

/**
 *  查询所有数据
 *
 */
-(void)selectAllMethodWithOrder_Id:(NSString *) order_id;

@end
