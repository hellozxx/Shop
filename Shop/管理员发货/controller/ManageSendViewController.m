//
//  ManageSendViewController.m
//  Shop
//
//  Created by 朱啸 on 2018/5/13.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "ManageSendViewController.h"
#import "ManageSendView.h"
#import "DBOrderList.h"
#import "DBOrderDetail.h"
#import "UIView+Toast.h"    //toast弹框

@interface ManageSendViewController ()

@property (strong, nonatomic) ManageSendView *sendView;

@end

@implementation ManageSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainColor;
    [self.view addSubview:self.sendView];

}

- (ManageSendView *)sendView {
    if (!_sendView) {
        _sendView = [[ManageSendView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
        [_sendView.sendButton addTarget:self action:@selector(sendButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendView;
}

- (void) sendButtonMethod {
    if ([_sendView.numberText.text isEqualToString:@""]) {
        [self.view makeToast:@"请输入快递单号" duration:2 position:@"center"];
    }else {
        [[DBOrderList sharedInstance] LinkDatabaseAndAddToQueue];
        [[DBOrderDetail sharedInstance] LinkDatabaseAndAddToQueue];
        [[DBOrderList sharedInstance] updateStatusWithOrder_Id:self.orderID WithStaus:@"待收货"];
        [[DBOrderDetail sharedInstance] updateStatusWithOrder_Id:self.orderID WithCourier_Id:_sendView.numberText.text];
        [self.view makeToast:@"发货成功" duration:1.5 position:@"center"];
        //跳转回“我的”页面,并延时1.5秒执行
        [self performSelector:@selector(popMyViewController) withObject:nil afterDelay:1.5];
    }
}

/**
 跳转回“购物车”页面
 */
- (void)popMyViewController{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end









