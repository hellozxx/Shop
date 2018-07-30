//
//  DBComment.h
//  Shop
//
//  Created by 朱啸 on 2018/5/20.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBComment : NSObject

/**
 *  单例
 */
+(instancetype)sharedInstance;
/**
 *  新建数据库+新建表
 */
-(void)LinkDatabaseAndAddToQueue;
/**
 *  新增评论
 */
-(void)insetText:(NSString *)text WithUser_Id:(NSString *)user_id WithProduct_Id:(NSString *)product_id WithOrder_Id:(NSString *)order_id WithForum_Title:(NSString *)forum_title;

/**
 *  条件查询数据--查询评论表中的商品，判断同一个订单中的商品是否评论过
 */
-(NSMutableArray *)selectProduct_IDWithOrder_Id:(NSString *)order_id;


/**
 *  条件查询数据--查询评论表中的评论内容，用于评论列表的展示
 */
-(NSMutableArray *)selectTextWithProduct_ID:(NSString *)product_id;

/**
 *  条件查询数据--查询评论表中的评论的时间，用于评论列表的展示
 */
-(NSMutableArray *)selecttimeWithProduct_ID:(NSString *)product_id;

/**
 *  查询所有数据
 *
 */
-(void)selectAllMethod;

@end
