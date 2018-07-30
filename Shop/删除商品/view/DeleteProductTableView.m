//
//  DeleteProductTableView.m
//  Shop
//
//  Created by 朱啸 on 2018/5/13.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "DeleteProductTableView.h"
#import "DeleteProductTableViewCell.h"
#import "DBProduct.h"
#import "DBProductDetail.h"

@interface DeleteProductTableView()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation DeleteProductTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.bounces = NO;
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 124.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.productArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DeleteProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[DeleteProductTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.productDic = self.productArray[indexPath.row];
    return cell;
}

//tableview点击事件
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    Log(@"我选中的是第%li",(long)indexPath.row);
}

//侧滑删除，tableview自带的方法，IOS8.0之后才可以使用，当然也可以添加两个按钮，block方法写两次就可以了
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *dele = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSString *productID = [self.productArray[indexPath.row] valueForKey:@"product_id"];
        
        //把当前商品从数据库中移除
        [[DBProduct sharedInstance] LinkDatabaseAndAddToQueue];
        [[DBProduct sharedInstance] deleteWithProduct_Id:productID];
        [[DBProduct sharedInstance] selectAllMethod];
        
        [[DBProductDetail sharedInstance] LinkDatabaseAndAddToQueue];
        [[DBProductDetail sharedInstance] deleteWithProduct_Id:productID];
        [[DBProductDetail sharedInstance] selectAllMethod];
        
//        [self changeDataMethod];
        [self reloadData];
        
        [self->_productArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
    }];
    return @[dele];
}

//开启删除的状态
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

@end
