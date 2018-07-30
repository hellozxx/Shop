//
//  AddressTableView.h
//  Shop
//
//  Created by 朱啸 on 2018/5/7.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^backToOrderView)(void);

@interface AddressTableView : UITableView

@property (strong, nonatomic) NSMutableArray *addressArray;    //接收controller穿过来的收货地址数组

@property (strong, nonatomic) backToOrderView back;    //回到orderviewController,cell的点击事件

@end
