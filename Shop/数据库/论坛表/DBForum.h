//
//  DBForum.h
//  Shop
//
//  Created by 朱啸 on 2018/4/24.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"

@interface DBForum : NSObject
/**
 *  单例
 */
+(instancetype)sharedInstance;
/**
 *  新建数据库+新建表
 */
-(void)LinkDatabaseAndAddToQueue;

/**
 *  新增帖子
 */
-(void)insetForum_Title:(NSString *)forum_title WithForum_Text:(NSString *)forum_text WithForum_Image1:(NSString *)forum_image1 WithForum_Image2:(NSString *)forum_image2;


/**
 *  条件查询数据--查询帖子标题,用于放置添加相同的帖子
 */
-(BOOL)selectWithForum_title:(NSString *)forum_title;


/**
 *  查询所有数据
 *
 */
-(void)selectAllMethod;
@end
