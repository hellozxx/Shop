//
//  DBProductDetail.h
//  Shop
//
//  Created by 朱啸 on 2018/4/26.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"

@interface DBProductDetail : NSObject
/**
 *  单例
 */
+(instancetype)sharedInstance;
/**
 *  新建数据库+新建表
 */
-(void)LinkDatabaseAndAddToQueue;
/**
 *  新增商品详情
 */
-(void)insetProduct_Id:(NSString *)product_id WithBrand:(NSString *)brand WithTitle:(NSString *)title WithPrice:(NSString *)price WithMarketPrice:(NSString *)marketprice WithPlace:(NSString *)place WithModel:(NSString *)model WithCategory:(NSString *)category WithAge:(NSString *)age WithTopImage1:(NSString *)topImage1 WithTopImage2:(NSString *)topImage2 WithTopImage3:(NSString *)topImage3 WithTopImage4:(NSString *)topImage4 WithDetailImage1:(NSString *)detailImage1 WithDetailImage2:(NSString *)detailImage2 WithDetailImage3:(NSString *)detailImage3 WithDetailImage4:(NSString *)detailImage4;


/**
 *  条件查询数据--查询商品id,用于放置添加相同的商品
 */
-(BOOL)selectWithProduct_id:(NSString *)product_id;

/**
 *  条件查询数据--查询商品价格,用于订单结算
 */
-(NSString *)selectPriceWithProduct_id:(NSString *)product_id;

/**
 *  删除
 */
-(void)deleteWithProduct_Id:(NSString *)product_id;

/**
 *  更新数据
 */
-(void)updateWithProduct_Id:(NSString *)product_id WithBrand:(NSString *)brand WithTitle:(NSString *)title WithPrice:(NSString *)price WithMarketPrice:(NSString *)marketprice WithPlace:(NSString *)place WithModel:(NSString *)model WithCategory:(NSString *)category WithAge:(NSString *)age WithTopImage1:(NSString *)topImage1 WithTopImage2:(NSString *)topImage2 WithTopImage3:(NSString *)topImage3 WithTopImage4:(NSString *)topImage4 WithDetailImage1:(NSString *)detailImage1 WithDetailImage2:(NSString *)detailImage2 WithDetailImage3:(NSString *)detailImage3 WithDetailImage4:(NSString *)detailImage4;

/**
 *  查询所有数据
 *
 */
-(void)selectAllMethod;

@end
