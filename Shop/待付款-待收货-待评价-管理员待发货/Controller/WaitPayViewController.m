//
//  WaitPayViewController.m
//  Shop
//
//  Created by 朱啸 on 2018/5/10.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "WaitPayViewController.h"
#import "WaitPayView.h"
#import "DBOrderList.h"
#import "DBOrderDetail.h"
#import "PayMentViewController.h"
#import "ShoppingCartIsNullView.h"
#import "ManageSendViewController.h"
#import "UIView+Toast.h"    //toast弹框
#import "DBAddress.h"
#import "CommentViewController.h"
#import "DBComment.h"


@interface WaitPayViewController ()<UIScrollViewDelegate>

//@property (strong, nonatomic) WaitPayView *waitPayView;   //待付款tableview
@property (strong, nonatomic) UIScrollView *mainScroll; //最底层滑动视图
@property (assign, nonatomic) CGFloat viewY;

@end

@implementation WaitPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainColor;
    [self.view addSubview:self.mainScroll];
    [self viewCount];
}


- (UIScrollView *)mainScroll {
    if (!_mainScroll) {
        _mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT - 50)];
        _mainScroll.contentSize = CGSizeMake(0, 10000);  //滑动范围
        _mainScroll.delegate = self;
    }
    return _mainScroll;
}

- (void) viewCount {
    [[DBOrderList sharedInstance] LinkDatabaseAndAddToQueue];
    [[DBOrderList sharedInstance] selectStatusWithStatus:self.waitForWhat];
    [[DBOrderDetail sharedInstance] LinkDatabaseAndAddToQueue];
    [[DBAddress sharedInstance] LinkDatabaseAndAddToQueue];
    [[DBOrderList sharedInstance] selectAllMethod];
    NSString *waitForWat_Plist;
    if ([self.waitForWhat isEqualToString:@"待付款"]) {
        waitForWat_Plist = @"ArrayWaitPayList";
    }else if ([self.waitForWhat isEqualToString:@"待发货"]){
        waitForWat_Plist = @"ArrayManagerWaitSendList";
    }else if ([self.waitForWhat isEqualToString:@"待收货"]){
        waitForWat_Plist = @"ArrayWaitReceiceList";
    }else if ([self.waitForWhat isEqualToString:@"待评价"]){
        waitForWat_Plist = @"ArrayWaitCommentList";
    }else if ([self.waitForWhat isEqualToString:@"更多订单"]){
        waitForWat_Plist = @"ArrayUserOrderList";   //普通用户的查看更多订单
    }else if ([self.waitForWhat isEqualToString:@"退货申请已提交，等待管理员审核"]) {
        waitForWat_Plist = @"ArrayAfterSaleList";
    }else if ([self.waitForWhat isEqualToString:@"待退货"]) {
        waitForWat_Plist = @"ArrayWaitReturnProductList";
    }else if ([self.waitForWhat isEqualToString:@"管理员更多订单"]) {
        waitForWat_Plist = @"ArrayOrderList";
    }
    
    int i = 0;  //用于View的循环创建
    NSMutableArray *waitPayListArray = [[NSUserDefaults standardUserDefaults] valueForKey:waitForWat_Plist];
    NSInteger waiPayListArrayCount = waitPayListArray.count;
    //如果存在未付款的订单，再执行if语句,否则显示订单为空的页面
    if (waiPayListArrayCount != 0) {
        while (waiPayListArrayCount > 0) {
            NSArray *productArray = [[DBOrderDetail sharedInstance] selectProduct_IdWithOrder_Id:[[waitPayListArray objectAtIndex:i] valueForKey:@"order_id"]];
            //存储四个“待--”列表中需要显示的商品id,主要用来计数，用于设置tableview的高度
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"WaitProductArray"];
            [[NSUserDefaults standardUserDefaults] setObject:productArray forKey:@"WaitProductArray"];

            WaitPayView *waitPayView = [[WaitPayView alloc] initWithFrame:CGRectMake(0, _viewY, VIEW_WIDTH, 235+95*productArray.count)];
            
            if ([self.waitForWhat isEqualToString:@"待付款"]) {
                [waitPayView.payButton setTitle:@"立即付款" forState:UIControlStateNormal];
                waitPayView.payButtonBlock = ^{
                    [self payButtonMethodWithOrderId:[[waitPayListArray objectAtIndex:i] valueForKey:@"order_id"]];
                };
            }else if ([self.waitForWhat isEqualToString:@"待收货"]) {
                [waitPayView.payButton setTitle:@"确认收货" forState:UIControlStateNormal];
                waitPayView.afterSaleButton.hidden = NO;
                //设置快递单号的Label
                waitPayView.courierLabel.text = [NSString stringWithFormat:@"快递单号:%@",[[DBOrderDetail sharedInstance] selectCourier_IdWithOrder_Id:[[waitPayListArray objectAtIndex:i] valueForKey:@"order_id"]]];
                //给退货按钮添加点击事件
                waitPayView.returnProductButtonBlock = ^{
                    [self afterSaleButtonMethodWithorderId:[[waitPayListArray objectAtIndex:i] valueForKey:@"order_id"]];
                };
                
                waitPayView.payButtonBlock = ^{
                    [self receiveButtonMethodWithOrderId:[[waitPayListArray objectAtIndex:i] valueForKey:@"order_id"]];
                };
            }else if ([self.waitForWhat isEqualToString:@"待评价"]) {
                waitPayView.payButton.hidden = YES;
                //设置快递单号的Label
                waitPayView.courierLabel.text = [NSString stringWithFormat:@"快递单号:%@",[[DBOrderDetail sharedInstance] selectCourier_IdWithOrder_Id:[[waitPayListArray objectAtIndex:i] valueForKey:@"order_id"]]];
                
                
                NSArray *orderProductArray = [[DBOrderDetail sharedInstance] selectProduct_IdWithOrder_Id:[[waitPayListArray objectAtIndex:i] valueForKey:@"order_id"]];
                //判断此订单的此商品是否评价过
                [[DBComment sharedInstance] LinkDatabaseAndAddToQueue];
                NSArray *productIDArray = [[DBComment sharedInstance] selectProduct_IDWithOrder_Id:[[waitPayListArray objectAtIndex:i] valueForKey:@"order_id"]];
                if (orderProductArray.count == productIDArray.count) {
                    //如果评价表中的商品数量和订单详情表中的商品数量相等，则更改此订单的状态为“已评价”
                    [[DBOrderList sharedInstance] updateStatusWithOrder_Id:[[waitPayListArray objectAtIndex:i] valueForKey:@"order_id"] WithStaus:@"已评价"];
                }
                
                //tableview中cell的点击事件，跳转至评价页面
                __weak typeof (self) weakSelf = self;
                waitPayView.waitPayTable.commentBtnBlock = ^(NSString *productID) {
                    
                    if (productIDArray == nil || productIDArray.count == 0) {   //此时整个订单里得到商品都没有评价过
                        //跳转至评价页面
                        CommentViewController *comment = [[CommentViewController alloc] init];
                        comment.productID = productID;
                        comment.orderID = [[waitPayListArray objectAtIndex:i] valueForKey:@"order_id"];
                        [weakSelf.navigationController pushViewController:comment animated:YES];
                    }else if([productIDArray containsObject:productID]){ //此cell中的商品是已经评价过的
                        [self.view makeToast:@"此商品已经评价过啦" duration:1.5 position:@"center"];
                    }else {    //此cell中的商品还没有评价，跳转评价页面
                        //跳转至评价页面
                        CommentViewController *comment = [[CommentViewController alloc] init];
                        comment.productID = productID;
                        comment.orderID = [[waitPayListArray objectAtIndex:i] valueForKey:@"order_id"];
                        [weakSelf.navigationController pushViewController:comment animated:YES];
                    }
                };
            }else if ([self.waitForWhat isEqualToString:@"待发货"]) {
                [waitPayView.payButton setTitle:@"去发货" forState:UIControlStateNormal];
                waitPayView.payButtonBlock = ^{
                    [self manageSendButtonMethodWithOrderId:[[waitPayListArray objectAtIndex:i] valueForKey:@"order_id"]];
                };
            }else if ([self.waitForWhat isEqualToString:@"更多订单"]) {
                waitPayView.payButton.backgroundColor = [UIColor whiteColor];
                //设置快递单号的Label
                waitPayView.courierLabel.text = [NSString stringWithFormat:@"快递单号:%@",[[DBOrderDetail sharedInstance] selectCourier_IdWithOrder_Id:[[waitPayListArray objectAtIndex:i] valueForKey:@"order_id"]]];
            }else if ([self.waitForWhat isEqualToString:@"待退货"]) {
                [waitPayView.payButton setTitle:@"去退货" forState:UIControlStateNormal];
                waitPayView.payButtonBlock = ^{
                    [self returnProductMethodWithOrderId:[[waitPayListArray objectAtIndex:i] valueForKey:@"order_id"]];
                };
            }else if ([self.waitForWhat isEqualToString:@"退货申请已提交，等待管理员审核"]) {
                [waitPayView.payButton setTitle:@"审核通过" forState:UIControlStateNormal];
                waitPayView.payButtonBlock = ^{
                    [self afterSaleMethodWithOrderId:[[waitPayListArray objectAtIndex:i] valueForKey:@"order_id"]];
                };
            }else if ([self.waitForWhat isEqualToString:@"管理员更多订单"]) {
                waitPayView.payButton.backgroundColor = [UIColor whiteColor];
                //设置快递单号的Label
                waitPayView.courierLabel.text = [NSString stringWithFormat:@"快递单号:%@",[[DBOrderDetail sharedInstance] selectCourier_IdWithOrder_Id:[[waitPayListArray objectAtIndex:i] valueForKey:@"order_id"]]];
            }
            
            
            //设置收货地址的显示信息
            NSString *addressID = [[DBOrderDetail sharedInstance] selectReceivingAddress_IdWithOrder_Id:[[waitPayListArray objectAtIndex:i] valueForKey:@"order_id"]];
            [[DBAddress sharedInstance] selectAllMethod];
            NSMutableArray *addressArray= [[NSUserDefaults standardUserDefaults] valueForKey:@"ArrayAddress"];
            for (NSMutableDictionary *dic in addressArray) {
                if ([[dic valueForKey:@"address_id"] isEqualToString:addressID]) {
                    waitPayView.addressView.consigneeLabel.text = [dic valueForKey:@"consignee"];
                    waitPayView.addressView.phoneLabel.text = [dic valueForKey:@"phonenumber"];
                    waitPayView.addressView.addressLabel.text = [dic valueForKey:@"address"];
                }
            }
            
            waitPayView.waitPayTable.cellCount = productArray.count;
            waitPayView.waitPayTable.productList = productArray;
            waitPayView.waitPayTable.orderID = [[waitPayListArray objectAtIndex:i] valueForKey:@"order_id"];
            waitPayView.orderID = [[waitPayListArray objectAtIndex:i] valueForKey:@"order_id"];
            
            waitPayView.tag = 100 + i;
            
            waitPayView.orderLabel.text = [NSString stringWithFormat:@"订单号：%@",[[waitPayListArray objectAtIndex:i] valueForKey:@"order_id"]];
            waitPayView.priceLabel.text = [NSString stringWithFormat:@"订单总金额：￥%@",[[DBOrderList sharedInstance] selectTotalPriceWithOrder_Id:[[waitPayListArray objectAtIndex:i] valueForKey:@"order_id"]]];
            
            
            [self.mainScroll addSubview:waitPayView];
            _viewY = _viewY + 50 + 215 + 95*productArray.count;
            
            _mainScroll.contentSize = CGSizeMake(0, _viewY + 20);  //滑动范围
            i ++;
            waiPayListArrayCount --;
        }
    } else {
        ShoppingCartIsNullView *isNil = [[ShoppingCartIsNullView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT - 100)];
        isNil.cartImage.image = [UIImage imageNamed:@"订单为空"];
        isNil.title1.text = @"没有相关的订单";
        isNil.title2.text = @"可以去看看有什么想买的";
        [self.view addSubview:isNil];
    }
}

- (void) payButtonMethodWithOrderId:(NSString *)order_id {
    PayMentViewController *pay = [[PayMentViewController alloc] init];
    pay.orderId = order_id;
    [self.navigationController pushViewController:pay animated:YES];
}

- (void) manageSendButtonMethodWithOrderId:(NSString *)order_id {
    ManageSendViewController *manageSend = [[ManageSendViewController alloc] init];
    manageSend.orderID = order_id;
    [self.navigationController pushViewController:manageSend animated:YES];
}

- (void) receiveButtonMethodWithOrderId:(NSString *)order_id {
    [[DBOrderList sharedInstance] updateStatusWithOrder_Id:order_id WithStaus:@"待评价"];
    [self.view makeToast:@"收货成功" duration:1.5 position:@"center"];
    //跳转回“我的”页面,并延时1.5秒执行
    [self performSelector:@selector(popMyViewController) withObject:nil afterDelay:1.5];
}

- (void) afterSaleButtonMethodWithorderId:(NSString *)order_id {
    [[DBOrderList sharedInstance] updateStatusWithOrder_Id:order_id WithStaus:@"退货申请已提交，等待管理员审核"];
    [self.view makeToast:@"退货申请已提交，请耐心等待管理员的审核" duration:2 position:@"center"];
    //跳转回“我的”页面,并延时1.5秒执行
    [self performSelector:@selector(popMyViewController) withObject:nil afterDelay:2];
}

- (void) returnProductMethodWithOrderId:(NSString *)order_id {
    [[DBOrderList sharedInstance] updateStatusWithOrder_Id:order_id WithStaus:@"退货成功"];
    ManageSendViewController *send = [[ManageSendViewController alloc] init];
    send.orderID = order_id;
    [self.navigationController pushViewController:send animated:YES];
}

- (void) afterSaleMethodWithOrderId:(NSString *)order_id {
    [[DBOrderList sharedInstance] updateStatusWithOrder_Id:order_id WithStaus:@"待退货"];
    [self.view makeToast:@"审核成功" duration:1.5 position:@"center"];
    //跳转回“我的”页面,并延时1.5秒执行
    [self performSelector:@selector(popMyViewController) withObject:nil afterDelay:1.5];
}


/**
 跳转回“我的”页面
 */
- (void)popMyViewController{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end












