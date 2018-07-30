//
//  ShoppingCartListView.m
//  Shop
//
//  Created by 朱啸 on 2018/5/5.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "ShoppingCartListView.h"
#import "ShoppingCartListCell.h"    //tableview对应的cell
#import "ShoppingCartListModel.h"   //tableview中cell的model
#import "DBShoppingCartDetail.h"
#import "DBShoppingCart.h"

@interface ShoppingCartListView()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation ShoppingCartListView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource= self;
        self.bounces = NO;  //关闭回弹效果
    }
    return self;
}


- (void)setShoppingCartList:(NSMutableArray *)shoppingCartList {
//    self.shoppingCartList = [NSMutableArray array];
    _shoppingCartList = shoppingCartList;
    
    //让购物车内的商品默认为选中状态
    for (ShoppingCartListModel *model in _shoppingCartList) {
        [model setIsSelectButton:YES];  //让购物车内的商品默认为选中状态
    }
    
    [self reloadData];  //刷新表单
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    Log(@"self.shoppingCartList.count : %lu",(unsigned long)self.shoppingCartList.count);
    return self.shoppingCartList.count;
//    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShoppingCartListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[ShoppingCartListCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    //传对应的值给cell
    cell.cellData = _shoppingCartList[indexPath.row];
    
    cell.tag = 1000 + indexPath.row;    //给cell添加唯一标识,加上1000是为了避免tag值重复
    
    [cell.addButton addTarget:self action:@selector(addButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
    [cell.cutButton addTarget:self action:@selector(cutButtonMethod:) forControlEvents:UIControlEventTouchUpInside];
    [cell.isSelectBtn addTarget:self action:@selector(isSelectBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

//侧滑删除，tableview自带的方法，IOS8.0之后才可以使用，当然也可以添加两个按钮，block方法写两次就可以了
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *dele = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        ShoppingCartListModel *cellModel = self->_shoppingCartList[indexPath.row];
        
        //把当前商品从数据库中移除
        [[DBShoppingCartDetail sharedInstance] LinkDatabaseAndAddToQueue];
        [[DBShoppingCartDetail sharedInstance] deleteWithProduct_Id:cellModel.product_id];
        
        [[DBShoppingCart sharedInstance] LinkDatabaseAndAddToQueue];
//        NSString *cart_ID = [[DBShoppingCart sharedInstance] selectWithUser_Id:cellModel.cart_id];
        
        [[DBShoppingCartDetail sharedInstance] selectAllMethod];
//        [cellModel setNumber:@"0"];
        [self changeDataMethod];
        
        [self->_shoppingCartList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
    }];
    return @[dele];
}

//开启删除的状态
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}



//cell中addButton的点击事件--增加商品数量
- (void) addButtonMethod:(UIButton *)sender {
    UIView *cell = [sender superview];
    NSInteger cellTag = cell.tag - 1000;
//    Log(@"cell : %@",cell);
//    Log(@"cell : %li",cellTag);
    
    ShoppingCartListModel *cellModel = _shoppingCartList[cellTag];
    NSInteger productNumber = [cellModel.number integerValue] + 1;  //先把model中的number取出来，并转换成int类型，然后再＋1
    NSString *number = [NSString stringWithFormat:@"%ld",productNumber];    //再将处理好的商品数量转换为string类型
    [cellModel setNumber:number];   //将处理好的数据赋值给model
    
    [self changeDataMethod];
}

//cell中cutButton的点击事件--减少商品数量
- (void) cutButtonMethod:(UIButton *)sender  {
    UIView *cell = [sender superview];
    NSInteger cellTag = cell.tag - 1000;
    //    Log(@"cell : %@",cell);
    //    Log(@"cell : %li",cellTag);
    
    ShoppingCartListModel *cellModel = _shoppingCartList[cellTag];
    NSInteger productNumber = [cellModel.number integerValue] - 1;  //先把model中的number取出来，并转换成int类型，然后再-1
    if (productNumber > 0) {    //保证商品数量不可以为0
        NSString *number = [NSString stringWithFormat:@"%ld",productNumber];    //再将处理好的商品数量转换为string类型
        [cellModel setNumber:number];   //将处理好的数据赋值给model
    }
    
    [self changeDataMethod];
    
}

//cell中的商品是否被选择
- (void) isSelectBtnMethod:(UIButton *)sender  {
    UIView *cell = [sender superview];
    ShoppingCartListModel *cellModel = _shoppingCartList[cell.tag - 1000];
    
    if (sender.isSelected) {
        sender.selected = NO;
        [cellModel setIsSelectButton:NO];
    } else {
        sender.selected = YES;
        [cellModel setIsSelectButton:YES];
    }
    [self changeDataMethod];
}

//修改controller中的数据
- (void)changeDataMethod{
    [self reloadData];  //刷新数据
    if (_changeDataBlock) {
        _changeDataBlock();
    }
}




@end
