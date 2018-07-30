//
//  WaitSendViewController.m
//  Shop
//
//  Created by 朱啸 on 2018/5/11.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "WaitSendViewController.h"
#import "WaitSendView.h"
#import "DBOrderList.h"
#import "DBOrderDetail.h"
#import "ShoppingCartIsNullView.h"

@interface WaitSendViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *mainScroll; //最底层滑动视图
@property (assign, nonatomic) CGFloat viewY;

@end

@implementation WaitSendViewController

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
    [[DBOrderList sharedInstance] selectStatusWithStatus:@"待发货"];
    [[DBOrderDetail sharedInstance] LinkDatabaseAndAddToQueue];
    int i = 0;  //用于View的循环创建
    NSMutableArray *waitSendListArray = [[NSUserDefaults standardUserDefaults] valueForKey:@"ArrayWaitSendList"];
    NSInteger waitSendListArrayCount = waitSendListArray.count;
    //如果存在未付款的订单，再执行if语句
    if (waitSendListArrayCount != 0) {
        while (waitSendListArrayCount > 0) {
            NSArray *productArray = [[DBOrderDetail sharedInstance] selectProduct_IdWithOrder_Id:[[waitSendListArray objectAtIndex:i] valueForKey:@"order_id"]];
            //存储四个“待--”列表中需要显示的商品id,主要用来计数，用于设置tableview的高度
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"WaitProductArray"];
            [[NSUserDefaults standardUserDefaults] setObject:productArray forKey:@"WaitProductArray"];
            
            WaitSendView *waitSendView = [[WaitSendView alloc] initWithFrame:CGRectMake(0, _viewY, VIEW_WIDTH, 135+95*productArray.count)];//115+95*productArray.count
            
            //            waitPayView.cellCount = productArray.count;
            waitSendView.waitSendTable.cellCount = productArray.count;
            waitSendView.waitSendTable.productList = productArray;
            waitSendView.waitSendTable.orderID = [[waitSendListArray objectAtIndex:i] valueForKey:@"order_id"];
            
            
            
//            if (i == 0) {
//                waitSendView.backgroundColor = [UIColor redColor];
//            }else if (i == 1) {
//                waitSendView.backgroundColor = [UIColor blueColor];
//            }else if (i == 2) {
//                waitSendView.backgroundColor = [UIColor yellowColor];
//            }
            
            waitSendView.tag = 200 + i;
            
            
            waitSendView.orderLabel.text = [NSString stringWithFormat:@"订单号：%@",[[waitSendListArray objectAtIndex:i] valueForKey:@"order_id"]];
            waitSendView.priceLabel.text = [NSString stringWithFormat:@"订单总金额：￥%@",[[DBOrderList sharedInstance] selectTotalPriceWithOrder_Id:[[waitSendListArray objectAtIndex:i] valueForKey:@"order_id"]]];
            
            
            [self.mainScroll addSubview:waitSendView];
            _viewY = _viewY + 50 + 115 + 95*productArray.count;
            //            _viewY = _viewY + 300;
            
            _mainScroll.contentSize = CGSizeMake(0, _viewY + 20);  //滑动范围
            i ++;
            waitSendListArrayCount --;
        }
    }else {
        ShoppingCartIsNullView *isNil = [[ShoppingCartIsNullView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT - 100)];
        isNil.cartImage.image = [UIImage imageNamed:@"订单为空"];
        isNil.title1.text = @"您还没有相关的订单";
        isNil.title2.text = @"可以去看看有什么想买的";
        [self.view addSubview:isNil];
    }
}

@end
