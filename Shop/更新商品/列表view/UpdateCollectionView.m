//
//  UpdateCollectionView.m
//  Shop
//
//  Created by 朱啸 on 2018/5/13.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "UpdateCollectionView.h"
#import "UpdateListCollectionViewCell.h"

@interface UpdateCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource>



@end

@implementation UpdateCollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[UpdateListCollectionViewCell class] forCellWithReuseIdentifier:@"ClassListCollectionViewCell"];
    }
    return self;
}


- (void) setProguctListArray:(NSArray *)proguctListArray {
    _proguctListArray = proguctListArray;
    [self reloadData];  //刷新数据
}


- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.proguctListArray.count; //返回array的数量
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"ClassListCollectionViewCell";
    UpdateListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    cell.listCellModel = self.proguctListArray[indexPath.row];
    return cell;
}

//collection 的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Log(@"选中的是第几个cell:%li",indexPath.row);
    if (_productIdBlock) {
        _productIdBlock([_proguctListArray[indexPath.row] product_id]);
    }
}

@end
