//
//  ShoppingCartListCell.h
//  Shop
//
//  Created by 朱啸 on 2018/5/5.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartListModel.h"

@interface ShoppingCartListCell : UITableViewCell

@property (strong, nonatomic)   ShoppingCartListModel *cellData;    //cell的数据源

//因为ShoppingCartListView中需要调用，所以把这三个控件公开出来
@property (strong, nonatomic)   UIButton *isSelectBtn;  //是否选中
@property (strong, nonatomic)   UIButton *addButton;    //增加商品个数
@property (strong, nonatomic)   UIButton *cutButton;    //减少商品个数

@end
