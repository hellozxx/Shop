//
//  ClassListCollectionView.h
//  Shop
//
//  Created by 朱啸 on 2018/5/11.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^selectCellGoodsIdBlock)(NSString *productID);

@interface ClassListCollectionView : UICollectionView

@property (strong, nonatomic) NSArray *proguctListArray;    //商品列表数据源
@property (copy, nonatomic) selectCellGoodsIdBlock productIdBlock;    //获取商品的ID--collection中点击的商品

@end
