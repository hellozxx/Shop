//
//  LoginViewController.m
//  Shop
//
//  Created by 朱啸 on 2018/4/17.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "DBUser.h"    //数据库文件
#import "UIView+Toast.h"    //toast弹框



@interface LoginViewController ()
@property (strong, nonatomic) LoginView *loginView; //登录view
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"登录";
    self.view.backgroundColor = RGB(33, 190, 183);
    self.edgesForExtendedLayout = 0;
    [self addController];
}

- (void) addController{
    [self.view addSubview:self.loginView];
    
    __weak typeof (self) weakSelf = self;
    
    [_loginView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.left.right.equalTo(weakSelf.view);
        make.height.equalTo(@600);
    }];
    
}


- (LoginView *) loginView {
    if (!_loginView) {
        _loginView = [[LoginView alloc] init];
        /**
         用于处理登录验证
         */
        __weak typeof (self) weakSelf = self;
//        __block BOOL flag;
        _loginView.loginBlock = ^(NSDictionary *dic) {
            switch ([weakSelf loginMethod:(dic)]) {
                case 0:
                    [weakSelf.view makeToast:@"登录成功！" duration:1.5 position:@"center"];
                    
                    
                    //跳转回“我的”页面,并延时1秒执行
                    [weakSelf performSelector:@selector(popMyViewController) withObject:nil afterDelay:1.0];
//                    flag = YES;
//                    [NSThread sleepForTimeInterval:2.5];
                    
                    break;
                case 1:
                    [weakSelf.view makeToast:@"密码错误！" duration:1.5 position:@"center"];
//                    flag = NO;
                    break;
                case 2:
                    [weakSelf.view makeToast:@"此账号不存在！" duration:1.5 position:@"center"];
//                    flag = NO;
                    break;
                default:
                    [weakSelf.view makeToast:@"程序异常！" duration:1.5 position:@"center"];
//                    flag = NO;
                    Log(@"出现未知错误，请检查代码！");
                    break;
            }
            
            //定制了延时执行的任务，不会阻塞线程，效率较高
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                if (flag) {
//                    //登陆成功之后，自动跳转回“我的”
//                    [weakSelf.navigationController popViewControllerAnimated:YES];
//                }
//            });
        };
    }
    return _loginView;
}


/**
 登录验证的方法

 @param dic 登录页面传过来的账号和密码的字典
 */
- (int) loginMethod:(NSDictionary *)dic {
    Log(@"dic[@'userName']:%@-----dic[@'password']:%@",dic[@"userName"],dic[@"password"]);
    [[DBUser sharedInstance] LinkDatabaseAndAddToQueue];
    return  [[DBUser sharedInstance] selectWithUser_Name:dic[@"userName"] WithUser_Password:dic[@"password"]];
}


/**
 连接数据库
 
 @return 连接的数据库
 */
- (FMDatabase *) linkDataBase {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    //拼接文件名
    NSString *filePath = [cachePath stringByAppendingString:@"Shop.sqlite"];
    FMDatabase *db = [FMDatabase databaseWithPath:filePath];
    return db;
}


/**
 打开数据库
 */
- (BOOL) openDatabase{
    FMDatabase *db = [self linkDataBase];
    if ([db open]) {
        Log(@"数据库打开成功！");
        return YES;
        
    }else{
        Log(@"数据库打开失败！");
        return NO;
    }
}



/**
 关闭数据库
 */
- (void) closeDataBase {
    FMDatabase *db = [self linkDataBase];
    if ([self openDatabase]) {
        [db close];
        Log(@"数据库关闭成功");
    }else {
        Log(@"数据库没有打开呀，我怎么连接！！！");
    }
}



/**
 跳转回“我的”页面
 */
- (void)popMyViewController{
    [self.navigationController popToRootViewControllerAnimated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
