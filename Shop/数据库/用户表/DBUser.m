//
//  DBAccount.m
//  Shop
//
//  Created by 朱啸 on 2018/4/16.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "DBUser.h"
#import "DBShoppingCart.h"
#import "NSString+GenerateRandomString.h"   //生成随机字符串

@interface DBUser()

@property (nonatomic,strong) FMDatabaseQueue *queue;

@property (nonatomic, strong) NSString *user_name;
@property (nonatomic, strong) NSString *user_password;
@property (nonatomic, strong) NSString *user_type;

@property (nonatomic,strong) NSMutableDictionary *params;
@property (nonatomic,strong) NSMutableArray *Array;

@end


@implementation DBUser

+(instancetype)sharedInstance{
    
    static DBUser *sql = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sql = [[DBUser alloc]init];
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
-(NSMutableArray *)Array{
    
    if (!_Array) {
        _Array = [NSMutableArray array];
    }
    return _Array;
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
 *  新增账户
 */
-(void)insetUser_Name:(NSString *)user_name WithUser_PassWord:(NSString *)user_password WithUser_Type:(NSString *)user_type{
//    Log(@"----------DBUser中新增账户的函数运行了--------------");
    [self.queue inDatabase:^(FMDatabase *db) {
//        Log(@"真的运行了吗？");
        BOOL flag = [db executeUpdate:@"insert into user (user_name,user_password,user_type) values (?,?,?)",user_name,user_password,user_type];
        if (flag) {
            NSLog(@"新增数据成功");
        }
        else{
            NSLog(@"新增数据失败");
        }
    }];
}

/**
 *  删除
 */
-(void)deleteWithUser_Name:(NSString *)user_name{
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
        BOOL flag = [db executeUpdate:@"delete from user where user_name = ?",user_name];
        if (flag) {
            NSLog(@"删除数据成功");
        }
        else{
            NSLog(@"删除数据失败");
        }
    }];
}

/**
 *  更新数据
 */
-(void)updateWithNewUser_Name:(NSString *)newUser_Name WithUser_Password:(NSString *)newUser_Password WithUser_Type:(NSString *)newUser_Type{
    
//    [self.queue inDatabase:^(FMDatabase *db) {
//
//        BOOL flag = [db executeUpdate:@"update user set name = ? where title = ?",newUser_Name,newUser_Password];
//        if (flag) {
//            NSLog(@"更新数据成功");
//        }
//        else{
//            NSLog(@"更新数据失败");
//        }
//    }];
}

/**
 *  条件查询数据--查询用户名,用于注册验证
 */
-(BOOL)selectWithUser_Name:(NSString *)user_name{
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from user where user_name = ?",user_name];
        while ([rs next]) {
            self.user_name = [rs stringForColumn:@"user_name"];
            Log(@"用户名:%@",self.user_name);
//            self.user_password = [rs stringForColumn:@"user_password"];
//            NSLog(@"用户名:%@----密码:%@",self.user_name,self.user_password);
//
//            //先将数据存放到字典
//            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//            [dic setObject:self.user_name forKey:@"dictuser_name"];
//            [dic setObject:self.user_password forKey:@"dictuser_password"];
//
//            //然后将字典存放到数组
//            [self.Array addObject:dic];
        }
    }];
    
    if ([self.user_name isEqualToString:user_name]) {
        Log(@"已经存在账户，请直接登录");
        return YES;
        
    }else {
        Log(@"不存在此账户，添加成功");
        return NO;
    }
}

 /**
  条件查询数据--查询用户名和密码,用于登录验证
  @return 0：用户名和手机号一致   1：用户名存在，但是密码错误  2：用户名不存在
  */
-(int)selectWithUser_Name:(NSString *)user_name WithUser_Password:(NSString *)user_password {
    [self.queue inDatabase:^(FMDatabase *db) {
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select user_name,user_password,user_type from user where user_name = ?",user_name];
        while ([rs next]) {
            self.user_name = [rs stringForColumn:@"user_name"];
            self.user_password = [rs stringForColumn:@"user_password"];
            self.user_type = [rs stringForColumn:@"user_type"];
            Log(@"用户名:%@----密码:%@----用户类型:%@",self.user_name,self.user_password,self.user_type);
            
//            //先将数据存放到字典
//            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//            [dic setObject:self.user_name forKey:@"dicuser_name"];
//            [dic setObject:self.user_password forKey:@"dicuser_password"];
//
//            //然后将字典存放到数组
//            [self.Array addObject:dic];
        }
    }];
    if ([self.user_name isEqualToString:user_name]) {
        if ([self.user_password isEqualToString:user_password]) {
            
            //将登录成功之后的用户信息缓存到plist文件中
            //先将数据存放到字典
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            NSMutableArray *isLoginArray = [NSMutableArray array];
            [dic setObject:self.user_name forKey:@"user_name"];
            [dic setObject:self.user_password forKey:@"user_password"];
            [dic setObject:self.user_type forKey:@"user_type"];
            [dic setObject:@"login" forKey:@"ISLOGIN"];
            
            //登录成功之后，个这个账户分配一个购物车
            NSString *cart_id = [NSString characterLength:8];
//            [dic setObject:cart_id forKey:@"cart_id"];
//            //然后将字典存放到数组
//            [isLoginArray addObject:dic];
//            [[NSUserDefaults standardUserDefaults] setObject:isLoginArray forKey:@"isLoginArray"];
            
            
            //登录成功之后，给这个账户分配一个购物车
//            NSString *user_id = [[[[NSUserDefaults standardUserDefaults] valueForKey:@"isLoginArray"] objectAtIndex:0] valueForKey:@"user_name"];
            
            [[DBShoppingCart sharedInstance] LinkDatabaseAndAddToQueue];
            [[DBShoppingCart sharedInstance] insetCart_Id:cart_id WithUser_Id:self.user_name];
            [[DBShoppingCart sharedInstance] selectAllMethod];
            
            NSString *cart_id2 = [[DBShoppingCart sharedInstance] selectWithUser_Id:self.user_name];
            [dic setObject:cart_id2 forKey:@"cart_id"];
            //然后将字典存放到数组
            [isLoginArray addObject:dic];
            [[NSUserDefaults standardUserDefaults] setObject:isLoginArray forKey:@"isLoginArray"];
            
            
            return 0;
        }
        else {
            return 1;
        }
    } else {
        return 2;
    }
    
}

/**
 *  查询所有数据
 *
 */
-(void)selectAllMethod{
    
    //每次进来查询的时候,先清除上次缓存数据
    [self.Array removeAllObjects];
    [self.queue inDatabase:^(FMDatabase *db) {
        
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from user"];
        while ([rs next]) {
            self.user_name = [rs stringForColumn:@"user_name"];
            self.user_password = [rs stringForColumn:@"user_password"];
            NSLog(@"用户名:%@----密码:%@",self.user_name,self.user_password);
            
            //先将数据存放到字典
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:self.user_name forKey:@"dictuser_name"];
            [dic setObject:self.user_password forKey:@"dictuser_password"];
            
            //然后将字典存放到数组
            [self.Array addObject:dic];
            
        }
        
        
//        NSLog(@"存放的数组:%@==%ld",self.Array,self.Array.count);
        [[NSUserDefaults standardUserDefaults]setObject:self.Array forKey:@"Arry"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }];
    
    
}


@end
