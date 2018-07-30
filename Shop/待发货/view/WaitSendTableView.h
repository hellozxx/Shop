//
//  WaitSendTableView.h
//  Shop
//
//  Created by 朱啸 on 2018/5/11.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaitSendTableView : UITableView

@property (strong, nonatomic) NSArray *productList;
@property (strong, nonatomic) NSString *orderID;
@property (assign, nonatomic) int cellCount;

@end
