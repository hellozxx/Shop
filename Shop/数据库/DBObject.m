//
//  DBObject.m
//  Shop
//
//  Created by 朱啸 on 2018/4/16.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "DBObject.h"
@interface DBObject()

@property (nonatomic,strong) FMDatabaseQueue *queue;

@end


@implementation DBObject

+(instancetype)sharedInstance{
    
    static DBObject *sql = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sql = [[DBObject alloc]init];
    });
    return sql;
}




/**
 *  新建数据库+新建表
 */
-(void)addDatabaseAndTableMethod{
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    //拼接文件名
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"Shop.sqlite"];
    NSLog(@"数据库路径:%@",filePath);
    //创建数据库,并加入到队列中,此时已经默认打开了数据库,无须手动打开,只需要从队列中去除数据库即可
    self.queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    //取出数据库,这里的db就是数据库,在数据库中建表
    [self.queue inDatabase:^(FMDatabase *db) {
        
        //用户账号密码列表
        [db executeUpdate:@"create table if not exists user (id integer primary key autoincrement,user_name text,user_password text,user_type text)"]; //id，账号，密码，用户类型
        
        //所有商品列表
        [db executeUpdate:@"create table if not exists productList (id integer primary key autoincrement,product_id text,product_name text,product_iconimage text,product_categoryid text,product_price text,product_marketprice text,product_description text)"];   //id、商品id、商品名称、商品图片、商品类别id、商品价格、市场售价、商品描述
        
        //论坛帖子列表
        [db executeUpdate:@"create table if not exists forumList (id integer primary key  autoincrement,forum_title text,forum_image1 text,forum_image2 text,forum_text text,time text)"];  //id、帖子标题、帖子图片1、帖子图片2、正文、时间
        
        //商品详情表
        [db executeUpdate:@"create table if not exists productDetail (id integer primary key autoincrement, product_id text,brand text,title text,price text,marketprice text,place text,model text,category text,age text,topImage1 text,topImage2 text,topImage3 text,topImage4 text,detailImage1 text,detailImage2 text,detailImage3 text,detailImage4 text)"];   //id、商品id、品牌、标题、商品价格、市场售价、产地、型号、类别、适用年龄、轮播图1、轮播图2、轮播图3、轮播图4、详情图1、详情图2、详情图3、详情图4
        
        
        //购物车列表
        [db executeUpdate:@"create table if not exists shoppingCart (id integer primary key autoincrement,cart_id text,user_id text)"];    //id、购物车id、用户id
        
        //购物车详情表
        [db executeUpdate:@"create table if not exists shoppingCartDetail (id integer primary key autoincrement,cart_id text,product_id text,number text)"];   //购物车内商品详情id、购物车id、商品id、商品数量
        
        //订单列表
        [db executeUpdate:@"create table if not exists orderList (id integer primary key autoincrement,order_id text,user_id text,totalprice text,status text,ordertime text)"];    //id、订单id、用户id、价格总和、订单状态、订单时间
        
        //订单详情表
        [db executeUpdate:@"create table if not exists orderDetail (id integer primary key autoincrement,order_id text,product_id text,number text,receivingaddress_id text,courier_id text)"];   //id、订单id、商品id、商品数量、收货地址id、快递单号id
        
        //支付表
        [db executeUpdate:@"create table if not exists payMent (id integer primary key autoincrement,payment_id text,order_id text,paytype text,payaccount text,totalprice text,paytime text)"];   //id、支付id、订单id、支付类型、支付账户、总价格、支付时间
        
        //收货地址表
        [db executeUpdate:@"create table if not exists address (id integer primary key autoincrement,address_id text,user_id text,address text,consignee text,phonenumber text)"];   //id、收货地址id、用户id、地址、收货人、手机号
        
        //评论表
        [db executeUpdate:@"create table if not exists comment (id integer primary key autoincrement,text text,user_id text,product_id text,order_id,forum_title text,time text)"];   //id、正文、用户id、商品id、订单ID、帖子标题、事件
    }];
}




@end


















