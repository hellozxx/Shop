//
//  SingleTableViewCell.h
//  Shop
//
//  Created by 朱啸 on 2018/4/23.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBProduct.h"
#import "SingleListModel.h" //存储数据的model模型

@interface SingleTableViewCell : UITableViewCell

@property (strong, nonatomic) SingleListModel   *singleModel;   //model
@property (strong, nonatomic) NSString *productID;    //购物车按钮

@end
