//
//  PayMentViewController.m
//  Shop
//
//  Created by 朱啸 on 2018/5/8.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "PayMentViewController.h"
#import "PayMentView.h"
#import "UIView+Toast.h"    //toast弹框
#import "DBPayMent.h"
#import "DBOrderDetail.h"
#import "DBOrderList.h"

@interface PayMentViewController ()

@property (strong, nonatomic) PayMentView *payMentView; //支付界面view
@property (strong, nonatomic) UIButton *payButton;  //支付按钮

@end

@implementation PayMentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.payMentView];
    [self.view addSubview:self.payButton];
}


- (PayMentView *)payMentView {
    if (!_payMentView) {
        _payMentView = [[PayMentView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT - 50)];
        _payMentView.backgroundColor = MainColor;
    }
    return _payMentView;
}

- (UIButton *)payButton {
    if (!_payButton) {
        _payButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 350, VIEW_WIDTH - 20, 50)];
        _payButton.backgroundColor = [UIColor orangeColor];
        [_payButton.layer setCornerRadius:20];
        [_payButton setTitle:@"确认支付" forState:UIControlStateNormal];
        [_payButton addTarget:self action:@selector(payButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payButton;
}


- (void) payButtonMethod {
    
    [[DBPayMent sharedInstance] LinkDatabaseAndAddToQueue];
    [[DBOrderDetail sharedInstance] LinkDatabaseAndAddToQueue];
    [[DBOrderList sharedInstance] LinkDatabaseAndAddToQueue];
    NSString *totalPrice = [[DBOrderList sharedInstance] selectTotalPriceWithOrder_Id:self.orderId];
    
    NSString *payType;
    if (_payMentView.aliPayButton.selected) {
        payType = @"支付宝";
        [[DBPayMent sharedInstance] insetOrder_id:self.orderId WithPayType:payType WithPayAccount:@"" WithTotalPrice:totalPrice];
        [[DBOrderList sharedInstance] updateStatusWithOrder_Id:self.orderId WithStaus:@"待发货"];
        [self.view makeToast:@"支付成功！" duration:1.5 position:@"center"];
        //跳转回“我的”页面,并延时1秒执行
        [self performSelector:@selector(popMyViewController) withObject:nil afterDelay:1.5];
        
    }else if (_payMentView.weChatButton.selected) {
        payType = @"微信";
        [[DBPayMent sharedInstance] insetOrder_id:self.orderId WithPayType:payType WithPayAccount:@"" WithTotalPrice:totalPrice];
        [[DBOrderList sharedInstance] updateStatusWithOrder_Id:self.orderId WithStaus:@"待发货"];
        [self.view makeToast:@"支付成功！" duration:1.5 position:@"center"];
        //跳转回“我的”页面,并延时1秒执行
        [self performSelector:@selector(popMyViewController) withObject:nil afterDelay:1.5];
    }else {
        [self.view makeToast:@"请选择支付方式！" duration:1.5 position:@"center"];
    }
    
    [[DBPayMent sharedInstance] selectAllMethodWithOrder_Id:self.orderId];
    [[DBOrderList sharedInstance] selectAllMethod];
    [[DBOrderDetail sharedInstance] selectAllMethodWithOrder_Id:self.orderId];
    
    
}

/**
 跳转回“购物车”页面
 */
- (void)popMyViewController{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
