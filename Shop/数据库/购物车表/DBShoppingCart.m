//
//  DBShoppingCart.m
//  Shop
//
//  Created by 朱啸 on 2018/5/4.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "DBShoppingCart.h"


@interface DBShoppingCart()

@property (nonatomic,strong) FMDatabaseQueue *queue;
@property (nonatomic,strong) NSMutableDictionary *params;
@property (nonatomic,strong) NSMutableArray *ArrayShoppingCart;


@property (strong, nonatomic) NSString *cart_id;
@property (strong, nonatomic) NSString *user_id;


@end

@implementation DBShoppingCart

+(instancetype)sharedInstance{
    
    static DBShoppingCart *sql = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sql = [[DBShoppingCart alloc]init];
    });
    return sql;
}


/**
 *  初始化字典
 */
-(NSMutableDictionary *)params{
    
    if (!_params) {
        _params = [NSMutableDictionary dictionary];
    }
    return _params;
}

/**
 *  初始化数组(查找全部)
 */
-(NSMutableArray *)ArrayShoppingCart{
    
    if (!_ArrayShoppingCart) {
        _ArrayShoppingCart = [NSMutableArray array];
    }
    return _ArrayShoppingCart;
}


/**
 *  新建数据库+新建表
 */
-(void)LinkDatabaseAndAddToQueue{
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    //拼接文件名
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"Shop.sqlite"];
    
    //    Log(@"数据库路径:%@",filePath);
    //创建数据库,并加入到队列中,此时已经默认打开了数据库,无须手动打开,只需要从队列中去除数据库即可
    self.queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
}



/**
 *  新增购物车
 */
-(void)insetCart_Id:(NSString *)cart_id WithUser_Id:(NSString *)user_id {
    
    if ([self isHaveCart:user_id]) {
        Log(@"新增购物车数据失败,此账户已存在购物车");
    }else {
        [self.queue inDatabase:^(FMDatabase *db) {
            [db executeUpdate:@"insert into shoppingCart (cart_id,user_id) values (?,?)",cart_id,user_id];
            Log(@"新增购物车数据成功");
        }];
    }
    
}

- (BOOL) isHaveCart:(NSString *)user_id {
    __block BOOL flag = NO;
    [self.queue inDatabase:^(FMDatabase *db) {
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from shoppingCart where user_id = ?",user_id];
        while ([rs next]) {
            if ([user_id isEqualToString:[rs stringForColumn:@"user_id"]]) {
                flag = YES;
            }
        }
    }];
    
    return flag;
}


/**
 *  条件查询数据--查询购物车id,用于商品详情页面添加商品至购物车中
 */
-(NSString *)selectWithUser_Id:(NSString *)user_id {
    
    __block NSString *cartId;
    [self.queue inDatabase:^(FMDatabase *db) {
        
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from shoppingCart where user_id = ?",user_id];
        while ([rs next]) {
            cartId = [rs stringForColumn:@"cart_id"];
        }
    }];
    return cartId;
}




/**
 *  查询所有数据
 *
 */
-(void)selectAllMethod{
    
    //每次进来查询的时候,先清除上次缓存数据
    [self.ArrayShoppingCart removeAllObjects];
    [self.queue inDatabase:^(FMDatabase *db) {
        
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from shoppingCart"];
        while ([rs next]) {
            self.cart_id = [rs stringForColumn:@"cart_id"];
            self.user_id = [rs stringForColumn:@"user_id"];
            
            //先将数据存放到字典
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:self.cart_id forKey:@"cart_id"];
            [dic setObject:self.user_id forKey:@"user_id"];
            
            //然后将字典存放到数组
            [self.ArrayShoppingCart addObject:dic];
            
        }
        
        
//        NSLog(@"存放的数组:%@==%ld",self.ArrayShoppingCart,self.ArrayShoppingCart.count);
        [[NSUserDefaults standardUserDefaults]setObject:self.ArrayShoppingCart forKey:@"ArrayShoppingCart"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }];
    
    
    
}

@end











