//
//  WaitSendTableView.m
//  Shop
//
//  Created by 朱啸 on 2018/5/11.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "WaitSendTableView.h"
#import "WaitSendTableViewCell.h"
#import "WaitSendView.h"

@interface WaitSendTableView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation WaitSendTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.bounces = NO;
        //        self.order_id = @"123123123123123123";
        //        self.price = @"20988";
        //        self.cellCount = 2;
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    NSArray *productList = [[NSUserDefaults standardUserDefaults] valueForKey:@"WaitProductArray"];
    return _cellCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    WaitSendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[WaitSendTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //    NSArray *productList = [[NSUserDefaults standardUserDefaults] valueForKey:@"WaitProductArray"];
    cell.productid = _productList[indexPath.row];
    
    cell.orderID = _orderID;
    Log(@"WaitPayTableView_orderID = %@",_orderID);
    Log(@"indexPath.row = %ld",(long)indexPath.row);
    return cell;
}

//tableview点击事件
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Log(@"我选中的是第%li",(long)indexPath.row);
}

@end
