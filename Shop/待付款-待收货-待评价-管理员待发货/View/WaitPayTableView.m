//
//  WaitPayTableView.m
//  Shop
//
//  Created by 朱啸 on 2018/5/10.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "WaitPayTableView.h"
#import "WaitPayTableViewCell.h"
#import "WaitPayView.h"

@interface WaitPayTableView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation WaitPayTableView

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
    WaitPayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[WaitPayTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.productid = _productList[indexPath.row];
    
    cell.orderID = self.orderID;
    
    return cell;
}

//tableview点击事件
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (_commentBtnBlock) {
        _commentBtnBlock(self.productList[indexPath.row]);
    }
    Log(@"我选中的是第%li",(long)indexPath.row);
}



@end
