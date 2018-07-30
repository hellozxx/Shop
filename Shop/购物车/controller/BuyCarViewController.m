
//
//  BuyCarViewController.m
//  Shop
//
//  Created by 朱啸 on 2018/4/11.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "BuyCarViewController.h"
#import "DBShoppingCart.h"
#import "DBShoppingCartDetail.h"
#import "ShoppingCartListModel.h"   //购物车列表model
#import "MJExtension.h" //mj数据转模型
#import "ShoppingCartListView.h"    //购物车列表View
#import "PriceView.h"   //显示价格view
#import "ShoppingCartIsNullView.h"  //购物车是空的view
#import "OrderViewController.h"

@interface BuyCarViewController ()

@property (strong, nonatomic) ShoppingCartListView *ShoppingCartListView;  //购物车列表view
@property (strong, nonatomic) PriceView *priceView; //显示价格view
@property (strong, nonatomic) NSMutableArray *tableViewArray;  //存储model的数组

@property (strong, nonatomic) ShoppingCartIsNullView *shoppingCartIsNullView;   //购物车是空的view

@property (assign, nonatomic) CGFloat priceMoney;   //用于计算价格总和


@end

@implementation BuyCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置背景色
//    self.view.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:self.ShoppingCartListView];
    self.ShoppingCartListView.separatorStyle = UITableViewCellEditingStyleNone;     //让tableview不显示分割线
    [self.view addSubview:self.priceView];
    
    
    [_priceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@55);
        make.bottom.equalTo(self.view.mas_bottom).offset(-49);
    }];
    
}

//每次进入页面的时候都重新加载数据，即刷新界面
- (void)viewWillAppear:(BOOL)animated {
    //    Log(@"viewWillAppear");
    [super viewWillAppear:animated];
    [self requestBuyCarData];
}


- (void) requestBuyCarData {
    
    [[DBShoppingCartDetail sharedInstance] selectAllMethod];
    
    //判别登录状态
    NSDictionary *landingDic = [[[NSUserDefaults standardUserDefaults] valueForKey:@"isLoginArray"] objectAtIndex:0];
    if (landingDic.count == 0 || landingDic == nil) {
        [self.view addSubview:self.shoppingCartIsNullView];
        _shoppingCartIsNullView.title1.text = @"还没有登录哟，快去登录吧";
        _shoppingCartIsNullView.title2.text = @"加入我们，让你拥有无限的乐趣";
    } else {    //如果已经登录，则加载正常的购物车
        
//        [self.view willRemoveSubview:self.shoppingCartIsNullView];
        [self.shoppingCartIsNullView removeFromSuperview];
        
        self.tableViewArray = [NSMutableArray array];
        self.tableViewArray = [ShoppingCartListModel mj_objectArrayWithKeyValuesArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"ArrayShopCartDetial"]] ;
        
        //如果购物车中的商品个数大于0，则显示购物车列表
        if (_tableViewArray.count > 0) {
            //Log(@"shoppingCartData : %@",shoppingCartData);
            _ShoppingCartListView.shoppingCartList = [NSMutableArray array];
            _ShoppingCartListView.shoppingCartList = _tableViewArray;
            //Log(@"_ShoppingCartListView.shoppingCartList : %@",_ShoppingCartListView.shoppingCartList);
            [self countPriceMoney];
            
        } else {    //如果购物车中商品个数小于0，则显示购物车是空的
            [self.view addSubview:self.shoppingCartIsNullView];
            _shoppingCartIsNullView.title1.text = @"购物车竟然是空的";
            _shoppingCartIsNullView.title2.text = @"再忙，也要记得买点什么犒劳自己~";
        }
    }
}






- (ShoppingCartListView *)ShoppingCartListView{
    if (!_ShoppingCartListView) {
        _ShoppingCartListView = [[ShoppingCartListView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT - 180) style:(UITableViewStylePlain)];
        
        __weak typeof (self) weakSelf = self;
        //取出购物车列表中更改的数据
        _ShoppingCartListView.changeDataBlock = ^(void) {
            [weakSelf countPriceMoney]; //计算购物车内商品价格总和
//            weakSelf.priceView.priceLabel.text = [NSString stringWithFormat:@"%@",[weakSelf.tableViewArray[0] number]];
//            Log(@"_tableViewArray : %p\nshoppingCartList : %p",weakSelf.tableViewArray,weakSelf.ShoppingCartListView.shoppingCartList);
        };
    }
    return _ShoppingCartListView;
}


//当用户修改购物车列表里面的数据时，上传到数据库中
- (void)changeBuyCarData {
    [[DBShoppingCartDetail sharedInstance] LinkDatabaseAndAddToQueue];
    for (ShoppingCartListModel *model in _tableViewArray) {
        [[DBShoppingCartDetail sharedInstance] updateNumber:model.number WithProduct_Id:model.product_id];
    }
    [[DBShoppingCartDetail sharedInstance] selectAllMethod];
    
}

//计算购物车内商品价格总和
- (void)countPriceMoney{
    _priceMoney = 0.0;
    for (ShoppingCartListModel *model in _tableViewArray) {
        if (model.isSelectButton) {
            _priceMoney += [model.product_price floatValue] * [model.number integerValue];   //计算价格
        }
    }
    _priceView.priceLabel.text = [NSString stringWithFormat:@"%.2f",_priceMoney];
    [self priceAttributedText:_priceMoney];
    [self changeBuyCarData];
}



//拼接字符串，在总价前面加上：合计：￥
- (void)priceAttributedText:(CGFloat)money{
    //当前价格(需要手动添加人民币符号)
    NSString *nowPrice = @"合计：";
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:nowPrice attributes:@{NSForegroundColorAttributeName:[UIColor blackColor],
                                                                                                               NSFontAttributeName:[UIFont systemFontOfSize:12.0]}];
    //过去价格
    NSString *oldString = [NSString stringWithFormat:@"¥%.2lf",money];
    NSMutableAttributedString *oldPrice = [[NSMutableAttributedString alloc]initWithString:oldString attributes:@{NSForegroundColorAttributeName:RGB(230, 46, 37),NSFontAttributeName:[UIFont boldSystemFontOfSize:15.0]
                                                                                                                  }];
    [string insertAttributedString:oldPrice atIndex:string.length];
    _priceView.priceLabel.attributedText = string;
}



- (PriceView *)priceView{
    if (!_priceView) {
        _priceView = [[PriceView alloc]init];   //WithFrame:CGRectMake(0, VIEW_HEIGHT - 165, VIEW_WIDTH, 55)
        _priceView.backgroundColor = [UIColor whiteColor];
        __weak typeof (self) weakSelf = self;
        _priceView.gotoInsert = ^(){
            [weakSelf gotoInsertMethod];
        };
    }
    return _priceView;
}

//去结算按钮的点击事件
- (void)gotoInsertMethod{
    OrderViewController *order = [[OrderViewController alloc] init];
    order.orderTableData = [[NSUserDefaults standardUserDefaults] valueForKey:@"ArrayShopCartDetial"];
    order.totalPrice = self.priceMoney; //把总价格传递过去
    [self.navigationController pushViewController:order animated:YES];
}



- (ShoppingCartIsNullView *)shoppingCartIsNullView {
    if (!_shoppingCartIsNullView) {
        _shoppingCartIsNullView = [[ShoppingCartIsNullView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
        _shoppingCartIsNullView.backgroundColor = [UIColor whiteColor];
    }
    return _shoppingCartIsNullView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end

















