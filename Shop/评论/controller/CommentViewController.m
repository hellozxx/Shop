//
//  CommentViewController.m
//  Shop
//
//  Created by 朱啸 on 2018/5/20.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentView.h"
#import "UIView+Toast.h"    //toast弹框
#import "DBComment.h"
#import "MyViewController.h"

@interface CommentViewController ()

@property (strong, nonatomic) CommentView *commentView;

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainColor;
    [self.view addSubview:self.commentView];
}


- (CommentView *)commentView {
    if (!_commentView) {
        _commentView = [[CommentView alloc] initWithFrame:CGRectMake(0, 50, VIEW_WIDTH, 400)];
        //设置商品图片的显示
        NSArray *productArray = [[NSUserDefaults standardUserDefaults] valueForKey:@"ArryProduct"];
        for (NSDictionary *dic in productArray) {
            if ([[dic valueForKey:@"product_id"] isEqualToString:self.productID]) {
                _commentView.productImage.image = [UIImage imageWithContentsOfFile:[dic valueForKey:@"product_iconimage"]];
            }
        }
        
        //提交按钮的点击事件
        [_commentView.submitButton addTarget:self action:@selector(submitButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentView;
}


- (void) submitButtonMethod {
    if ([_commentView.textView.text isEqualToString:@""]) {
        [self.view makeToast:@"您还没有填写评价" duration:1.5 position:@"center"];
    }else {
        NSString *userID = [[[[NSUserDefaults standardUserDefaults] valueForKey:@"isLoginArray"] objectAtIndex:0] valueForKey:@"user_name"];
        [[DBComment sharedInstance] LinkDatabaseAndAddToQueue];
        [[DBComment sharedInstance] insetText:_commentView.textView.text WithUser_Id:userID WithProduct_Id:_productID WithOrder_Id:_orderID WithForum_Title:@""];
        [self.view makeToast:@"评价成功" duration:1.5 position:@"center"];
        [[DBComment sharedInstance] selectAllMethod];
        
        //跳转回“我的页面”,并延时1.5秒执行
        [self performSelector:@selector(backMethod) withObject:nil afterDelay:1.5];
    }
}

#pragma mark - 点击返回按钮,回到指定页面

- (void)backMethod {
    UINavigationController *navigationVC = self.navigationController;
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    //遍历导航控制器中的控制器
    for (UIViewController *vc in navigationVC.viewControllers) {
        [viewControllers addObject:vc];
        //MyViewController就是你需要返回到指定的控制器名称，这里我需要跳转到MyViewController这个控制器
        if ([vc isKindOfClass:[MyViewController class]]) {
            break;
        }
    }
    //把控制器重新添加到导航控制器
    [navigationVC setViewControllers:viewControllers animated:YES];
    [navigationVC popViewControllerAnimated:YES];
}

@end

















