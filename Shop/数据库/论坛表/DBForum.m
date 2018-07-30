//
//  DBForum.m
//  Shop
//
//  Created by 朱啸 on 2018/4/24.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "DBForum.h"
#import "NSString+Time.h"

@interface DBForum()

@property (nonatomic,strong) FMDatabaseQueue *queue;
@property (strong, nonatomic) NSString *forum_title;
@property (strong, nonatomic) NSString *forum_text;
@property (strong, nonatomic) NSString *forum_image1;
@property (strong, nonatomic) NSString *forum_image2;
@property (strong, nonatomic) NSString *time;



@property (nonatomic,strong) NSMutableDictionary *params;
@property (nonatomic,strong) NSMutableArray *ArrayForum;

@end

@implementation DBForum

+(instancetype)sharedInstance{
    
    static DBForum *sql = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sql = [[DBForum alloc]init];
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
-(NSMutableArray *)ArrayForum{
    
    if (!_ArrayForum) {
        _ArrayForum = [NSMutableArray array];
    }
    return _ArrayForum;
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
 *  新增帖子
 */
-(void)insetForum_Title:(NSString *)forum_title WithForum_Text:(NSString *)forum_text WithForum_Image1:(NSString *)forum_image1 WithForum_Image2:(NSString *)forum_image2 {
    NSString *time = [NSString getNowTimeTimestamp];
    
    if ([self selectWithForum_title:forum_title]) {
        [self.queue inDatabase:^(FMDatabase *db) {
            BOOL flag = [db executeUpdate:@"insert into forumList (forum_title,forum_text,forum_image1,forum_image2,time) values (?,?,?,?,?)",forum_title,forum_text,forum_image1,forum_image2,time];
            if (flag) {
                Log(@"新增帖子成功");
            }else {
                Log(@"新增帖子失败");
            }
        }];
    }
}


/**
 *  条件查询数据--查询帖子标题,用于放置添加相同的帖子
 */
-(BOOL)selectWithForum_title:(NSString *)forum_title {
    [self.queue inDatabase:^(FMDatabase *db) {

        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from forumList where forum_title = ?",forum_title];
        while ([rs next]) {
            self.forum_title = [rs stringForColumn:@"forum_title"];
            //先将数据存放到字典
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:self.forum_title forKey:@"forum_title"];
            //然后将字典存放到数组
            [self.ArrayForum addObject:dic];
        }
    }];

    if ([self.forum_title isEqualToString:forum_title]) {
//        Log(@"此帖子已存在、无须再次添加");
        return NO;
    }else {
//        Log(@"此帖子不存在，添加成功");
        return YES;
    }
}


/**
 *  查询所有数据
 *
 */
- (void)selectAllMethod{
    //    Log(@"我进来啦！！！！");
    
    //每次进来查询的时候,先清除上次缓存数据
    [self.ArrayForum removeAllObjects];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ArryForum"];
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from forumList"];
        while ([rs next]) {
            self.forum_title = [rs stringForColumn:@"forum_title"];
            self.forum_text = [rs stringForColumn:@"forum_text"];
            self.forum_image1 = [rs stringForColumn:@"forum_image1"];
            self.forum_image2 = [rs stringForColumn:@"forum_image2"];
            self.time = [rs stringForColumn:@"time"];

            
            //先将数据存放到字典
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:self.forum_title forKey:@"forum_title"];
            [dic setObject:self.forum_text forKey:@"forum_text"];
            [dic setObject:self.forum_image1 forKey:@"forum_image1"];
            [dic setObject:self.forum_image2 forKey:@"forum_image2"];
            [dic setObject:self.time forKey:@"time"];
            
            //然后将字典存放到数组
            [self.ArrayForum addObject:dic];
            
        }
        
        //再将数组缓存到plist文件中
//        Log(@"存放的数组:%@==%ld",self.ArrayForum,self.ArrayForum.count);
        [[NSUserDefaults standardUserDefaults]setObject:self.ArrayForum forKey:@"ArryForum"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }];
}

@end
