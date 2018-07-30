//
//  WaitPayTableViewCell.h
//  Shop
//
//  Created by 朱啸 on 2018/5/10.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaitPayTableViewCell : UITableViewCell

@property (strong, nonatomic) NSString *productid;/** 商品信息 */
@property (strong, nonatomic) NSString *orderID; //订单id
@end
