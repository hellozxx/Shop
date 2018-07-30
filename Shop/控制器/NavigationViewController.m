//
//  NavigationViewController.m
//  Shop
//
//  Created by 朱啸 on 2018/4/11.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

/**
 保证只对navbar进行一次设置，节约性能
 */
+ (void) initialize{
    //获取NavigationBar
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    //设置naviBar的背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"nav_backImage"] forBarMetrics:(UIBarMetricsDefault)];
    
    //设置导航栏字体样式
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


/**
 让界面中的返回按钮还有底部的Bar消失
 */
- (void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
//    Log(@"调用前viewcontroller个数：%li",self.childViewControllers.count);
    if (self.childViewControllers.count) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"详情界面返回按钮"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(returnViewController) forControlEvents:UIControlEventTouchUpInside];
        backBtn.frame = CGRectMake(0, 0, 30, 30);
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        viewController.navigationItem.leftBarButtonItem = item;
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //这句话必须要在下面， 调用父类
    [super pushViewController:viewController animated:animated];
//    Log(@"调用后viewcontroller个数：%li",self.childViewControllers.count);
}



/**
 返回按钮的单击事件
 */
- (void) returnViewController {
    [self popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
