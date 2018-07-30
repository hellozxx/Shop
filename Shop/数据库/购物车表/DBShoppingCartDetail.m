//
//  DBShoppingCartDetail.m
//  Shop
//
//  Created by 朱啸 on 2018/5/4.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "DBShoppingCartDetail.h"
#import "DBProduct.h"
#import "ShoppingCartListModel.h"

@interface DBShoppingCartDetail()

@property (nonatomic,strong) FMDatabaseQueue *queue;
@property (nonatomic,strong) NSMutableDictionary *params;
@property (nonatomic,strong) NSMutableArray *ArrayShopCartDetial;

@property (strong, nonatomic) NSString *cartDetail_id;
@property (strong, nonatomic) NSString *cart_id;
@property (strong, nonatomic) NSString *product_id;
@property (strong, nonatomic) NSString *number;

@end

@implementation DBShoppingCartDetail


+(instancetype)sharedInstance{
    
    static DBShoppingCartDetail *sql = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sql = [[DBShoppingCartDetail alloc]init];
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
-(NSMutableArray *)ArrayShopCartDetial{
    
    if (!_ArrayShopCartDetial) {
        _ArrayShopCartDetial = [NSMutableArray array];
    }
    return _ArrayShopCartDetial;
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
 *  新增购物车详情
 */
-(void)insetCart_Id:(NSString *)cart_id WithProduct_Id:(NSString *)product_id WithNumber:(NSString *)number {
    
    //如果商品不存在，则直接添加，如果存在，则数量+1
    if ([self selectWithProduct_Id:product_id]) {
        [self.queue inDatabase:^(FMDatabase *db) {
            BOOL flag = [db executeUpdate:@"insert into shoppingCartDetail (cart_id,product_id,number) values (?,?,?)",cart_id,product_id,number];
            if (flag) {
                NSLog(@"新增购物车详情数据成功");
            }
            else{
                NSLog(@"新增购物车详情数据失败");
            }
        }];
    }else {
        __block NSInteger count;
        __block NSString *num;
        [self.queue inDatabase:^(FMDatabase *db) {
            FMResultSet *rs = [db executeQuery:@"select *from shoppingCartDetail where (cart_id = ? and product_id = ?)",cart_id,product_id];
            while ([rs next]) {
                num = [rs stringForColumn:@"product_id"];
                self.number = [rs stringForColumn:@"number"];
                count = [self.number integerValue] + 1;
                num = [NSString stringWithFormat:@"%ld",(long)count];
                [db executeUpdate:@"update shoppingCartDetail set number = ? where product_id = ?",num,product_id];
            }
            
        }];
    }
    
    
}

/**
 *  条件查询数据--查询商品id,用于防止在购物车详情表内添加多个相同的商品
 */
-(BOOL)selectWithProduct_Id:(NSString *)product_id {
    [self.queue inDatabase:^(FMDatabase *db) {
        
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from shoppingCartDetail where product_id = ?",product_id];
        while ([rs next]) {
            if ([[rs stringForColumn:@"cart_id"] isEqualToString:[[[[NSUserDefaults standardUserDefaults] valueForKey:@"isLoginArray"] objectAtIndex:0] valueForKey:@"cart_id"]]) {
                self.product_id = [rs stringForColumn:@"product_id"];
            }
        }
    }];
    
    if ([self.product_id isEqualToString:product_id]) {
        Log(@"此商品在购物车中已存在、数量+1");
        return NO;
        
    }else {
        Log(@"此商品在购物车不存在，添加成功");
        return YES;
    }
}




/**
 *  条件查询数据--查询商品id,然后修改对应的商品数量
 */
- (void) updateNumber:(NSString *)number WithProduct_Id:(NSString *)product_id {
    [self.queue inDatabase:^(FMDatabase *db) {
    
        BOOL flag = [db executeUpdate:@"update shoppingCartDetail set number  = ? where product_id = ?",number,product_id];
        if (flag) {
            Log(@"更新数据成功");
        }else{
            Log(@"更新数据失败");
        }
    }];
}

/**
 *  删除商品
 */
- (void) deleteWithProduct_Id:(NSString *)product_id {
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
        BOOL flag = [db executeUpdate:@"delete from shoppingCartDetail where product_id = ?",product_id];
        if (flag) {
            Log(@"删除数据成功");
        }
        else{
            Log(@"删除数据失败");
        }
    }];
}



/**
 *  查询所有数据
 *
 */
-(void)selectAllMethod {
    
    //每次进来查询的时候,先清除上次缓存数据
    [self.ArrayShopCartDetial removeAllObjects];
    [self.queue inDatabase:^(FMDatabase *db) {
        //取出登录标识plist文件中的购物车id
        NSString *cartID = [[[[NSUserDefaults standardUserDefaults] valueForKey:@"isLoginArray"] objectAtIndex:0] valueForKey:@"cart_id"];
        
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select shoppingCartDetail.product_id,shoppingCartDetail.number,productList.product_name,productList.product_iconimage,productList.product_price from shoppingCartDetail inner join productList on shoppingCartDetail.product_id = productList.product_id where shoppingCartDetail.cart_id = ?",cartID];
        ShoppingCartListModel *cartListModel = [[ShoppingCartListModel alloc] init];
        while ([rs next]) {
            cartListModel.product_id = [rs stringForColumn:@"product_id"];
            cartListModel.product_name = [rs stringForColumn:@"product_name"];
            cartListModel.number = [rs stringForColumn:@"number"];
            cartListModel.product_iconimage = [rs stringForColumn:@"product_iconimage"];
            cartListModel.product_price = [rs stringForColumn:@"product_price"];
            
            //先将数据存放到字典
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:cartListModel.product_id forKey:@"product_id"];
            [dic setObject:cartListModel.product_name forKey:@"product_name"];
            [dic setObject:cartListModel.number forKey:@"number"];
            [dic setObject:cartListModel.product_iconimage forKey:@"product_iconimage"];
            [dic setObject:cartListModel.product_price forKey:@"product_price"];
            //然后将字典存放到数组
            [self.ArrayShopCartDetial addObject:dic];
        }
//        NSLog(@"存放的数组:%@==%ld",self.ArrayShopCartDetial,self.ArrayShopCartDetial.count);
        [[NSUserDefaults standardUserDefaults]setObject:self.ArrayShopCartDetial forKey:@"ArrayShopCartDetial"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }];
}







@end

















