//
//  ThreeButtonView.m
//  Shop
//
//  Created by 朱啸 on 2018/5/3.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "ThreeButtonView.h"
#import "DBShoppingCart.h"
#import "DBShoppingCartDetail.h"
#import "UIView+Toast.h"    //toast弹框

@interface ThreeButtonView()

@property (strong, nonatomic) UIButton *addBuyCarBtn;   //加入购物车按钮

@end

@implementation ThreeButtonView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.addBuyCarBtn];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    __weak typeof (self) weakSelf = self;
    
    [_addBuyCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.height.mas_equalTo(@35);
    }];
    
    
}

- (UIButton *)addBuyCarBtn {
    if (!_addBuyCarBtn) {
        _addBuyCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBuyCarBtn setImage:[UIImage imageNamed:@"详情界面加入购物车按钮"] forState:UIControlStateNormal];
        [_addBuyCarBtn addTarget:self action:@selector(addProductInShoppingCart) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBuyCarBtn;
}

- (void) addProductInShoppingCart {
    
    NSDictionary *landingDic = [[[NSUserDefaults standardUserDefaults] valueForKey:@"isLoginArray"] objectAtIndex:0];
    if (landingDic.count > 0) {
        [self makeToast:@"加入购物车成功！" duration:1.5 position:@"center"];
        [[DBShoppingCart sharedInstance] LinkDatabaseAndAddToQueue];
        NSString *userID = [[[[NSUserDefaults standardUserDefaults] valueForKey:@"isLoginArray"] objectAtIndex:0] valueForKey:@"user_name"];
        NSString *cartID =  [[DBShoppingCart sharedInstance] selectWithUser_Id:userID];
        [[DBShoppingCartDetail sharedInstance] LinkDatabaseAndAddToQueue];
        [[DBShoppingCartDetail sharedInstance] insetCart_Id:cartID WithProduct_Id:_productID WithNumber:@"1"];
        [[DBShoppingCartDetail sharedInstance] selectAllMethod];
    } else {
        [self makeToast:@"您还没有登录，请先登录！" duration:2 position:@"center"];
    }
    
}

@end

















