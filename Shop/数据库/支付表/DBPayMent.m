//
//  DBPayMent.m
//  Shop
//
//  Created by 朱啸 on 2018/5/8.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "DBPayMent.h"
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"
#import "NSString+GenerateRandomString.h"

@interface DBPayMent()

@property (nonatomic,strong) FMDatabaseQueue *queue;
@property (nonatomic,strong) NSMutableDictionary *params;
@property (nonatomic,strong) NSMutableArray *ArrayPayMent;


@property (strong, nonatomic) NSString *payment_id;
@property (strong, nonatomic) NSString *order_id;
@property (strong, nonatomic) NSString *paytype;
@property (strong, nonatomic) NSString *payaccount;
@property (strong, nonatomic) NSString *totalprice;
@property (strong, nonatomic) NSString *paytime;


@end

@implementation DBPayMent

+(instancetype)sharedInstance{
    
    static DBPayMent *sql = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sql = [[DBPayMent alloc]init];
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
-(NSMutableArray *)ArrayPayMent{
    
    if (!_ArrayPayMent) {
        _ArrayPayMent = [NSMutableArray array];
    }
    return _ArrayPayMent;
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
 *  新增支付
 */
-(void)insetOrder_id:(NSString *)order_id WithPayType:(NSString *)paytype WithPayAccount:(NSString *)payaccount WithTotalPrice:(NSString *)totalprice {
    self.payment_id = [NSString characterLength:8];
    self.paytime = [NSString characterLength:0];
    [self.queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"insert into payMent (payment_id,order_id,paytype,payaccount,totalprice,paytime) values (?,?,?,?,?,?)",self.payment_id,order_id,paytype,payaccount,totalprice,self.paytime];
        Log(@"新支付数据成功");
    }];
}

/**
 *  查询所有数据
 *
 */
-(void)selectAllMethodWithOrder_Id:(NSString *)order_id{
    
    //每次进来查询的时候,先清除上次缓存数据
    [self.ArrayPayMent removeAllObjects];
    [self.queue inDatabase:^(FMDatabase *db) {
        
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from payMent where order_id = ?",order_id];
        while ([rs next]) {
            self.payment_id = [rs stringForColumn:@"payment_id"];
            self.order_id = [rs stringForColumn:@"order_id"];
            self.paytype = [rs stringForColumn:@"paytype"];
            self.payaccount = [rs stringForColumn:@"payaccount"];
            self.totalprice = [rs stringForColumn:@"totalprice"];
            self.paytime = [rs stringForColumn:@"paytime"];
            
            //先将数据存放到字典
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:self.payment_id forKey:@"payment_id"];
            [dic setObject:self.order_id forKey:@"order_id"];
            [dic setObject:self.paytype forKey:@"paytype"];
            [dic setObject:self.payaccount forKey:@"payaccount"];
            [dic setObject:self.totalprice forKey:@"totalprice"];
            [dic setObject:self.paytime forKey:@"paytime"];
            
            //然后将字典存放到数组
            [self.ArrayPayMent addObject:dic];
            
        }
        
        
//        NSLog(@"存放的数组:%@==%ld",self.ArrayPayMent,self.ArrayPayMent.count);
        [[NSUserDefaults standardUserDefaults]setObject:self.ArrayPayMent forKey:@"ArrayPayMent"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }];
    
    
    
}


@end
