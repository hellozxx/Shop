//
//  DBAddress.h
//  Shop
//
//  Created by 朱啸 on 2018/5/7.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBAddress : NSObject

/**
 *  单例
 */
+(instancetype)sharedInstance;
/**
 *  新建数据库+新建表
 */
-(void)LinkDatabaseAndAddToQueue;
/**
 *  新增地址
 */
-(void)insetAddress_Id:(NSString *)address_id WithUser_Id:(NSString *)user_id WithAddress:(NSString *)address WithConsignee:(NSString *)consignee WithPhoneNumber:(NSString *)phonenumber;
/**
 *  删除收货地址
 */
- (void) deleteWithAddress_id:(NSString *)address_id;

/**
 *  查询所有数据
 *
 */
-(void)selectAllMethod;

@end
