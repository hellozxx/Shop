//
//  DBOrderList.m
//  Shop
//
//  Created by 朱啸 on 2018/5/7.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "DBOrderList.h"
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"
#import "NSString+GenerateRandomString.h"
#import "DBOrderDetail.h"
#import "DBProductDetail.h"
#import "NSString+Time.h"

@interface DBOrderList()

@property (nonatomic,strong) FMDatabaseQueue *queue;
@property (nonatomic,strong) NSMutableDictionary *params;
@property (nonatomic,strong) NSMutableArray *ArrayOrderList;
@property (nonatomic,strong) NSMutableArray *ArrayUserOrderList;
@property (nonatomic,strong) NSMutableArray *ArrayWaitPayList;
@property (nonatomic,strong) NSMutableArray *ArrayWaitSendList;
@property (nonatomic,strong) NSMutableArray *ArrayWaitReceiceList;
@property (nonatomic,strong) NSMutableArray *ArrayWaitCommentList;
@property (nonatomic,strong) NSMutableArray *ArrayAfterSaleList;
@property (nonatomic,strong) NSMutableArray *ArrayWaitReturnProductList;
@property (nonatomic,strong) NSMutableArray *ArrayManagerWaitSendList;



@property (strong, nonatomic) NSString *order_id;
@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic) NSString *status;


@end

@implementation DBOrderList

+(instancetype)sharedInstance{
    
    static DBOrderList *sql = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sql = [[DBOrderList alloc]init];
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
 *  初始化数组(查找全部)--管理员
 */
-(NSMutableArray *)ArrayOrderList{
    
    if (!_ArrayOrderList) {
        _ArrayOrderList = [NSMutableArray array];
    }
    return _ArrayOrderList;
}

/**
 *  初始化数组(查找全部)--普通用户
 */
-(NSMutableArray *)ArrayUserOrderList{
    
    if (!_ArrayUserOrderList) {
        _ArrayUserOrderList = [NSMutableArray array];
    }
    return _ArrayUserOrderList;
}

-(NSMutableArray *)ArrayWaitPayList{
    
    if (!_ArrayWaitPayList) {
        _ArrayWaitPayList = [NSMutableArray array];
    }
    return _ArrayWaitPayList;
}

-(NSMutableArray *)ArrayWaitSendList{
    
    if (!_ArrayWaitSendList) {
        _ArrayWaitSendList = [NSMutableArray array];
    }
    return _ArrayWaitSendList;
}

-(NSMutableArray *)ArrayWaitReceiceList{
    
    if (!_ArrayWaitReceiceList) {
        _ArrayWaitReceiceList = [NSMutableArray array];
    }
    return _ArrayWaitReceiceList;
}

-(NSMutableArray *)ArrayWaitCommentList{
    
    if (!_ArrayWaitCommentList) {
        _ArrayWaitCommentList = [NSMutableArray array];
    }
    return _ArrayWaitCommentList;
}

-(NSMutableArray *)ArrayAfterSaleList{
    
    if (!_ArrayAfterSaleList) {
        _ArrayAfterSaleList = [NSMutableArray array];
    }
    return _ArrayAfterSaleList;
}

-(NSMutableArray *)ArrayWaitReturnProductList{
    
    if (!_ArrayWaitReturnProductList) {
        _ArrayWaitReturnProductList = [NSMutableArray array];
    }
    return _ArrayWaitReturnProductList;
}

-(NSMutableArray *)ArrayManagerWaitSendList{
    
    if (!_ArrayManagerWaitSendList) {
        _ArrayManagerWaitSendList = [NSMutableArray array];
    }
    return _ArrayManagerWaitSendList;
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
 *  新增订单列表
 */
-(void)insetWithUser_Id:(NSString *)user_id WithTotalPrice:(NSString *)totalprice WithStatus:(NSString *)status {
    self.order_id = [NSString characterLength:8];
    [self.queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"insert into orderList (order_id,user_id,totalprice,status,ordertime) values (?,?,?,?,?)",self.order_id,user_id,totalprice,status,[NSString getNowTimeSSTimestamp]];
    }];
}


/**
 *  条件查询数据--查询订单id
 */
-(NSString *)selectOrder_IDWithUser_Id:(NSString *)user_id {
    __block NSString *orderId;
    [self.queue inDatabase:^(FMDatabase *db) {
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from orderList where user_id = ?",user_id];
        while ([rs next]) {
            orderId = [rs stringForColumn:@"order_id"];
        }
    }];
    return orderId;
}

/**
 *  条件查询数据--查询订单状态
 */
-(void)selectStatusWithStatus:(NSString *)status {
    
    //使用这个方法之前，先清空上次缓存的数据
    [self.ArrayWaitPayList removeAllObjects];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ArrayWaitPayList"];
    [self.ArrayWaitSendList removeAllObjects];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ArrayWaitSendList"];
    [self.ArrayWaitReceiceList removeAllObjects];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ArrayWaitReceiceList"];
    [self.ArrayWaitCommentList removeAllObjects];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ArrayWaitCommentList"];
    [self.ArrayAfterSaleList removeAllObjects];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ArrayAfterSaleList"];
    [self.ArrayWaitReturnProductList removeAllObjects];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ArrayWaitReturnProductList"];
    [self.ArrayManagerWaitSendList removeAllObjects];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ArrayManagerWaitSendList"];
    
    self.user_id =  [[[[NSUserDefaults standardUserDefaults] valueForKey:@"isLoginArray"] objectAtIndex:0] valueForKey:@"user_name"];
    [self.queue inDatabase:^(FMDatabase *db) {
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from orderList where (user_id = ? and status = ?)",self.user_id,status];
        while ([rs next]) {
            self.order_id = [rs stringForColumn:@"order_id"];
            self.user_id = [rs stringForColumn:@"user_id"];
            self.status = [rs stringForColumn:@"status"];
            
            //先将数据存放到字典
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:self.order_id forKey:@"order_id"];
            [dic setObject:self.user_id forKey:@"user_id"];
            [dic setObject:self.status forKey:@"status"];
            
            //然后将字典存放到数组
            if ([status isEqualToString:@"待付款"]) {
                [self.ArrayWaitPayList addObject:dic];
            }else if ([status isEqualToString:@"待发货"]) {
                [self.ArrayWaitSendList addObject:dic];
            }else if ([status isEqualToString:@"待收货"]) {
                [self.ArrayWaitReceiceList addObject:dic];
            }else if ([status isEqualToString:@"待评价"]) {
                [self.ArrayWaitCommentList addObject:dic];
            }else if ([status isEqualToString:@"待退货"]) {
                [self.ArrayWaitReturnProductList addObject:dic];
            }
        }
    }];
    
    
    [self.queue inDatabase:^(FMDatabase *db) {
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from orderList where status = ?",status];
        while ([rs next]) {
            self.order_id = [rs stringForColumn:@"order_id"];
            self.user_id = [rs stringForColumn:@"user_id"];
            self.status = [rs stringForColumn:@"status"];
            //先将数据存放到字典
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:self.order_id forKey:@"order_id"];
            [dic setObject:self.user_id forKey:@"user_id"];
            [dic setObject:self.status forKey:@"status"];
            //然后将字典存放到数组
            if ([status isEqualToString:@"待发货"]) {
                [self.ArrayManagerWaitSendList addObject:dic];
            }else if ([status isEqualToString:@"退货申请已提交，等待管理员审核"]) {
                [self.ArrayAfterSaleList addObject:dic];
            }
        }
    }];
    
    [[NSUserDefaults standardUserDefaults]setObject:self.ArrayWaitPayList forKey:@"ArrayWaitPayList"];
    [[NSUserDefaults standardUserDefaults]setObject:self.ArrayWaitSendList forKey:@"ArrayWaitSendList"];
    [[NSUserDefaults standardUserDefaults]setObject:self.ArrayWaitReceiceList forKey:@"ArrayWaitReceiceList"];
    [[NSUserDefaults standardUserDefaults]setObject:self.ArrayWaitCommentList forKey:@"ArrayWaitCommentList"];
    [[NSUserDefaults standardUserDefaults]setObject:self.ArrayAfterSaleList forKey:@"ArrayAfterSaleList"];
    [[NSUserDefaults standardUserDefaults]setObject:self.ArrayWaitReturnProductList forKey:@"ArrayWaitReturnProductList"];
    [[NSUserDefaults standardUserDefaults]setObject:self.ArrayManagerWaitSendList forKey:@"ArrayManagerWaitSendList"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

/**
 *  条件查询数据--查询订单总金额
 */
-(NSString *)selectTotalPriceWithOrder_Id:(NSString *)order_id {
    __block NSString *totalPrice;
    [self.queue inDatabase:^(FMDatabase *db) {
        
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from orderList where order_id = ?",order_id];
        while ([rs next]) {
            totalPrice = [rs stringForColumn:@"totalprice"];
        }
    }];
    return totalPrice;
}

/**
 *  更新数据--更新订单状态
 */
-(void)updateStatusWithOrder_Id:(NSString *)order_id WithStaus:(NSString *)status {
    [self.queue inDatabase:^(FMDatabase *db) {
    
        BOOL flag = [db executeUpdate:@"update orderList set status = ? where order_id = ?",status,order_id];
        if (flag) {
            Log(@"更新订单状态成功");
        }
        else{
            Log(@"更新订单状态失败");
        }
    }];
}


/**
 *  查询所有数据
 *
 */
-(void)selectAllMethod{
    
    self.user_id = [[[[NSUserDefaults standardUserDefaults] valueForKey:@"isLoginArray"] objectAtIndex:0] valueForKey:@"user_name"];
    
    //每次进来查询的时候,先清除上次缓存数据
    [self.ArrayUserOrderList removeAllObjects];
    [self.ArrayOrderList removeAllObjects];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ArrayUserOrderList"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ArrayOrderList"];
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from orderList where user_id = ?",self.user_id];
        while ([rs next]) {
            self.order_id = [rs stringForColumn:@"order_id"];
            self.user_id = [rs stringForColumn:@"user_id"];
            self.status = [rs stringForColumn:@"status"];
            
            //先将数据存放到字典
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:self.order_id forKey:@"order_id"];
            [dic setObject:self.user_id forKey:@"user_id"];
            [dic setObject:self.status forKey:@"status"];
            
            //然后将字典存放到数组
            [self.ArrayUserOrderList addObject:dic];
            
        }
        
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs2 = [db executeQuery:@"select *from orderList"];
        while ([rs2 next]) {
            self.order_id = [rs2 stringForColumn:@"order_id"];
            self.user_id = [rs2 stringForColumn:@"user_id"];
            self.status = [rs2 stringForColumn:@"status"];
            
            //先将数据存放到字典
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:self.order_id forKey:@"order_id"];
            [dic setObject:self.user_id forKey:@"user_id"];
            [dic setObject:self.status forKey:@"status"];
            
            //然后将字典存放到数组
            [self.ArrayOrderList addObject:dic];
            
        }
        
        
        [[NSUserDefaults standardUserDefaults]setObject:self.ArrayUserOrderList forKey:@"ArrayUserOrderList"];
        [[NSUserDefaults standardUserDefaults]setObject:self.ArrayOrderList forKey:@"ArrayOrderList"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }];
    
    
    
}


@end




















