//
//  MyMessageHeadView.m
//  Shop
//
//  Created by 朱啸 on 2018/4/12.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "MyMessageHeadView.h"
@interface MyMessageHeadView()

@property (strong, nonatomic) UIImageView *headBackImage;   //顶部headview背景图片

@property (strong, nonatomic) UIButton *loginBtn;   //登录Button
@property (strong, nonatomic) UIButton *landingBtn; //注册Button

@property (strong, nonatomic) UIImageView *iconImage;   //头像
@property (strong ,nonatomic) UILabel *userNameLabel;   //用户名
@property (strong, nonatomic) UILabel *lvLabel; //会员等级

@end

@implementation MyMessageHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headBackImage];
        [self addSubview:self.loginBtn];
        [self addSubview:self.landingBtn];
        
        [self addSubview:self.iconImage];
        [self addSubview:self.userNameLabel];
        [self addSubview:self.lvLabel];
    }
    return self;
}


- (void) layoutSubviews{
    [super layoutSubviews];
    __weak typeof (self) weakSelf = self;
    
    [_headBackImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(0, 0, 40, 0));
    }];
    
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX).offset(60);
        make.centerY.equalTo(weakSelf.headBackImage.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(45, 23));
    }];
    
    [_landingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX).offset(-60);
        make.centerY.equalTo(weakSelf.headBackImage.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(45, 23));
    }];
    
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(75, 75));
        make.centerY.equalTo(weakSelf.headBackImage.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(60);
        
    }];
    
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.iconImage.mas_left).offset(100);
        make.height.equalTo(@16);
        make.right.equalTo(weakSelf.mas_right);
        make.top.equalTo(weakSelf.iconImage.mas_top).offset(12);
    }];
    
    [_lvLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.iconImage.mas_left).offset(100);
        make.height.equalTo(@16);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.iconImage.mas_bottom).offset(-12);
    }];
}

- (void) reloadHeadView {
    NSString *loginDic = [[[[NSUserDefaults standardUserDefaults] valueForKey:@"isLoginArray"] objectAtIndex:0] objectForKey:@"ISLOGIN"];
    if ([loginDic isEqualToString:@"login"]) {
        _loginBtn.hidden = YES;
        _landingBtn.hidden = YES;
        _lvLabel.hidden = NO;
        _iconImage.hidden = NO;
        _userNameLabel.hidden = NO;
        _userNameLabel.text = [[[[NSUserDefaults standardUserDefaults] valueForKey:@"isLoginArray"] objectAtIndex:0] objectForKey:@"user_name"];
        _lvLabel.text = [[[[NSUserDefaults standardUserDefaults] valueForKey:@"isLoginArray"] objectAtIndex:0] objectForKey:@"user_type"];;
        
    }else {
        _loginBtn.hidden = NO;
        _landingBtn.hidden = NO;
        _lvLabel.hidden = YES;
        _iconImage.hidden = YES;
        _userNameLabel.hidden = YES;
    }
}

- (UIImageView *)iconImage {
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"用户头像"]];
    }
    return _iconImage;
}

-(UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.text = @"用户名";
    }
    return _userNameLabel;
}

-(UILabel *)lvLabel {
    if (!_lvLabel) {
        _lvLabel = [[UILabel alloc] init];
        _lvLabel.text = @"一级";
    }
    return _lvLabel;
}


- (UIImageView *) headBackImage{
    if (!_headBackImage) {
        _headBackImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"我的背景"]];
    }
    return _headBackImage;
}


- (UIButton *) loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f weight:UIFontWeightRegular];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(pushLoginViewController) forControlEvents:UIControlEventTouchUpInside];
        _loginBtn.titleLabel.textColor = [UIColor whiteColor];
    }
    return _loginBtn;
}

- (UIButton *) landingBtn{
    if (!_landingBtn) {
        _landingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_landingBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_landingBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_landingBtn addTarget:self action:@selector(pushLandingViewController) forControlEvents:UIControlEventTouchUpInside];
        _landingBtn.backgroundColor = [UIColor clearColor];
    }
    return _landingBtn;
}

- (void) pushLoginViewController {
    if (_loginBlock) {
        _loginBlock();
    }
}


- (void) pushLandingViewController {
    if (_landingBlock) {
        _landingBlock();
    }
}


@end
