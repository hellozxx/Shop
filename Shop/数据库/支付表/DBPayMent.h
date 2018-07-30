//
//  DBPayMent.h
//  Shop
//
//  Created by 朱啸 on 2018/5/8.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBPayMent : NSObject

/**
 *  单例
 */
+(instancetype)sharedInstance;
/**
 *  新建数据库+新建表
 */
-(void)LinkDatabaseAndAddToQueue;
/**
 *  新增支付
 */
-(void)insetOrder_id:(NSString *)order_id WithPayType:(NSString *)paytype WithPayAccount:(NSString *)payaccount WithTotalPrice:(NSString *)totalprice;


/**
 *  查询所有数据
 *
 */
-(void)selectAllMethodWithOrder_Id:(NSString *)order_id;


@end
