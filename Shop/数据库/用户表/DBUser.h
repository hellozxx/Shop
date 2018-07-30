//
//  DBAccount.h
//  Shop
//
//  Created by 朱啸 on 2018/4/16.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"

@interface DBUser : NSObject


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
-(void)insetUser_Name:(NSString *)user_name WithUser_PassWord:(NSString *)user_password WithUser_Type:(NSString *)user_type;
/**
 *  删除
 */
-(void)deleteWithUser_Name:(NSString *)user_name;
/**
 *  更新数据
 */
//-(void)updateWithNewUser_Name:(NSString *)newUser_Name WithUser_Password:(NSString *)newUser_Password WithUser_Type:(NSString *)newUser_Type;
/**
 *  条件查询数据--查询用户名,用于注册验证
 */
-(BOOL)selectWithUser_Name:(NSString *)user_name;
/**
 *  条件查询数据--查询用户名和密码,用于登录验证
 */
-(int)selectWithUser_Name:(NSString *)user_name WithUser_Password:(NSString *)user_password;

/**
 *  查询所有数据
 *
 */
-(void)selectAllMethod;

@end


