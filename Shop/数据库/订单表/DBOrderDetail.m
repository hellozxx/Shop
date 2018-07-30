//
//  DBOrderDetail.m
//  Shop
//
//  Created by 朱啸 on 2018/5/7.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "DBOrderDetail.h"
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"
#import "DBProductDetail.h"

@interface DBOrderDetail()

@property (nonatomic,strong) FMDatabaseQueue *queue;
@property (nonatomic,strong) NSMutableDictionary *params;
@property (nonatomic,strong) NSMutableArray *ArrayOrderdetail;


@property (strong, nonatomic) NSString *order_id;
@property (strong, nonatomic) NSString *product_id;
@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *receivingaddress_id;
@property (strong, nonatomic) NSString *courier_id;


@end

@implementation DBOrderDetail

+(instancetype)sharedInstance{
    
    static DBOrderDetail *sql = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sql = [[DBOrderDetail alloc]init];
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
-(NSMutableArray *)ArrayOrderdetail{
    
    if (!_ArrayOrderdetail) {
        _ArrayOrderdetail = [NSMutableArray array];
    }
    return _ArrayOrderdetail;
}


/**
 *  新建数据库+新建表
 */
-(void)LinkDatabaseAndAddToQueue{
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    //拼接文件名
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"Shop.sqlite"];
    //创建数据库,并加入到队列中,此时已经默认打开了数据库,无须手动打开,只需要从队列中去除数据库即可
    self.queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
}


/**
 *  新增订单详情列表
 */
-(void)insetOrder_Id:(NSString *)order_id WithProduct_Id:(NSString *)product_id WithNumber:(NSString *)number WithReceivingAddress_Id:(NSString *)receivingaddress_id {
    
//    NSString *priceString = [[DBProductDetail sharedInstance] selectPriceWithProduct_id:product_id];
//    NSInteger numberInteger = [number integerValue];
//    float pricefloat = [priceString floatValue] * numberInteger;
//    NSString *price = [NSString stringWithFormat:@"%.2lf",pricefloat];
    
    [self.queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"insert into orderDetail (order_id,product_id,number,receivingaddress_id) values (?,?,?,?)",order_id,product_id,number,receivingaddress_id];
        Log(@"新增订单详情成功");
    }];
}


///**
// *  条件查询数据--查询订单总金额
// */
//-(NSString *)selectTotalPriceWithOrder_Id:(NSString *)order_id {
//    __block NSString *totalPrice;
//    [self.queue inDatabase:^(FMDatabase *db) {
//        
//        //获取结果集,返回参数就是查询结果
//        FMResultSet *rs = [db executeQuery:@"select *from orderDetail where order_id = ?",order_id];
//        while ([rs next]) {
//            totalPrice = [rs stringForColumn:@"totalprice"];
//        }
//    }];
//    return totalPrice;
//}

/**
 *  条件查询数据--查询订单中的product_id
 */
-(NSMutableArray *)selectProduct_IdWithOrder_Id:(NSString *)order_id {
    __block NSMutableArray *productIdArray = [NSMutableArray array];
    [self.queue inDatabase:^(FMDatabase *db) {
        
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from orderDetail where order_id = ?",order_id];
        while ([rs next]) {
            //self.product_id = [rs stringForColumn:@"product_id"];
            Log(@"DBOrderDetial---product_id = %@",self.product_id);
            [productIdArray addObject:[rs stringForColumn:@"product_id"]];
        }
    }];
    return productIdArray;
}

/**
 *  条件查询数据--查询订单中的product_id的个数
 */
-(NSString *)selectNumberWithOrder_Id:(NSString *)order_id WithProduct_Id:(NSString *)product_id {
    __block NSString *number;
    [self.queue inDatabase:^(FMDatabase *db) {
        
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from orderDetail where (order_id = ? and product_id = ?)",order_id,product_id];
        while ([rs next]) {
             number = [rs stringForColumn:@"number"];
        }
    }];
    return number;
}

/**
 *  条件查询数据--查询订单中的收货地址id
 */
-(NSString *)selectReceivingAddress_IdWithOrder_Id:(NSString *)order_id {
    __block NSString *addressID;
    [self.queue inDatabase:^(FMDatabase *db) {
        
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from orderDetail where order_id = ?",order_id];
        while ([rs next]) {
            addressID = [rs stringForColumn:@"receivingaddress_id"];
        }
    }];
    return addressID;
}


/**
 *  更新数据--更新订单的物流单号
 */
-(void)updateStatusWithOrder_Id:(NSString *)order_id WithCourier_Id:(NSString *)courier_id {
    [self.queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"update orderDetail set courier_id = ? where order_id = ?",courier_id,order_id];
    }];
}

/**
 *  条件查询数据--查询订单中的物流单号
 */
-(NSString *)selectCourier_IdWithOrder_Id:(NSString *)order_id {
    __block NSString *courier;
    [self.queue inDatabase:^(FMDatabase *db) {
        
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from orderDetail where order_id = ?",order_id];
        while ([rs next]) {
            courier = [rs stringForColumn:@"courier_id"];
        }
    }];
    return courier;
}


/**
 *  查询所有数据
 *
 */
-(void)selectAllMethodWithOrder_Id:(NSString *) order_id{
    
    //每次进来查询的时候,先清除上次缓存数据
    [self.ArrayOrderdetail removeAllObjects];
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from orderDetail where order_id = ?",order_id];
        while ([rs next]) {
            self.order_id = [rs stringForColumn:@"order_id"];
            self.product_id = [rs stringForColumn:@"product_id"];
            self.number = [rs stringForColumn:@"number"];
            
            //先将数据存放到字典
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:self.order_id forKey:@"order_id"];
            [dic setObject:self.product_id forKey:@"product_id"];
            [dic setObject:self.number forKey:@"number"];
            
            //然后将字典存放到数组
            [self.ArrayOrderdetail addObject:dic];
            
        }
        
        
//        NSLog(@"存放的数组:%@==%ld",self.ArrayOrderdetail,self.ArrayOrderdetail.count);
        [[NSUserDefaults standardUserDefaults]setObject:self.ArrayOrderdetail forKey:@"ArrayOrderdetail"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }];
    
    
    
}

@end





















