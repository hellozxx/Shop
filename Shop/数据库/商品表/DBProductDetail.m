//
//  DBProductDetail.m
//  Shop
//
//  Created by 朱啸 on 2018/4/26.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "DBProductDetail.h"

@interface DBProductDetail()

@property (nonatomic,strong) FMDatabaseQueue *queue;

@property (strong, nonatomic) NSString *product_id;
@property (strong, nonatomic) NSString *brand;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *marketprice;
@property (strong, nonatomic) NSString *place;
@property (strong, nonatomic) NSString *model;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *age;
@property (strong, nonatomic) NSString *topImage1;
@property (strong, nonatomic) NSString *topImage2;
@property (strong, nonatomic) NSString *topImage3;
@property (strong, nonatomic) NSString *topImage4;
@property (strong, nonatomic) NSString *detailImage1;
@property (strong, nonatomic) NSString *detailImage2;
@property (strong, nonatomic) NSString *detailImage3;
@property (strong, nonatomic) NSString *detailImage4;


@property (nonatomic,strong) NSMutableDictionary *params;
@property (nonatomic,strong) NSMutableArray *ArrayProductDetial;



@end

@implementation DBProductDetail
+(instancetype)sharedInstance{
    
    static DBProductDetail *sql = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sql = [[DBProductDetail alloc]init];
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
-(NSMutableArray *)ArrayProductDetial{
    
    if (!_ArrayProductDetial) {
        _ArrayProductDetial = [NSMutableArray array];
    }
    return _ArrayProductDetial;
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
 *  新增商品详情
 */

-(void)insetProduct_Id:(NSString *)product_id WithBrand:(NSString *)brand WithTitle:(NSString *)title WithPrice:(NSString *)price WithMarketPrice:(NSString *)marketprice WithPlace:(NSString *)place WithModel:(NSString *)model WithCategory:(NSString *)category WithAge:(NSString *)age WithTopImage1:(NSString *)topImage1 WithTopImage2:(NSString *)topImage2 WithTopImage3:(NSString *)topImage3 WithTopImage4:(NSString *)topImage4 WithDetailImage1:(NSString *)detailImage1 WithDetailImage2:(NSString *)detailImage2 WithDetailImage3:(NSString *)detailImage3 WithDetailImage4:(NSString *)detailImage4 {
    if ([self selectWithProduct_id:product_id]) {
        [self.queue inDatabase:^(FMDatabase *db) {
//            Log(@"真的运行了吗？");
            BOOL flag = [db executeUpdate:@"insert into productDetail (product_id,brand,title,price,marketprice,place,model,category,age,topImage1,topImage2,topImage3,topImage4,detailImage1,detailImage2,detailImage3,detailImage4) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",product_id,brand,title,price,marketprice,place,model,category,age,topImage1,topImage2,topImage3,topImage4,detailImage1,detailImage2,detailImage3,detailImage4];
            if (flag) {
                Log(@"新增商品详情成功");
            }else {
                Log(@"新增商品详情失败");
            }
        }];
    }
    
}


/**
 *  条件查询数据--查询商品id,用于放置添加相同的商品
 */
-(BOOL)selectWithProduct_id:(NSString *)product_id{
    
    [self.queue inDatabase:^(FMDatabase *db) {
        
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from productDetail where product_id = ?",product_id];
        while ([rs next]) {
            self.product_id = [rs stringForColumn:@"product_id"];
            //先将数据存放到字典
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:self.product_id forKey:@"product_id"];
            //然后将字典存放到数组
            [self.ArrayProductDetial addObject:dic];
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
 *  条件查询数据--查询商品价格,用于订单结算
 */
-(NSString *)selectPriceWithProduct_id:(NSString *)product_id {
    
    __block NSString *price;
    FMDatabase *db;
    FMResultSet *rs = [db executeQuery:@"select *from productDetail where product_id = ?",product_id];
    while ([rs next]) {
        price = [rs stringForColumn:@"price"];
    }
    [self.queue inDatabase:^(FMDatabase *db) {
        Log(@"123123123");
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from productDetail where product_id = ?",product_id];
        while ([rs next]) {
            price = [rs stringForColumn:@"price"];
        }
    }];
    return price;
}

/**
 *  删除
 */
-(void)deleteWithProduct_Id:(NSString *)product_id {
    [self.queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"delete from productDetail where product_id = ?",product_id];
    }];
}

/**
 *  更新数据
 */
-(void)updateWithProduct_Id:(NSString *)product_id WithBrand:(NSString *)brand WithTitle:(NSString *)title WithPrice:(NSString *)price WithMarketPrice:(NSString *)marketprice WithPlace:(NSString *)place WithModel:(NSString *)model WithCategory:(NSString *)category WithAge:(NSString *)age WithTopImage1:(NSString *)topImage1 WithTopImage2:(NSString *)topImage2 WithTopImage3:(NSString *)topImage3 WithTopImage4:(NSString *)topImage4 WithDetailImage1:(NSString *)detailImage1 WithDetailImage2:(NSString *)detailImage2 WithDetailImage3:(NSString *)detailImage3 WithDetailImage4:(NSString *)detailImage4 {
    [self.queue inDatabase:^(FMDatabase *db) {
        
        [db executeUpdate:@"update productDetail set brand = ?, title = ?, price = ?, marketprice = ?, place = ?,model = ?, category = ?, age = ?, topImage1 = ?, topImage2 = ?, topImage3 = ?, topImage4 = ?, detailImage1 = ?, detailImage2 = ?, detailImage3 = ?,detailImage4 = ? where product_id = ?",brand,title,price,marketprice,place,model,category,age,topImage1,topImage2,topImage3,topImage4,detailImage1,detailImage2,detailImage3,detailImage4,product_id];
    }];
}


/**
 *  查询所有数据
 *
 */
- (void)selectAllMethod{
    //每次进来查询的时候,先清除上次缓存数据
    [self.ArrayProductDetial removeAllObjects];
    [self.queue inDatabase:^(FMDatabase *db) {
        
        //获取结果集,返回参数就是查询结果
        FMResultSet *rs = [db executeQuery:@"select *from productDetail"];
        while ([rs next]) {
//            Log(@"while开始了");
            self.product_id = [rs stringForColumn:@"product_id"];
            self.brand = [rs stringForColumn:@"brand"];
            self.title = [rs stringForColumn:@"title"];
            self.price = [rs stringForColumn:@"price"];
            self.marketprice = [rs stringForColumn:@"marketprice"];
            self.place = [rs stringForColumn:@"place"];
            self.model = [rs stringForColumn:@"model"];
            self.category = [rs stringForColumn:@"category"];
            self.age = [rs stringForColumn:@"age"];
            self.topImage1 = [rs stringForColumn:@"topImage1"];
            self.topImage2 = [rs stringForColumn:@"topImage2"];
            self.topImage3 = [rs stringForColumn:@"topImage3"];
            self.topImage4 = [rs stringForColumn:@"topImage4"];
            self.detailImage1 = [rs stringForColumn:@"detailImage1"];
            self.detailImage2 = [rs stringForColumn:@"detailImage2"];
            self.detailImage3 = [rs stringForColumn:@"detailImage3"];
            self.detailImage4 = [rs stringForColumn:@"detailImage4"];
            
            
            //先将数据存放到字典
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:self.product_id forKey:@"product_id"];
            [dic setObject:self.brand forKey:@"brand"];
            [dic setObject:self.title forKey:@"title"];
            [dic setObject:self.price forKey:@"price"];
            [dic setObject:self.marketprice forKey:@"marketprice"];
            [dic setObject:self.place forKey:@"place"];
            [dic setObject:self.model forKey:@"model"];
            [dic setObject:self.category forKey:@"category"];
            [dic setObject:self.age forKey:@"age"];
            [dic setObject:self.topImage1 forKey:@"topImage1"];
            [dic setObject:self.topImage2 forKey:@"topImage2"];
            [dic setObject:self.topImage3 forKey:@"topImage3"];
            [dic setObject:self.topImage4 forKey:@"topImage4"];
            [dic setObject:self.detailImage1 forKey:@"detailImage1"];
            [dic setObject:self.detailImage2 forKey:@"detailImage2"];
            [dic setObject:self.detailImage3 forKey:@"detailImage3"];
            [dic setObject:self.detailImage4 forKey:@"detailImage4"];
            
            //然后将字典存放到数组
            [self.ArrayProductDetial addObject:dic];
            
        }
        
        //再将数组缓存到plist文件中
//        Log(@"存放的数组:%@==%ld",self.ArrayProductDetial,self.ArrayProductDetial.count);
        [[NSUserDefaults standardUserDefaults]setObject:self.ArrayProductDetial forKey:@"ArrayProductDetial"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }];
}
@end
