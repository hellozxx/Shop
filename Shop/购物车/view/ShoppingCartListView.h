//
//  ShoppingCartListView.h
//  Shop
//
//  Created by 朱啸 on 2018/5/5.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^returnChangeDataBlock)(void);

@interface ShoppingCartListView : UITableView

@property (strong, nonatomic) NSMutableArray *shoppingCartList;    //接收购物车请求回来的数据
@property (copy, nonatomic)   returnChangeDataBlock changeDataBlock;    //修改controller中的数据

@end
