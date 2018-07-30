//
//  AddressTableView.m
//  Shop
//
//  Created by 朱啸 on 2018/5/7.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "AddressTableView.h"
#import "AddressTableCell.h"
#import "DBAddress.h"
#import "AddressViewController.h"


@interface AddressTableView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation AddressTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.bounces = NO;
        
    }
    return self;
}


- (void)setAddressArray:(NSMutableArray *)addressArray {
    _addressArray = addressArray;
    [self reloadData];  //刷新表单
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSArray *array =[[NSUserDefaults standardUserDefaults] valueForKey:@"ArrayAddress"];
//    [self reloadData];
    return _addressArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    AddressTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[AddressTableCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //把地址数组传给cell
    cell.addressArray = _addressArray[indexPath.row];
    return cell;
}

//tableview点击事件
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self backMtehod];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"DicAddressSelect"]; //先移除之前的plist文件
    //再把当前的数据写入到plist文件中
    [[NSUserDefaults standardUserDefaults] setObject:[self.addressArray objectAtIndex:indexPath.row] forKey:@"DicAddressSelect"];
//    Log(@"我选中的是第%li",indexPath.row);
}

//回到orderviewController
- (void) backMtehod {
    if (_back) {
        _back();
    }
}


//侧滑删除，tableview自带的方法，IOS8.0之后才可以使用，当然也可以添加两个按钮，block方法写两次就可以了
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *dele = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSDictionary *deleteDic = self->_addressArray[indexPath.row];
        
        //把当前商品从数据库中移除
        [[DBAddress sharedInstance] LinkDatabaseAndAddToQueue];
        [[DBAddress sharedInstance] deleteWithAddress_id:[deleteDic valueForKey:@"address_id"]];
        
        [[DBAddress sharedInstance] selectAllMethod];
        
//        self.addressArray = [[NSUserDefaults standardUserDefaults] valueForKey:@"ArrayAddress"];
        [self reloadData];
        [self->_addressArray removeObjectAtIndex:indexPath.row];
        AddressViewController *con = [[AddressViewController alloc] init];
        [con addressISNil];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
    }];
    return @[dele];
}

//开启删除的状态
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


//- ( UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
//    //删除
//    UIContextualAction *deleteRowAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
//        
//                //把当前商品从数据库中移除
//                [[DBAddress sharedInstance] LinkDatabaseAndAddToQueue];
//                [[DBAddress sharedInstance] deleteWithAddress_id:[self.addressArray valueForKey:@"address_id"]];
//        
//                [[DBAddress sharedInstance] selectAllMethod];
//        self.addressArray = [[NSUserDefaults standardUserDefaults] valueForKey:@"ArrayAddress"];
//        completionHandler (YES);
//        [self reloadData];
//    }];
//    deleteRowAction.image = [UIImage imageNamed:@"删除"];
//    deleteRowAction.backgroundColor = [UIColor redColor];
//    
//    UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteRowAction]];
//    return config;
//}

@end












