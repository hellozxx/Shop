//
//  ClassListCollectionViewCell.h
//  Shop
//
//  Created by 朱啸 on 2018/5/11.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductListSearchModel.h"

@interface ClassListCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic)    ProductListSearchModel *listCellModel; //存储数据的model

@end
