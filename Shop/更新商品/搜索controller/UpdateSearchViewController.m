//
//  UpdateSearchViewController.m
//  Shop
//
//  Created by 朱啸 on 2018/5/13.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "UpdateSearchViewController.h"
#import "UpdateListViewController.h"
#import "DBProduct.h"
#import "MJExtension.h" //mj数据转模型
#import "ProductListSearchModel.h"  //搜索出来的商品列表model
#import "UIView+Toast.h"    //toast弹框

@interface UpdateSearchViewController ()<UISearchBarDelegate>

@property (strong, nonatomic) UISearchBar *search;  //搜索框
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation UpdateSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBackItem];
    [self.view addSubview:self.search];
    //添加搜索框
    self.navigationItem.titleView = self.titleLabel;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"搜索商品";
    }
    return _titleLabel;
}

- (void) addBackItem {
    //去除返回按钮
    self.navigationItem.leftBarButtonItem = nil;
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:back];
    self.navigationItem.leftBarButtonItem = backItem;
}

-(UISearchBar *)search {
    if (!_search) {
        _search = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 55)];
        _search.placeholder = @"商品名称";
        [_search becomeFirstResponder];  //一进入就直接进入编辑模式
        _search.showsCancelButton = YES; //显示取消按钮
        _search.delegate = self;
    }
    return _search;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_search becomeFirstResponder];  //一进入就直接进入编辑模式
}

//取消按钮的点击事件
- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];   //先让键盘消失
    [self.navigationController popViewControllerAnimated:YES];
}

//搜索按钮的点击事件
- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [[DBProduct sharedInstance] LinkDatabaseAndAddToQueue];
    
    if ([[DBProduct sharedInstance] selectWithProduct_Name:searchBar.text]) {
        UpdateListViewController *goodsList = [[UpdateListViewController alloc] init];
        NSArray *listArray = [ProductListSearchModel mj_objectArrayWithKeyValuesArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"ArryProductSearch"] ];
        goodsList.listModel = listArray;
        goodsList.title = searchBar.text;
        [searchBar resignFirstResponder];   //先让键盘消失
        [self.navigationController pushViewController:goodsList animated:YES];
    }else {
        [self.view makeToast:@"没有搜索到相关商品，请重新搜索！" duration:1.5 position:@"center"];
        _search.text = @"";
    }
    
    
}

@end
