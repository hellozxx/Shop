//
//  MyViewController.m
//  Shop
//
//  Created by 朱啸 on 2018/4/11.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "MyViewController.h"
#import "MyMessageTableView.h"  //我的页面展示功能的tableview
#import "MyMessageHeadView.h"   //我的页面tablevi顶部展示登录注册的view
#import "LandingViewController.h"   //注册页面

#import "LoginViewController.h" //登录页面
#import "MyMessageNormalUser.h"
#import "ManagerView.h"

#import "WaitPayViewController.h"
#import "WaitSendViewController.h"

#import "AddProductViewController.h"
#import "DeleteProductViewController.h"
#import "UpdateSearchViewController.h"
#import "AddForumViewController.h"

@interface MyViewController ()

/**
 顶部登录预注册view
 */
@property (strong, nonatomic) MyMessageHeadView *headView;

//@property (strong, nonatomic) MyMessageTableView *messageTable;    //展示功能的列表


@property (strong, nonatomic) MyMessageNormalUser *normalUserView;  //普通用户的View
@property (strong, nonatomic) ManagerView *mangeView;   //管理员的view

@property (strong, nonatomic) UIButton *exitButton; //退出登录的按钮


@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = 0;
    
    //设置背景色
    self.view.backgroundColor = MainColor;

    [self.view addSubview:self.headView];

//    [self.view addSubview:self.messageTable];
//
//    [self addAutoLayout];
    
    [self.view addSubview:self.normalUserView];
    [self isLogin];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //刷新页面--headview显示其他的内容
    [_headView reloadHeadView];
    //刷新页面--退出登录按钮
    [self isLogin];
}

//- (void) addAutoLayout{
//    __weak typeof (self) weakSelf = self;
//
//    //给tableview添加约束
//    [_messageTable mas_makeConstraints:^(MASConstraintMaker *make){
//        make.top.left.right.equalTo(weakSelf.view);
//        make.height.mas_equalTo(600);//??????????????????????????????????????????????????????????????????
////        make.top.equalTo(weakSelf.headView.mas_bottom).offset(35);
//    }];
//}

- (MyMessageHeadView *) headView{
    if (!_headView) {
        _headView = [[MyMessageHeadView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 160)];
        //为了能在注册页面访问导航，注册按钮的单击事件
        __weak typeof (self) weakSelf = self;
        _headView.landingBlock = ^(){
            LandingViewController *landingView = [[LandingViewController alloc] init];
            [weakSelf.navigationController pushViewController:landingView animated:YES];
        };
        _headView.loginBlock = ^(){
            LoginViewController *loginView = [[LoginViewController alloc]init];
            [weakSelf.navigationController pushViewController:loginView animated:YES];
        };
    }
    return _headView;
}



//- (MyMessageTableView *) messageTable{
//    if (!_messageTable) {
//        _messageTable = [[MyMessageTableView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT) style:UITableViewStylePlain];
//
//        __weak typeof (self) weakSelf = self;
//        _messageTable.exitBlock = ^(void) {
//            //删除登录标识
////            [[NSUserDefaults standardUserDefaults] setObject:@"NOTLogin" forKey:@"ISLOGIN"];
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isLoginArray"];
//            //删除购物车详情plist文件
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ArrayShopCartDetial"];
//            //删除购物车plist文件
//            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ArrayShoppingCart"];
//
//            //刷新页面--tablevie显示更多的内容
//            [weakSelf.messageTable reloadData];
//            //刷新页面--headview显示其他的内容
//            [weakSelf.headView reloadHeadView];
//        };
//
//        _messageTable.tableHeaderView = self.headView;
//
//    }
//    return _messageTable;
//}





- (MyMessageNormalUser *)normalUserView {
    if (!_normalUserView) {
        _normalUserView = [[MyMessageNormalUser alloc] initWithFrame:CGRectMake(0, 150, VIEW_WIDTH, 200)];
//        _normalUserView.backgroundColor = MainColor;
        [_normalUserView.payButton addTarget:self action:@selector(payButtonMethod) forControlEvents:UIControlEventTouchUpInside];
        [_normalUserView.sendButton addTarget:self action:@selector(sendButtonMethod) forControlEvents:UIControlEventTouchUpInside];
        [_normalUserView.receiveButton addTarget:self action:@selector(receiveButtonMethod) forControlEvents:UIControlEventTouchUpInside];
        [_normalUserView.commentButton addTarget:self action:@selector(commentButtonMethod) forControlEvents:UIControlEventTouchUpInside];
        [_normalUserView.moreOrderButton addTarget:self action:@selector(moreOrderButtonMethod) forControlEvents:UIControlEventTouchUpInside];
        [_normalUserView.afterSaleButton addTarget:self action:@selector(afterSaleButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _normalUserView;
}

- (void) payButtonMethod {
    WaitPayViewController *pay = [[WaitPayViewController alloc] init];
    pay.waitForWhat = @"待付款";
    [self.navigationController pushViewController:pay animated:YES];
}

- (void) sendButtonMethod {
    WaitSendViewController *send = [[WaitSendViewController alloc] init];
    [self.navigationController pushViewController:send animated:YES];
}

- (void) receiveButtonMethod {
    WaitPayViewController *receive = [[WaitPayViewController alloc] init];
    receive.waitForWhat = @"待收货";
    [self.navigationController pushViewController:receive animated:YES];
}

- (void) commentButtonMethod {
    WaitPayViewController *receive = [[WaitPayViewController alloc] init];
    receive.waitForWhat = @"待评价";
    [self.navigationController pushViewController:receive animated:YES];
}

- (void) moreOrderButtonMethod {
    WaitPayViewController *moreOrder = [[WaitPayViewController alloc] init];
    moreOrder.waitForWhat = @"更多订单";
    [self.navigationController pushViewController:moreOrder animated:YES];
}

- (void) afterSaleButtonMethod {
    WaitPayViewController *afterSaleOrder = [[WaitPayViewController alloc] init];
    afterSaleOrder.waitForWhat = @"待退货";
    [self.navigationController pushViewController:afterSaleOrder animated:YES];
}

- (UIButton *)exitButton {
    if (!_exitButton) {
        _exitButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 500, VIEW_WIDTH - 60, 45)];
        [_exitButton setImage:[UIImage imageNamed:@"我的界面退出登录按钮"] forState:UIControlStateNormal];
        [_exitButton addTarget:self action:@selector(exitButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exitButton;
}

- (ManagerView *)mangeView {
    if (!_mangeView) {
        _mangeView = [[ManagerView alloc] initWithFrame:CGRectMake(0, 280, VIEW_WIDTH, 200)];
        [_mangeView.addProductButton addTarget:self action:@selector(addProductButtonMethod) forControlEvents:UIControlEventTouchUpInside];
        [_mangeView.deleteProductButton addTarget:self action:@selector(deleteProductButtonMethod) forControlEvents:UIControlEventTouchUpInside];
        [_mangeView.updateProductButton addTarget:self action:@selector(updateProductButtonMethod) forControlEvents:UIControlEventTouchUpInside];
        [_mangeView.sendButton addTarget:self action:@selector(managerSendButtonMethod) forControlEvents:UIControlEventTouchUpInside];
        [_mangeView.moreOrderButton addTarget:self action:@selector(managerMoreOrderButtonMethod) forControlEvents:UIControlEventTouchUpInside];
        [_mangeView.afterSaleButton addTarget:self action:@selector(managerAfterSaleButtonMethod) forControlEvents:UIControlEventTouchUpInside];
        [_mangeView.addForumButton addTarget:self action:@selector(addForumButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mangeView;
}

- (void) addProductButtonMethod {
    AddProductViewController *addProduct = [[AddProductViewController alloc] init];
    addProduct.title = @"增加商品";
    [self.navigationController pushViewController:addProduct animated:YES];
}

- (void) deleteProductButtonMethod {
    DeleteProductViewController *deleteProduct = [[DeleteProductViewController alloc] init];
    deleteProduct.title = @"删除商品";
    [self.navigationController pushViewController:deleteProduct animated:YES];
}

- (void) updateProductButtonMethod {
    UpdateSearchViewController *search = [[UpdateSearchViewController alloc] init];
    search.title = @"搜索商品";
    [self.navigationController pushViewController:search animated:YES];
}

- (void) managerSendButtonMethod {
    WaitPayViewController *pay = [[WaitPayViewController alloc] init];
    pay.waitForWhat = @"待发货";
    [self.navigationController pushViewController:pay animated:YES];
}

-  (void) managerAfterSaleButtonMethod {
    WaitPayViewController *afterSale = [[WaitPayViewController alloc] init];
    afterSale.waitForWhat = @"退货申请已提交，等待管理员审核";
    [self.navigationController pushViewController:afterSale animated:YES];
}

- (void) addForumButtonMethod {
    AddForumViewController *addForum = [[AddForumViewController alloc] init];
    [self.navigationController pushViewController:addForum animated:YES];
}

- (void) managerMoreOrderButtonMethod {
    WaitPayViewController *moreOrder = [[WaitPayViewController alloc] init];
    moreOrder.waitForWhat = @"管理员更多订单";
    [self.navigationController pushViewController:moreOrder animated:YES];
}

- (void) isLogin {
    //取出登录状态的字典
    NSString *login = [[[[NSUserDefaults standardUserDefaults] valueForKey:@"isLoginArray"] objectAtIndex:0] objectForKey:@"ISLOGIN"];
    NSString *userType = [[[[NSUserDefaults standardUserDefaults] valueForKey:@"isLoginArray"] objectAtIndex:0] objectForKey:@"user_type"];
    if ([login isEqualToString:@"login"]) {
        [self.view addSubview:self.exitButton];
        if ([userType isEqualToString:@"管理员"]) {
            [self.view addSubview:self.mangeView];
        }
    } else {
        [self.exitButton removeFromSuperview];
    }
}

- (void) exitButtonMethod {
    //删除登录标识
    //            [[NSUserDefaults standardUserDefaults] setObject:@"NOTLogin" forKey:@"ISLOGIN"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isLoginArray"];
    //删除购物车详情plist文件
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ArrayShopCartDetial"];
    //删除购物车plist文件
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ArrayShoppingCart"];
    //删除收货地址plist文件
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"DicAddressSelect"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ArrayAddress"];
    
    //删除订单plist文件
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ArrayUserOrderList"];

    
    //刷新页面--tablevie显示更多的内容
//    [weakSelf.messageTable reloadData];
    //刷新页面--headview显示其他的内容
    [self.headView reloadHeadView];
    [self.exitButton removeFromSuperview];
    [self.mangeView removeFromSuperview];
}


@end




















