//
//  MyMessageTableView.m
//  Shop
//
//  Created by 朱啸 on 2018/4/12.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "MyMessageTableView.h"
#import "MyMessageTableViewCell.h"  //列表中的自定义cell

#import "MyMessageHeadView.h"

@interface MyMessageTableView()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSArray *messageTableSource;  //message列表需要展示的数据源

@end

@implementation MyMessageTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.bounces = YES; //超过范围不能滚动:NO，如果想要滚动:YES
        self.backgroundColor = MainColor;
    }
    return self;
}

- (NSArray *)messageTableSource{
    if (!_messageTableSource) {
        _messageTableSource = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MyMessageTablePlist" ofType:@"plist"]];
    }
    return _messageTableSource;
}

//tableview代理
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //取出登录状态的字典
    NSString *loginDic = [[[[NSUserDefaults standardUserDefaults] valueForKey:@"isLoginArray"] objectAtIndex:0] objectForKey:@"ISLOGIN"];
    Log(@"============ %@ =============",loginDic);
    //如果取出的字典里面有值得话，则返回6
    if ([loginDic isEqualToString:@"login"]) {
        Log(@"loginDic = %@",loginDic);
        return 6;
    }else {
        return 4;
    }
//    Log(@"loginDic.count = %lu",(unsigned long)loginDic.count);
//    return 4;
}

//tableview代理
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell){
        cell = [[MyMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.sourceDic = self.messageTableSource[indexPath.row];
    
    if (indexPath.row == 3) {
        UIImageView *nextImage = [cell valueForKey:@"nextImage"];
        nextImage.hidden = YES;
        
        UILabel *phoneNum = [[UILabel alloc] init];
        phoneNum.textColor = RGB(123, 124, 120);
        phoneNum.text = @"13814437090";
        [cell addSubview:phoneNum];
        
        
        __weak typeof (cell) weakSelf = cell;
        [phoneNum mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(weakSelf.mas_right).offset(-15);
            make.centerY.equalTo(weakSelf.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(110, 15));
        }];
    }
    return  cell;
}


/**
 退出登录 按钮的view
 */
- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    //取出登录状态的字典
    NSString *loginDic = [[[[NSUserDefaults standardUserDefaults] valueForKey:@"isLoginArray"] objectAtIndex:0] objectForKey:@"ISLOGIN"];
    Log(@"============ %@ =============",loginDic);
    if ([loginDic isEqualToString:@"login"]) {
        UIView *footView = [[UIView alloc] init];
        footView.backgroundColor = MainColor;
        UIButton *exitBtn = [[UIButton alloc] init];
//        exitBtn.frame = CGRectMake(50, 42, VIEW_WIDTH-100, 45);
//        exitBtn.backgroundColor = RGB(56, 145, 241);
        [exitBtn addTarget:self action:@selector(exitBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [exitBtn setImage:[UIImage imageNamed:@"我的界面退出登录按钮"] forState:UIControlStateNormal];
        [footView addSubview:exitBtn];
        [exitBtn mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(footView.mas_left).offset(50);
            make.right.equalTo(footView.mas_right).offset(-50);
            make.height.equalTo(@45);
            make.top.equalTo(footView.mas_top).offset(42);
        }];
        return footView;
    }
    return nil;
}


- (void) exitBtnMethod {
    if (_exitBlock) {
        _exitBlock();
    }
}


//- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 160;
//}
//
//- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    MyMessageHeadView *head = [[MyMessageHeadView alloc] init];
//    return head;
//}

//tableview代理
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    Log(@"====================我的页面tableView的高度：100=====================");
    return 100;
}


//tableview点击事件
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Log(@"我选中的是第%li",indexPath.row);
}

@end
