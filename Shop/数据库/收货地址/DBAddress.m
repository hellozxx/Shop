//
//  DBAddress.m
//  Shop
//
//  Created by 朱啸 on 2018/5/7.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "DBAddress.h"
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"

@interface DBAddress()

@property (nonatomic,strong) FMDatabaseQueue *queue;
@property (nonatomic,strong) NSMutableDictionary *params;
@property (nonatomic,strong) NSMutableArray *ArrayAddress;


@property (strong, nonatomic) NSString *address_id;
@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *phonenumber;
@property (strong, nonatomic) NSString *consignee;


@end

@implementation DBAddress

+(instancetype)sharedInstance{
    
    static DBAddress *sql = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sql = [[DBAddress alloc]init];
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
-(NSMutableArray *)ArrayAddress{
    
    if (!_ArrayAddress) {
        _ArrayAddress = [NSMutableArray array];
    }
    return _ArrayAddress;
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
 *  新增地址
 */
-(void)insetAddress_Id:(NSString *)address_id WithUser_Id:(NSString *)user_id WithAddress:(NSString *)address WithConsignee:(NSString *)consignee WithPhoneNumber:(NSString *)phonenumber {
    [self.queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"insert into address (address_id,user_id,address,consignee,phonenumber) values (?,?,?,?,?)",address_id,user_id,address,consignee,phonenumber];
        Log(@"新增地址成功");
    }];
}

/**
 *  删除收货地址
 */
- (void) deleteWithAddress_id:(NSString *)address_id {
    [self.queue inDatabase:^(FMDatabase *db) {
        
        [db executeUpdate:@"delete from address where address_id = ?",address_id];

    }];
}


/**
 *  查询所有数据
 *
 */
-(void)selectAllMethod{
    
    //每次进来查询的时候,先清除上次缓存数据
    [self.ArrayAddress removeAllObjects];
    [self.queue inDatabase:^(FMDatabase *db) {
        
//        NSString *userID = [[[[NSUserDefaults standardUserDefaults] valueForKey:@"isLoginArray"] objectAtIndex:0] valueForKey:@"user_name"];
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from address"];//where user_id = ?",userID];
        while ([rs next]) {
            self.address_id = [rs stringForColumn:@"address_id"];
            self.user_id = [rs stringForColumn:@"user_id"];
            self.address = [rs stringForColumn:@"address"];
            self.consignee = [rs stringForColumn:@"consignee"];
            self.phonenumber = [rs stringForColumn:@"phonenumber"];
            
            //先将数据存放到字典
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:self.address_id forKey:@"address_id"];
            [dic setObject:self.user_id forKey:@"user_id"];
            [dic setObject:self.address forKey:@"address"];
            [dic setObject:self.consignee forKey:@"consignee"];
            [dic setObject:self.phonenumber forKey:@"phonenumber"];
            
            //然后将字典存放到数组
            [self.ArrayAddress addObject:dic];
            
        }
        
        
//        NSLog(@"存放的数组:%@==%ld",self.ArrayAddress,self.ArrayAddress.count);
        [[NSUserDefaults standardUserDefaults]setObject:self.ArrayAddress forKey:@"ArrayAddress"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }];
    
    
    
}


@end















