//
//  TabBarViewController.m
//  Shop
//
//  Created by 朱啸 on 2018/4/11.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "TabBarViewController.h"
#import "NavigationViewController.h"
#import "DBObject.h"

@interface TabBarViewController ()

/**
 用来存储从plist文件中获取的数据
 */
@property(strong, nonatomic) NSArray *tabBarMessageArry;

@end

@implementation TabBarViewController

- (NSArray *) tabBarMessageArry{
    if (!_tabBarMessageArry) {
        _tabBarMessageArry = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"TabBarViewController" ofType:@"plist"]];
    }
    return _tabBarMessageArry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //通过appearance统一设置所有的UITabBarItem的文字属性
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:56/255.0 green:165/255.0 blue:241/255.0 alpha:1]} forState:(UIControlStateSelected)];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:(UIControlStateNormal)];
    
    //添加子控制器
    for (NSDictionary *dic in self.tabBarMessageArry) {
        Class viewControllerClass = NSClassFromString(dic[@"tabbarController"]);
        UIViewController *viewController = [[viewControllerClass alloc] init];
        viewController.tabBarItem.image = [UIImage imageNamed:dic[@"tabbarImage"]];
        viewController.tabBarItem.selectedImage = [UIImage imageNamed:dic[@"tabbarSelectImage"]];
//        viewController.tabBarItem.title = dic[@"tabbarTitle"];
        viewController.title = dic[@"tabbarTitle"];
        NavigationViewController *navgation = [[NavigationViewController alloc] initWithRootViewController:viewController];
        [self addChildViewController:navgation];
    }
    
    //----------------------------------------打开数据库并新建表--------------------------------------
    [[DBObject sharedInstance] addDatabaseAndTableMethod];
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end






