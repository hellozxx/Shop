//
//  DBProduct.h
//  Shop
//
//  Created by 朱啸 on 2018/4/23.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"


@interface DBProduct : NSObject

/**
 *  单例
 */
+(instancetype)sharedInstance;
/**
 *  新建数据库+新建表
 */
-(void)LinkDatabaseAndAddToQueue;
/**
 *  新增用户账号
 */
-(void)insetProduct_Id:(NSString *)product_id WithProduct_Name:(NSString *)product_name WithProduct_IconImage:(NSString *)product_iconimage WithProduct_CategoryID:(NSString *)product_categoryid WithProduct_Price:(NSString *)product_price WithProduct_MarketPrice:(NSString *)product_marketprice WithProduct_Description:(NSString *)product_description;

/**
 *  更新数据
 */
-(void)updateWithProduct_Id:(NSString *)product_id WithName:(NSString *)name WithIconImage:(NSString *)iconimage WithCategoryId:(NSString *)categoryid WithPrice:(NSString *)price WithMarketPrice:(NSString *)marketprice WithDescription:(NSString *)description;
/**
 *  条件查询数据--查询商品id,用于放置添加相同的商品
 */
-(BOOL)selectWithProduct_id:(NSString *)product_id;


/**
 *  条件查询数据--查询商品名称，用于搜索
 */
-(BOOL)selectWithProduct_Name:(NSString *)product_name;

/**
 *  条件查询数据--查询商品种类，用于分类显示
 */
-(BOOL)selectWithProduct_CategoryId:(NSString *)product_categoryid;



/**
 *  条件查询数据--查询商品名称
 */
-(NSString *)selectProduct_NameWithProduct_Id:(NSString *)product_id;

/**
 *  条件查询数据--查询商品图片
 */
-(NSString *)selectProduct_IconImageWithProduct_Id:(NSString *)product_id;

/**
 *  条件查询数据--查询商品价格
 */
-(NSString *)selectPriceWithProduct_Id:(NSString *)product_id;

/**
 *  删除
 */
-(void)deleteWithProduct_Id:(NSString *)product_id;

/**
 *  查询所有数据
 *
 */
-(void)selectAllMethod;

@end
