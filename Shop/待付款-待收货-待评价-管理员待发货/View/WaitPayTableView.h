//
//  WaitPayTableView.h
//  Shop
//
//  Created by 朱啸 on 2018/5/10.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^commentButtonBlock)(NSString *productID);

@interface WaitPayTableView : UITableView

@property (strong, nonatomic) NSArray *productList;
@property (strong, nonatomic) NSString *orderID;
@property (assign, nonatomic) int cellCount;

@property (strong, nonatomic) commentButtonBlock commentBtnBlock;   //评论按钮的block


@end
