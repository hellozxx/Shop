//
//  OrderViewController.m
//  Shop
//
//  Created by 朱啸 on 2018/5/7.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderAdressView.h"
#import "OrderTableView.h"
#import "AddressViewController.h"
#import "PayMentViewController.h"
#import "DBOrderList.h"
#import "DBOrderDetail.h"
#import "DBShoppingCartDetail.h"
#import "UIView+Toast.h"    //toast弹框

@interface OrderViewController ()

@property (strong, nonatomic)   OrderAdressView *addressView;   //地址view
@property (strong, nonatomic)   OrderTableView *orderTable; //订单列表view
@property (strong, nonatomic)   UIButton *payButton;    //支付按钮

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.addressView];
    [self.view addSubview:self.orderTable];
    [_orderTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.addressView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
    }];
    [self.view addSubview:self.payButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [self addressShowText];
}


- (OrderAdressView *) addressView {
    if (!_addressView) {
        _addressView = [[OrderAdressView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 80)];
        [self addressShowText];
        __weak typeof (self) weakSelf = self;
        _addressView.gotoEditAdress = ^{
            [weakSelf editAddressMethod];
        };
    }
    return _addressView;
}

//设置order页面中顶部收货地址的显示
- (BOOL) addressShowText {
    //存储收货地址字典
    NSArray *addressArrsy = [[NSUserDefaults standardUserDefaults] objectForKey:@"ArrayAddress"];
    //从cell中选择的地址
    NSDictionary *addressSelect = [[NSUserDefaults standardUserDefaults] objectForKey:@"DicAddressSelect"];
    
    //如果没有选中的地址，则默认为第一个地址，否则设置为选中的地址
    if (addressArrsy == nil || addressArrsy.count == 0) { //收货地址列表为空
        _addressView.consigneeLabel.text = @"";
        _addressView.phoneLabel.text = @"";
        _addressView.addressLabel.text = @"";
        [_addressView addSubview:_addressView.noAddressLabel];
        _addressView.noAddressLabel.hidden = NO;
        return YES;
    } else if (addressSelect == nil) {   //没有选择cell中的收货地址
        //把收货地址列表中的第一个地址设为收货地址
        _addressView.consigneeLabel.text = [addressArrsy[0] valueForKey:@"consignee"];
        _addressView.phoneLabel.text = [addressArrsy[0] valueForKey:@"phonenumber"];
        _addressView.addressLabel.text = [addressArrsy[0] valueForKey:@"address"];
        [_addressView addSubview:_addressView.noAddressLabel];
        _addressView.noAddressLabel.hidden = YES;
        return NO;
    }else {
        //把cell中选择的地址作为收货地址
        _addressView.consigneeLabel.text = [addressSelect valueForKey:@"consignee"];
        _addressView.phoneLabel.text = [addressSelect valueForKey:@"phonenumber"];
        _addressView.addressLabel.text = [addressSelect valueForKey:@"address"];
        [_addressView addSubview:_addressView.noAddressLabel];
        _addressView.noAddressLabel.hidden = YES;
        return YES;
    }
    
}

- (void) editAddressMethod {
    AddressViewController *address = [[AddressViewController alloc] init];
    [self.navigationController pushViewController:address animated:YES];
}

- (OrderTableView *) orderTable {
    if (!_orderTable) {
        _orderTable = [[OrderTableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:(UITableViewStylePlain)];
        _orderTable.orderList = _orderTableData;
    }
    return _orderTable;
}


- (UIButton *)payButton{
    if (!_payButton) {
        _payButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _payButton.backgroundColor = [UIColor orangeColor];
        [_payButton setTitle:@"立即支付" forState:(UIControlStateNormal)];
        _payButton.frame = CGRectMake(VIEW_WIDTH-110, VIEW_HEIGHT-110, 100, 40);
        [_payButton.layer setCornerRadius:10.0];
        [_payButton addTarget:self action:@selector(payMethod) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _payButton;
}

- (void) payMethod {
    
    if (_addressView.noAddressLabel.hidden) {
        NSString *userID = [[[[NSUserDefaults standardUserDefaults] valueForKey:@"isLoginArray"] objectAtIndex:0] valueForKey:@"user_name"];
        
        NSString *price = [NSString stringWithFormat:@"%.2f",self.totalPrice];
        
        [[DBOrderList sharedInstance] LinkDatabaseAndAddToQueue];
        [[DBOrderList sharedInstance] insetWithUser_Id:userID WithTotalPrice:price WithStatus:@"待付款"];
        //    [[DBOrderList sharedInstance] insetWithUser_Id:userID WithStatus:@"待付款"];
        [[DBOrderList sharedInstance] selectAllMethod];
        
        NSString *orderId = [[DBOrderList sharedInstance] selectOrder_IDWithUser_Id:userID];
        
        NSArray *cartdetial = [[NSUserDefaults standardUserDefaults] valueForKey:@"ArrayShopCartDetial"];
        
        [[DBOrderDetail sharedInstance] LinkDatabaseAndAddToQueue];
        [[DBShoppingCartDetail sharedInstance] LinkDatabaseAndAddToQueue];
        
        
        
        //存储收货地址字典
        NSArray *addressArrsy = [[NSUserDefaults standardUserDefaults] objectForKey:@"ArrayAddress"];
        //从cell中选择的地址
        NSDictionary *addressSelect = [[NSUserDefaults standardUserDefaults] objectForKey:@"DicAddressSelect"];
        
        if (addressSelect == nil) { //没有选择cell中的收货地址
            if (addressArrsy.count == 0 || addressArrsy == nil) {   //收货地址列表为空
                [self.view makeToast:@"请选择收货地址！" duration:1.5 position:@"center"];
            }else { //把收货地址列表中的第一个地址设为收货地址
                //遍历购物车中的商品，先把商品添加到订单详情中，然后再去删除购物车中的商品.
                for (NSDictionary *cartDic in cartdetial) {
                    [[DBOrderDetail sharedInstance] insetOrder_Id:orderId WithProduct_Id:[cartDic valueForKey:@"product_id"] WithNumber:[cartDic valueForKey:@"number"] WithReceivingAddress_Id:[addressArrsy[0] valueForKey:@"address_id"] ];
                    [[DBShoppingCartDetail sharedInstance] deleteWithProduct_Id:[cartDic valueForKey:@"product_id"]];
                }
            }
        }else { //把cell中选择的地址作为收货地址
            //遍历购物车中的商品，先把商品添加到订单详情中，然后再去删除购物车中的商品.
            for (NSDictionary *cartDic in cartdetial) {
                [[DBOrderDetail sharedInstance] insetOrder_Id:orderId WithProduct_Id:[cartDic valueForKey:@"product_id"] WithNumber:[cartDic valueForKey:@"number"] WithReceivingAddress_Id:[addressSelect valueForKey:@"address_id"] ];
                [[DBShoppingCartDetail sharedInstance] deleteWithProduct_Id:[cartDic valueForKey:@"product_id"]];
            }
        }
        
        
        [[DBOrderDetail sharedInstance] selectAllMethodWithOrder_Id:orderId];
        [[DBShoppingCartDetail sharedInstance] selectAllMethod];
        
        //跳转到支付页面
        PayMentViewController *pay = [[PayMentViewController alloc] init];
        //把order_id传递给支付页面
        pay.orderId = orderId;
        [self.navigationController pushViewController:pay animated:YES];
    }else {
        [self.view makeToast:@"请选择收货地址！" duration:1.5 position:@"center"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end














