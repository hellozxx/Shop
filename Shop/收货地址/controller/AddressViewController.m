//
//  AddressViewController.m
//  Shop
//
//  Created by 朱啸 on 2018/5/7.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "AddressViewController.h"
#import "AddressTableView.h"
#import "NewAdressViewController.h"
#import "AddressIsNullView.h"
#import "DBAddress.h"
#import "OrderViewController.h"

@interface AddressViewController ()

@property (strong, nonatomic) AddressTableView *addressTable;   //收货地址列表View
@property (strong, nonatomic) AddressIsNullView *addressISNullView; //收货地址为空的view
@property (strong, nonatomic) UIButton *addNewBtn;

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self.view addSubview:self.addNewBtn];
}

- (void)viewWillAppear:(BOOL)animated {
    [self addressISNil];
}
   

//判断收货地址是否为空，显示不同的view
- (void) addressISNil {
    //先取出收货地址
    NSArray *addressArray = [[NSUserDefaults standardUserDefaults] valueForKey:@"ArrayAddress"];
    
    [self.view addSubview:self.addressTable];
    [[DBAddress sharedInstance] LinkDatabaseAndAddToQueue];
    [[DBAddress sharedInstance] selectAllMethod];
    
    //把收货地址传给View--主要是刷新列表
    _addressTable.addressArray = [NSMutableArray array];
    [_addressTable.addressArray addObjectsFromArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"ArrayAddress"]];
    
    //如果收货地址为空，则显示addressISNullView，否则加载addressTable
    if (addressArray.count == 0 || addressArray == nil) {
        [self.addressTable removeFromSuperview];
        [self.view addSubview:self.addressISNullView];
        [_addressISNullView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom).offset(-50);
        }];
    } else {
        
        [self.addressISNullView removeFromSuperview];
        
        [_addressTable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom).offset(-60);
        }];
        [self.addressTable reloadData]; //刷新数据
        [self.addressTable layoutIfNeeded];
    }
}

- (void) freshMethod {
    //==================================================================================================================================
    if (_freshAddress) {
        _freshAddress ();
    }
}

- (AddressTableView *)addressTable {
    if (!_addressTable) {
        _addressTable = [[AddressTableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:(UITableViewStylePlain)];
        
        [[DBAddress sharedInstance] LinkDatabaseAndAddToQueue];
        [[DBAddress sharedInstance] selectAllMethod];
        //把收货地址传给View
        _addressTable.addressArray = [NSMutableArray array];
        [_addressTable.addressArray addObjectsFromArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"ArrayAddress"]];
//        _addressTable.addressArray = [[NSUserDefaults standardUserDefaults] valueForKey:@"ArrayAddress"];
        
        __weak typeof (self) weakSelf = self;
        _addressTable.back = ^{
            [weakSelf backMethod];
        };
    }
    return _addressTable;
}

- (void) backMethod {
    UINavigationController *navigationVC = self.navigationController;
    
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    
    //    遍历导航控制器中的控制器
    
    for (UIViewController *vc in navigationVC.viewControllers) {
        
        [viewControllers addObject:vc];
        
        //OrderViewController就是你需要返回到指定的控制器名称，这里我需要跳转到CourseTableController这个控制器
        
        if ([vc isKindOfClass:[OrderViewController class]]) {
            
            break;
        }
        
    }
    
    //    把控制器重新添加到导航控制器
    
    [navigationVC setViewControllers:viewControllers animated:YES];
}

- (AddressIsNullView *)addressISNullView {
    if (!_addressISNullView) {
        _addressISNullView = [[AddressIsNullView alloc] init];
    }
    return _addressISNullView;
}

- (UIButton *)addNewBtn {
    if (!_addNewBtn) {
        _addNewBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, VIEW_HEIGHT - 120, VIEW_WIDTH-20, 50)];
        [_addNewBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addNewBtn setTitle:@"添加新地址" forState:UIControlStateNormal];
        _addNewBtn.backgroundColor = [UIColor orangeColor];
        [_addNewBtn.layer setCornerRadius:20.0];
        [_addNewBtn addTarget:self action:@selector(addNewMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addNewBtn;
}

//跳转到增加新地址的页面
- (void) addNewMethod {
    NewAdressViewController *newAddress = [[NewAdressViewController alloc] init];
    [self.navigationController pushViewController:newAddress animated:YES];
}

@end
