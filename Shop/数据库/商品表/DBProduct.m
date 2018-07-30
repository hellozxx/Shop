//
//  DBProduct.m
//  Shop
//
//  Created by 朱啸 on 2018/4/23.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "DBProduct.h"

@interface DBProduct()

@property (nonatomic,strong) FMDatabaseQueue *queue;

@property (strong, nonatomic) NSString *product_id;
@property (strong, nonatomic) NSString *product_name;
@property (strong, nonatomic) NSString *product_iconimage;
@property (strong, nonatomic) NSString *product_categoryid;
@property (strong, nonatomic) NSString *product_price;
@property (strong, nonatomic) NSString *product_marketprice;
@property (strong, nonatomic) NSString *product_description;


@property (nonatomic,strong) NSMutableDictionary *params;
@property (nonatomic,strong) NSMutableArray *ArrayProduct;

@end

@implementation DBProduct
+(instancetype)sharedInstance{
    
    static DBProduct *sql = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sql = [[DBProduct alloc]init];
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
-(NSMutableArray *)ArrayProduct{
    
    if (!_ArrayProduct) {
        _ArrayProduct = [NSMutableArray array];
    }
    return _ArrayProduct;
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

-(void)insetProduct_Id:(NSString *)product_id WithProduct_Name:(NSString *)product_name WithProduct_IconImage:(NSString *)product_iconimage WithProduct_CategoryID:(NSString *)product_categoryid WithProduct_Price:(NSString *)product_price WithProduct_MarketPrice:(NSString *)product_marketprice WithProduct_Description:(NSString *)product_description{
    if ([self selectWithProduct_id:product_id]) {
        [self.queue inDatabase:^(FMDatabase *db) {
//            Log(@"真的运行了吗？");
            [db executeUpdate:@"insert into productList (product_id,product_name,product_iconimage,product_categoryid,product_price,product_marketprice,product_description) values (?,?,?,?,?,?,?)",product_id,product_name,product_iconimage,product_categoryid,product_price,product_marketprice,product_description];
//            if (flag) {
//                Log(@"新增商品成功");
//            }else {
//                Log(@"新增商品失败");
//            }
        }];
    }
    
}



/**
 *  更新数据
 */
-(void)updateWithProduct_Id:(NSString *)product_id WithName:(NSString *)name WithIconImage:(NSString *)iconimage WithCategoryId:(NSString *)categoryid WithPrice:(NSString *)price WithMarketPrice:(NSString *)marketprice WithDescription:(NSString *)description {
    
        [self.queue inDatabase:^(FMDatabase *db) {
    
            [db executeUpdate:@"update productList set product_name = ?, product_iconimage = ?, product_categoryid = ?, product_price = ?, product_marketprice = ?, product_description = ? where product_id = ?",name,iconimage,categoryid,price,marketprice,description,product_id];
        }];
}

/**
 *  条件查询数据--查询商品id,用于放置添加相同的商品
 */
-(BOOL)selectWithProduct_id:(NSString *)product_id{
    
    [self.queue inDatabase:^(FMDatabase *db) {
    
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from productList where product_id = ?",product_id];
        while ([rs next]) {
            self.product_id = [rs stringForColumn:@"product_id"];
            //先将数据存放到字典
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:self.product_id forKey:@"product_id"];
            //然后将字典存放到数组
            [self.ArrayProduct addObject:dic];
        }
    }];

    if ([self.product_id isEqualToString:product_id]) {
//        Log(@"此商品已存在、无须再次添加");
        return NO;

    }else {
//        Log(@"此商品不存在，添加成功");
        return YES;
    }
}

/**
 *  条件查询数据--查询商品名称，用于搜索
 */
- (BOOL)selectWithProduct_Name:(NSString *)product_name {
    
    //移除ArryProductSearch.list,不然会存放上一次搜索的数据
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ArryProductSearch"];
    //清空arrayProduct数组中的数据，不然会连带首页中的数据一起加载
    [_ArrayProduct removeAllObjects];
    
   __block BOOL flag = NO;  //用于判断是否匹配到相关的product_name
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from productList"];
        while ([rs next]) {
            //模糊匹配
//            Log(@"[rs stringForColumn:@'product_name'] = %@",[rs stringForColumn:@"product_name"]);
            if ([[rs stringForColumn:@"product_name"] containsString:product_name]) {
//                Log(@"进入了if语句");
                self.product_id = [rs stringForColumn:@"product_id"];
                self.product_name = [rs stringForColumn:@"product_name"];
                self.product_iconimage = [rs stringForColumn:@"product_iconimage"];
                self.product_price = [rs stringForColumn:@"product_price"];
                self.product_marketprice = [rs stringForColumn:@"product_marketprice"];
                self.product_categoryid = [rs stringForColumn:@"product_categoryid"];
                self.product_description = [rs stringForColumn:@"product_description"];
                //先将数据存放到字典
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setObject:self.product_id forKey:@"product_id"];
                [dic setObject:self.product_name forKey:@"product_name"];
                [dic setObject:self.product_iconimage forKey:@"product_iconimage"];
                [dic setObject:self.product_price forKey:@"product_price"];
                [dic setObject:self.product_marketprice forKey:@"product_marketprice"];
                [dic setObject:self.product_categoryid forKey:@"product_categoryid"];
                [dic setObject:self.product_description forKey:@"product_description"];
                //然后将字典存放到数组
                [self.ArrayProduct addObject:dic];
                
                [[NSUserDefaults standardUserDefaults]setObject:self.ArrayProduct forKey:@"ArryProductSearch"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                flag = YES;
            }
        }
    }];
    return flag;
}

/**
 *  条件查询数据--查询商品种类，用于分类显示
 */
-(BOOL)selectWithProduct_CategoryId:(NSString *)product_categoryid {
    //移除ArryProductSearch.list,不然会存放上一次搜索的数据
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ArryProductClass"];
    //清空arrayProduct数组中的数据，不然会连带首页中的数据一起加载
    [_ArrayProduct removeAllObjects];
    
    __block BOOL flag = NO;  //用于判断是否匹配到相关的product_name
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from productList"];
        while ([rs next]) {
            //模糊匹配
            //            Log(@"[rs stringForColumn:@'product_name'] = %@",[rs stringForColumn:@"product_name"]);
            if ([[rs stringForColumn:@"product_categoryid"] containsString:product_categoryid]) {
                //                Log(@"进入了if语句");
                self.product_id = [rs stringForColumn:@"product_id"];
                self.product_name = [rs stringForColumn:@"product_name"];
                self.product_iconimage = [rs stringForColumn:@"product_iconimage"];
                self.product_price = [rs stringForColumn:@"product_price"];
                self.product_marketprice = [rs stringForColumn:@"product_marketprice"];
                self.product_categoryid = [rs stringForColumn:@"product_categoryid"];
                self.product_description = [rs stringForColumn:@"product_description"];
                //先将数据存放到字典
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setObject:self.product_id forKey:@"product_id"];
                [dic setObject:self.product_name forKey:@"product_name"];
                [dic setObject:self.product_iconimage forKey:@"product_iconimage"];
                [dic setObject:self.product_price forKey:@"product_price"];
                [dic setObject:self.product_marketprice forKey:@"product_marketprice"];
                [dic setObject:self.product_categoryid forKey:@"product_categoryid"];
                [dic setObject:self.product_description forKey:@"product_description"];
                //然后将字典存放到数组
                [self.ArrayProduct addObject:dic];
                
                [[NSUserDefaults standardUserDefaults]setObject:self.ArrayProduct forKey:@"ArryProductClass"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                flag = YES;
            }
        }
    }];
    return flag;
}

/**
 *  条件查询数据--查询商品名称
 */
-(NSString *)selectProduct_NameWithProduct_Id:(NSString *)product_id {
    __block NSString *productName;
    [self.queue inDatabase:^(FMDatabase *db) {
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from productList where product_id = ?",product_id];
        while ([rs next]) {
            productName = [rs stringForColumn:@"product_name"];
        }
    }];
    return productName;
}

/**
 *  条件查询数据--查询商品图片
 */
-(NSString *)selectProduct_IconImageWithProduct_Id:(NSString *)product_id {
    __block NSString *productIconImage;
    [self.queue inDatabase:^(FMDatabase *db) {
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from productList where product_id = ?",product_id];
        while ([rs next]) {
            productIconImage = [rs stringForColumn:@"product_iconimage"];
        }
    }];
    return productIconImage;
}

/**
 *  条件查询数据--查询商品价格
 */
-(NSString *)selectPriceWithProduct_Id:(NSString *)product_id {
    __block NSString *productPrice;
    [self.queue inDatabase:^(FMDatabase *db) {
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from productList where product_id = ?",product_id];
        while ([rs next]) {
            productPrice = [rs stringForColumn:@"product_price"];
        }
    }];
    return productPrice;
}

/**
 *  删除
 */
-(void)deleteWithProduct_Id:(NSString *)product_id {
    [self.queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"delete from productList where product_id = ?",product_id];
    }];
}


/**
 *  查询所有数据
 *
 */
- (void)selectAllMethod{
//    Log(@"我进来啦！！！！");
    
    //每次进来查询的时候,先清除上次缓存数据
    [self.ArrayProduct removeAllObjects];
    [self.queue inDatabase:^(FMDatabase *db) {
        
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from productList"];
        while ([rs next]) {
            self.product_id = [rs stringForColumn:@"product_id"];
            self.product_name = [rs stringForColumn:@"product_name"];
            self.product_iconimage = [rs stringForColumn:@"product_iconimage"];
            self.product_price = [rs stringForColumn:@"product_price"];
            self.product_marketprice = [rs stringForColumn:@"product_marketprice"];
            self.product_categoryid = [rs stringForColumn:@"product_categoryid"];
            self.product_description = [rs stringForColumn:@"product_description"];
            
            //先将数据存放到字典
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:self.product_id forKey:@"product_id"];
            [dic setObject:self.product_name forKey:@"product_name"];
            [dic setObject:self.product_iconimage forKey:@"product_iconimage"];
            [dic setObject:self.product_price forKey:@"product_price"];
            [dic setObject:self.product_marketprice forKey:@"product_marketprice"];
            [dic setObject:self.product_categoryid forKey:@"product_categoryid"];
            [dic setObject:self.product_description forKey:@"product_description"];
            
            //然后将字典存放到数组
            [self.ArrayProduct addObject:dic];
//            Log(@"11111111111111111");
            
        }
        
        //再将数组缓存到plist文件中
//        Log(@"存放的数组:%@==%ld",self.ArrayProduct,self.ArrayProduct.count);
        [[NSUserDefaults standardUserDefaults]setObject:self.ArrayProduct forKey:@"ArryProduct"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }];
}

@end
