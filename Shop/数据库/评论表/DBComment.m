//
//  DBComment.m
//  Shop
//
//  Created by 朱啸 on 2018/5/20.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "DBComment.h"
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"
#import "NSString+Time.h"

@interface DBComment()

@property (nonatomic,strong) FMDatabaseQueue *queue;
@property (nonatomic,strong) NSMutableDictionary *params;
@property (nonatomic,strong) NSMutableArray *ArrayComment;

@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic) NSString *product_id;
@property (strong, nonatomic) NSString *order_id;
@property (strong, nonatomic) NSString *forum_title;
@property (strong, nonatomic) NSString *time;


@end

@implementation DBComment

+(instancetype)sharedInstance{
    
    static DBComment *sql = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sql = [[DBComment alloc]init];
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
    
    if (!_ArrayComment) {
        _ArrayComment = [NSMutableArray array];
    }
    return _ArrayComment;
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
 *  新增评论
 */
-(void)insetText:(NSString *)text WithUser_Id:(NSString *)user_id WithProduct_Id:(NSString *)product_id WithOrder_Id:(NSString *)order_id WithForum_Title:(NSString *)forum_title {
    self.time = [NSString getNowTimeSSTimestamp];
    [self.queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"insert into comment (text,user_id,product_id,order_id,forum_title,time) values (?,?,?,?,?,?)",text,user_id,product_id,order_id,forum_title,self.time];
        Log(@"新增评论成功");
    }];
}


/**
 *  条件查询数据--查询评论表中的商品，判断同一个订单中的商品是否评论过
 */
-(NSMutableArray *)selectProduct_IDWithOrder_Id:(NSString *)order_id {
    __block NSMutableArray *productIDArray = [NSMutableArray array];
    [self.queue inDatabase:^(FMDatabase *db) {
        
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from comment where order_id = ?",order_id];
        while ([rs next]) {
            [productIDArray addObject:[rs stringForColumn:@"product_id"]];
        }
    }];
    return productIDArray;
}


/**
 *  条件查询数据--查询评论表中的评论内容，用于评论列表的展示
 */
-(NSMutableArray *)selectTextWithProduct_ID:(NSString *)product_id {
    __block NSMutableArray *textArray = [NSMutableArray array];
    [self.queue inDatabase:^(FMDatabase *db) {
        
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from comment where product_id = ?",product_id];
        while ([rs next]) {
            [textArray addObject:[rs stringForColumn:@"text"]];
        }
    }];
    return textArray;
}

/**
 *  条件查询数据--查询评论表中的评论的时间，用于评论列表的展示
 */
-(NSMutableArray *)selecttimeWithProduct_ID:(NSString *)product_id {
    __block NSMutableArray *timeArray = [NSMutableArray array];
    [self.queue inDatabase:^(FMDatabase *db) {
        
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from comment where product_id = ?",product_id];
        while ([rs next]) {
            [timeArray addObject:[rs stringForColumn:@"time"]];
        }
    }];
    return timeArray;
}


/**
 *  查询所有数据
 *
 */
-(void)selectAllMethod{
    
    //每次进来查询的时候,先清除上次缓存数据
    [self.ArrayComment removeAllObjects];
    [self.queue inDatabase:^(FMDatabase *db) {
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from comment"];
        while ([rs next]) {
            self.text = [rs stringForColumn:@"text"];
            self.user_id = [rs stringForColumn:@"user_id"];
            self.product_id = [rs stringForColumn:@"product_id"];
            self.order_id = [rs stringForColumn:@"order_id"];
            self.forum_title = [rs stringForColumn:@"forum_title"];
            self.time = [rs stringForColumn:@"time"];
            
            //先将数据存放到字典
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:self.text forKey:@"text"];
            [dic setObject:self.user_id forKey:@"user_id"];
            [dic setObject:self.product_id forKey:@"product_id"];
            [dic setObject:self.order_id forKey:@"order_id"];
            [dic setObject:self.forum_title forKey:@"forum_title"];
            [dic setObject:self.time forKey:@"time"];
            
            //然后将字典存放到数组
            [self.ArrayComment addObject:dic];
            
        }
        [[NSUserDefaults standardUserDefaults]setObject:self.ArrayComment forKey:@"ArrayComment"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }];
}


@end
