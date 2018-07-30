//
//  NewAdressViewController.m
//  Shop
//
//  Created by 朱啸 on 2018/5/7.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "NewAdressViewController.h"
#import "NewAddressView.h"
#import "DBAddress.h"
#import "NSString+GenerateRandomString.h"
#import "UIView+Toast.h"    //toast弹框

@interface NewAdressViewController ()

@property (strong, nonatomic) NewAddressView *newaddressView;   //新增收货地址view

@end

@implementation NewAdressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.newaddressView];
}

- (NewAddressView *)newaddressView {
    if (!_newaddressView) {
        _newaddressView = [[NewAddressView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT-50)];
        _newaddressView.backgroundColor = MainColor;
        
        __weak typeof (self) weakSelf = self;
        _newaddressView.saveAddress = ^{
            [weakSelf saveAddressMethod];
        };
    }
    return _newaddressView;
}

- (void) saveAddressMethod {
    if ([_newaddressView.consigneeText.text isEqualToString:@""] || _newaddressView.consigneeText.text == nil) {
        [self.view makeToast:@"请输入收货人！" duration:1.5 position:@"center"];
    } else if ([_newaddressView.phoneNumberText.text isEqualToString:@""] || _newaddressView.phoneNumberText.text == nil) {
        [self.view makeToast:@"请输入联系电话！" duration:1.5 position:@"center"];
    } else if ([_newaddressView.addressText.text isEqualToString:@""] || _newaddressView.addressText.text == nil) {
        [self.view makeToast:@"请输入详细地址！" duration:1.5 position:@"center"];
    } else {
        //把收货地址加入到购物车中
        NSString *address_id = [NSString characterLength:8];
        NSString *user_id = [[[[NSUserDefaults standardUserDefaults] valueForKey:@"isLoginArray"] objectAtIndex:0] valueForKey:@"user_name"];
        [[DBAddress sharedInstance] LinkDatabaseAndAddToQueue];
        [[DBAddress sharedInstance] insetAddress_Id:address_id WithUser_Id:user_id WithAddress:_newaddressView.addressText.text WithConsignee:_newaddressView.consigneeText.text WithPhoneNumber:_newaddressView.phoneNumberText.text];
        [[DBAddress sharedInstance] selectAllMethod];
        
        _newaddressView.consigneeText.text = @"";
        _newaddressView.phoneNumberText.text = @"";
        _newaddressView.addressText.text = @"";
        
        [self.view makeToast:@"新增地址成功！" duration:1.5 position:@"center"];
    }
    
}



@end
