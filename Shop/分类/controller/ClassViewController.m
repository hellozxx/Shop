//
//  ClassViewController.m
//  Shop
//
//  Created by 朱啸 on 2018/4/11.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "ClassViewController.h"
#import "ClassView.h"
#import "ProductListSearchModel.h"  //搜索出来的商品列表model
#import "MJExtension.h" //mj数据转模型
#import "DBProduct.h"
#import "ClassListViewController.h"
#import "UIView+Toast.h"    //toast弹框

@interface ClassViewController ()

@property (strong, nonatomic) ClassView *classView; //分类的view

@end

@implementation ClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置背景色
    self.view.backgroundColor = MainColor;
    
    UIButton *search = [UIButton buttonWithType:UIButtonTypeCustom];
    [search setTitle:@"分类" forState:UIControlStateNormal];
    search.frame = CGRectMake(0, 0, 60, 30);
    
    [search addTarget:self action:@selector(pushSearchView) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = search;
    [self.view addSubview:self.classView];
    
}

- (ClassView *)classView {
    if (!_classView) {
        _classView = [[ClassView alloc] initWithFrame:CGRectMake(0, 10, VIEW_WIDTH, 250)];
        [_classView.babyButton addTarget:self action:@selector(babyButtonMethod) forControlEvents:UIControlEventTouchUpInside];
        [_classView.ChildButton addTarget:self action:@selector(ChildButtonMethod) forControlEvents:UIControlEventTouchUpInside];
        [_classView.adultButton addTarget:self action:@selector(adultButtonMethod) forControlEvents:UIControlEventTouchUpInside];
        [_classView.cityButton addTarget:self action:@selector(cityButtonMethod) forControlEvents:UIControlEventTouchUpInside];
        [_classView.architectureButton addTarget:self action:@selector(architectureButtonMethod) forControlEvents:UIControlEventTouchUpInside];
        [_classView.ideaButton addTarget:self action:@selector(ideaButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _classView;
}

- (void) babyButtonMethod {
    [[DBProduct sharedInstance] LinkDatabaseAndAddToQueue];
    
    if ([[DBProduct sharedInstance] selectWithProduct_CategoryId:@"学龄前"]) {
        ClassListViewController *classList = [[ClassListViewController alloc] init];
        NSArray *listArray = [ProductListSearchModel mj_objectArrayWithKeyValuesArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"ArryProductClass"]];
        classList.listModel = listArray;
        classList.title = @"学龄前";
        [self.navigationController pushViewController:classList animated:YES];
    }else {
        [self.view makeToast:@"此分类暂时还没有商品呦！" duration:1.5 position:@"center"];
    }
}

- (void) ChildButtonMethod {
    [[DBProduct sharedInstance] LinkDatabaseAndAddToQueue];
    
    if ([[DBProduct sharedInstance] selectWithProduct_CategoryId:@"儿童"]) {
        ClassListViewController *classList = [[ClassListViewController alloc] init];
        NSArray *listArray = [ProductListSearchModel mj_objectArrayWithKeyValuesArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"ArryProductClass"]];
        classList.listModel = listArray;
        classList.title = @"儿童";
        [self.navigationController pushViewController:classList animated:YES];
    }else {
        [self.view makeToast:@"此分类暂时还没有商品呦！" duration:1.5 position:@"center"];
    }
}

- (void) adultButtonMethod {
    [[DBProduct sharedInstance] LinkDatabaseAndAddToQueue];
    
    if ([[DBProduct sharedInstance] selectWithProduct_CategoryId:@"成人"]) {
        ClassListViewController *classList = [[ClassListViewController alloc] init];
        NSArray *listArray = [ProductListSearchModel mj_objectArrayWithKeyValuesArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"ArryProductClass"]];
        classList.listModel = listArray;
        classList.title = @"成人粉丝";
        [self.navigationController pushViewController:classList animated:YES];
    }else {
        [self.view makeToast:@"此分类暂时还没有商品呦！" duration:1.5 position:@"center"];
    }
}

- (void) cityButtonMethod {
    [[DBProduct sharedInstance] LinkDatabaseAndAddToQueue];
    
    if ([[DBProduct sharedInstance] selectWithProduct_CategoryId:@"城市"]) {
        ClassListViewController *classList = [[ClassListViewController alloc] init];
        NSArray *listArray = [ProductListSearchModel mj_objectArrayWithKeyValuesArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"ArryProductClass"]];
        classList.listModel = listArray;
        classList.title = @"乐高城市组";
        [self.navigationController pushViewController:classList animated:YES];
    }else {
        [self.view makeToast:@"此分类暂时还没有商品呦！" duration:1.5 position:@"center"];
    }
}

- (void) architectureButtonMethod {
    [[DBProduct sharedInstance] LinkDatabaseAndAddToQueue];
    
    if ([[DBProduct sharedInstance] selectWithProduct_CategoryId:@"建筑"]) {
        ClassListViewController *classList = [[ClassListViewController alloc] init];
        NSArray *listArray = [ProductListSearchModel mj_objectArrayWithKeyValuesArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"ArryProductClass"]];
        classList.listModel = listArray;
        classList.title = @"乐高建筑系列";
        [self.navigationController pushViewController:classList animated:YES];
    }else {
        [self.view makeToast:@"此分类暂时还没有商品呦！" duration:1.5 position:@"center"];
    }
}


- (void) ideaButtonMethod {
    [[DBProduct sharedInstance] LinkDatabaseAndAddToQueue];
    
    if ([[DBProduct sharedInstance] selectWithProduct_CategoryId:@"创意"]) {
        ClassListViewController *classList = [[ClassListViewController alloc] init];
        NSArray *listArray = [ProductListSearchModel mj_objectArrayWithKeyValuesArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"ArryProductClass"]];
        classList.listModel = listArray;
        classList.title = @"乐高创意百变组";
        [self.navigationController pushViewController:classList animated:YES];
    }else {
        [self.view makeToast:@"此分类暂时还没有商品呦！" duration:1.5 position:@"center"];
    }
}


- (void) pushSearchView {
    UIViewController *viewC = [[UIViewController alloc] init];
    [self.navigationController pushViewController:viewC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
