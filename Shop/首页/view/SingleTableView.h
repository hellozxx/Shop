//
//  SingleTableView.h
//  Shop
//
//  Created by 朱啸 on 2018/4/25.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleTableView : UITableView

typedef void (^newTableSelectProductIDBlock) (NSString *productID); //把productid传给controller
typedef void (^newTableSelectForumIDBlock) (NSString *forumID); //把forumid传给controller

@property (assign, nonatomic) BOOL isSingle;    //是不是新品团购

@property (strong, nonatomic) NSArray *singleModelArray;    //存放商品数据模型的数组
@property (strong, nonatomic) NSArray *forumModelArry;  //存放论坛数据模型的数组

@property (copy, nonatomic) newTableSelectProductIDBlock productIDBlock;    //返回商品ID的block,把productid传给controller
@property (copy, nonatomic) newTableSelectForumIDBlock forumIDBlock;    //返回商品ID的block,把productid传给controller

@end
