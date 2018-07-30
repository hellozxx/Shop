//
//  LandingViewController.m
//  Shop
//
//  Created by 朱啸 on 2018/4/12.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "LandingViewController.h"
#import "LandingInPutView.h"    //用户名密码输入view
#import "DBUser.h"    //数据库文件
#import "UIView+Toast.h"    //toast弹框
#import "NSString+MobilePhone.h"    //正则表达式，验证是否是手机号

@interface LandingViewController ()

@property (strong, nonatomic) LandingInPutView *landingView;   //输入view

@end

@implementation LandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGB(33, 190, 183);
    self.edgesForExtendedLayout = 0;
    
    self.title = @"注册";
    
    
    [self addController];
    
    
    
    
}


/**
 添加控件
 */
-(void) addController {
    [self.view addSubview:self.landingView];
    
    __weak typeof (self) weakSelf = self;
    
    [_landingView mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.equalTo(@600);
        make.left.right.top.equalTo(weakSelf.view);
    }];
    
}

- (LandingInPutView *)landingView {
    if (!_landingView) {
        _landingView = [[LandingInPutView alloc] init];
    }
    
    /**
     用于处理注册
     */
    __weak typeof (self) weakSelf = self;
    _landingView.landingBlock = ^(NSDictionary *dic) {
        if ([weakSelf landingMethod:(dic)]) {
            //定制了延时执行的任务，不会阻塞线程，效率较高（推荐使用
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [weakSelf.navigationController popViewControllerAnimated:YES];
//            });
            
            //跳转回“我的”页面,并延时1秒执行
            [weakSelf performSelector:@selector(popMyViewController) withObject:nil afterDelay:1.0];
        }
    };
    
    return _landingView;
}

/**
 注册验证的方法
 
 @param dic 注册页面传过来的账号和密码的字典
 */
- (BOOL) landingMethod:(NSDictionary *)dic {
    if ([self openDatabase]) {
        if ([self isHavePhoneNum:dic]) {
            [self.view makeToast:@"此账户已存在，请直接登录！" duration:1.5 position:@"center"];
            [self closeDataBase];
            return NO;
        }else {
            if ([NSString isMobileNumber:dic[@"userName"]]) {
                [[DBUser sharedInstance] insetUser_Name:dic[@"userName"] WithUser_PassWord:dic[@"password"] WithUser_Type:@"普通用户"];
                [self.view makeToast:@"注册成功！" duration:1.5 position:@"center"];
                Log(@"注册成功，数据添加成功！");
                [self closeDataBase];
                return YES;
            }else {
                [self.view makeToast:@"请检查是否正确输入手机号码！" duration:1.5 position:@"center"];
                return NO;
            }
            
        }
        
    }else {
        [self.view makeToast:@"注册失败！" duration:1.5 position:@"center"];
        Log(@"注册失败，数据添加失败！");
        [self closeDataBase];
        return NO;
    }
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
 检测user表中是否已经存在此账户
 
 @return YES：此账户已经存在，直接登录    NO：此账户不存在，可以注册
 */
- (BOOL) isHavePhoneNum:(NSDictionary *)dic {
    [[DBUser sharedInstance] LinkDatabaseAndAddToQueue];
    if ([[DBUser sharedInstance] selectWithUser_Name:dic[@"userName"]]) {
        return  YES;
    }else {
        return NO;
    }
    
}


/**
 跳转回“我的”页面
 */
- (void)popMyViewController{
//    [self.navigationController popToViewController:LoginViewController animated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
