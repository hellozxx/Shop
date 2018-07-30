//
//  LandingPutView.m
//  Shop
//
//  Created by 朱啸 on 2018/4/16.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "LandingInPutView.h"

#define mainSize    [UIScreen mainScreen].bounds.size

#define offsetLeftHand      60

#define rectLeftHand        CGRectMake(61-offsetLeftHand, 90, 40, 65)
#define rectLeftHandGone    CGRectMake(mainSize.width / 2 - 100, _vLogin.frame.origin.y - 22, 40, 40)

#define rectRightHand       CGRectMake(_imgLogin.frame.size.width / 2 + 60, 90, 40, 65)
#define rectRightHandGone   CGRectMake(mainSize.width / 2 + 62, _vLogin.frame.origin.y - 22, 40, 40)



@interface LandingInPutView()<UITextFieldDelegate>
{
    JxbLoginShowType showType;
}

@property (strong, nonatomic) UITextField *userNameText;    //手机号text
@property (strong, nonatomic) UITextField *passwordText;    //密码text
@property (strong, nonatomic) UIButton *nextBtn;    //注册button
@property (strong, nonatomic) UIView *vLogin;  //背景
@property (strong, nonatomic) UIImageView *imgLogin;
@property (strong, nonatomic) UIImageView *imgLeftHand;
@property (strong, nonatomic) UIImageView *imgRightHand;
@property (strong, nonatomic) UIImageView *imgLeftHandGone;
@property (strong, nonatomic) UIImageView *imgRightHandGone;

@end


@implementation LandingInPutView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imgLogin];
        [self.imgLogin addSubview:self.imgLeftHand];
        [self.imgLogin addSubview:self.imgRightHand];
        [self addSubview:self.vLogin];
        [self addSubview:self.imgLeftHandGone];
        [self addSubview:self.imgRightHandGone];
        [self.vLogin addSubview:self.userNameText];
        [self.vLogin addSubview:self.passwordText];
        [self.vLogin addSubview:self.nextBtn];
    }
    return self;
}


- (UIView *)vLogin {
    if (!_vLogin) {
        _vLogin = [[UIView alloc] initWithFrame:CGRectMake(15, 110, mainSize.width - 30, 250)];
        _vLogin.layer.borderWidth = 0.5;
        _vLogin.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _vLogin.backgroundColor = [UIColor whiteColor];
        Log(@"查看更多订单查看更多订单查看更多订单查看更多订单查看更多订单查看更多订单");
    }
    return _vLogin;
}

- (UIImageView *)imgLogin {
    if (!_imgLogin) {
        _imgLogin = [[UIImageView alloc] initWithFrame:CGRectMake(mainSize.width / 2 - 211 / 2, 10, 211, 109)];
        _imgLogin.image = [UIImage imageNamed:@"owl-login"];
        _imgLogin.layer.masksToBounds = YES;
        Log(@"111111111111111111111111111111111111111");
    }
    return _imgLogin;
}

- (UIImageView *)imgLeftHand {
    if (!_imgLeftHand) {
        _imgLeftHand = [[UIImageView alloc] initWithFrame:rectLeftHand];
        _imgLeftHand.image = [UIImage imageNamed:@"owl-login-arm-left"];
    }
    return _imgLeftHand;
}

- (UIImageView *)imgRightHand {
    if (!_imgRightHand) {
        _imgRightHand = [[UIImageView alloc] initWithFrame:rectRightHand];
        _imgRightHand.image = [UIImage imageNamed:@"owl-login-arm-right"];
    }
    return _imgRightHand;
}

- (UIImageView *)imgLeftHandGone {
    if (!_imgLeftHandGone) {
        _imgLeftHandGone = [[UIImageView alloc] initWithFrame:rectLeftHandGone];
        _imgLeftHandGone.image = [UIImage imageNamed:@"icon_hand"];
    }
    return _imgLeftHandGone;
}

- (UIImageView *)imgRightHandGone {
    if (!_imgRightHandGone) {
        _imgRightHandGone = [[UIImageView alloc] initWithFrame:rectRightHandGone];
        _imgRightHandGone.image = [UIImage imageNamed:@"icon_hand"];
    }
    return _imgRightHandGone;
}

- (UITextField *)userNameText {
    if (!_userNameText) {
        _userNameText = [[UITextField alloc] initWithFrame:CGRectMake(30, 30, _vLogin.frame.size.width - 60, 44)];
        _userNameText.delegate = self;
        _userNameText.layer.cornerRadius = 5;
        _userNameText.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _userNameText.layer.borderWidth = 0.5;
        _userNameText.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        _userNameText.leftViewMode = UITextFieldViewModeAlways;
        _userNameText.placeholder = @"请输入手机号码";
        UIImageView* imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(11, 11, 22, 22)];
        imgUser.image = [UIImage imageNamed:@"iconfont-user"];
        [_userNameText.leftView addSubview:imgUser];
        [_userNameText addTarget:self action:@selector(userNameTextChangeText:) forControlEvents:UIControlEventEditingChanged];
    }
    return _userNameText;
}

- (UITextField *)passwordText {
    if (!_passwordText) {
        _passwordText = [[UITextField alloc] initWithFrame:CGRectMake(30, 90, _vLogin.frame.size.width - 60, 44)];
        _passwordText.delegate = self;
        _passwordText.layer.cornerRadius = 5;
        _passwordText.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _passwordText.layer.borderWidth = 0.5;
        _passwordText.secureTextEntry = YES;
        _passwordText.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        _passwordText.leftViewMode = UITextFieldViewModeAlways;
        UIImageView* imgPwd = [[UIImageView alloc] initWithFrame:CGRectMake(11, 11, 22, 22)];
        imgPwd.image = [UIImage imageNamed:@"iconfont-password"];
        [_passwordText.leftView addSubview:imgPwd];
        _passwordText.placeholder = @"请设置账号密码";
        [_passwordText addTarget:self action:@selector(passwordTextChangeText:) forControlEvents:UIControlEventEditingChanged];
    }
    return _passwordText;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 150, 300, 50)];
        [_nextBtn setTitle:@"注册" forState:UIControlStateNormal];
        _nextBtn.backgroundColor =  MainColor;//RGB(299, 299, 299);
        _nextBtn.userInteractionEnabled = NO;   //设置此按钮为不可点击状态
        [_nextBtn setTitleColor:RGB(132, 132, 132) forState:UIControlStateNormal];
        [_nextBtn addTarget:self action:@selector(pushNextViewController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}









- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField isEqual:_userNameText]) {
        if (showType != JxbLoginShowType_PASS)
        {
            showType = JxbLoginShowType_USER;
            return;
        }
        showType = JxbLoginShowType_USER;
        [UIView animateWithDuration:0.5 animations:^{
            self->_imgLeftHand.frame = CGRectMake(self->_imgLeftHand.frame.origin.x - offsetLeftHand, self->_imgLeftHand.frame.origin.y + 30, self->_imgLeftHand.frame.size.width, self->_imgLeftHand.frame.size.height);
            
            self->_imgRightHand.frame = CGRectMake(self->_imgRightHand.frame.origin.x + 48, self->_imgRightHand.frame.origin.y + 30, self->_imgRightHand.frame.size.width, self->_imgRightHand.frame.size.height);
            
            
            self->_imgLeftHandGone.frame = CGRectMake(self->_imgLeftHandGone.frame.origin.x - 70, self->_imgLeftHandGone.frame.origin.y, 40, 40);
            
            self->_imgRightHandGone.frame = CGRectMake(self->_imgRightHandGone.frame.origin.x + 30, self->_imgRightHandGone.frame.origin.y, 40, 40);
            
            
        } completion:^(BOOL b) {
        }];
        
    }
    else if ([textField isEqual:_passwordText]) {
        if (showType == JxbLoginShowType_PASS)
        {
            showType = JxbLoginShowType_PASS;
            return;
        }
        showType = JxbLoginShowType_PASS;
        [UIView animateWithDuration:0.5 animations:^{
            self->_imgLeftHand.frame = CGRectMake(self->_imgLeftHand.frame.origin.x + offsetLeftHand, self->_imgLeftHand.frame.origin.y - 30, self->_imgLeftHand.frame.size.width, self->_imgLeftHand.frame.size.height);
            self->_imgRightHand.frame = CGRectMake(self->_imgRightHand.frame.origin.x - 48, self->_imgRightHand.frame.origin.y - 30, self->_imgRightHand.frame.size.width, self->_imgRightHand.frame.size.height);
            
            
            self->_imgLeftHandGone.frame = CGRectMake(self->_imgLeftHandGone.frame.origin.x + 70, self->_imgLeftHandGone.frame.origin.y, 0, 0);
            
            self->_imgRightHandGone.frame = CGRectMake(self->_imgRightHandGone.frame.origin.x - 30, self->_imgRightHandGone.frame.origin.y, 0, 0);
            
        } completion:^(BOOL b) {
        }];
    }
}


#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    //让手机号码输入框的内容限制在11位
    if (textField == _userNameText && range.location > 10) {
        Log(@"userNameText->range.location = %li",range.location);
        return NO;
    }
    return YES;
}

#pragma mark - textChange

/**
 用户名修改内容时调用的方法
 */
- (void) userNameTextChangeText:(UITextField *) textfield {
    Log(@"textfiled.text = %@",textfield.text);
    if (textfield.text.length == 11 && _passwordText.text.length > 6) {
        _nextBtn.backgroundColor = RGB(56, 166, 241);
        _nextBtn.userInteractionEnabled = YES;  //此时按钮可以点击
    }else {
        _nextBtn.backgroundColor = RGB(229, 229, 229);
        _nextBtn.userInteractionEnabled = NO;  //此时按钮不可以点击
    }
}


/**
 密码输入框修改内容时调用的方法

 */
- (void) passwordTextChangeText:(UITextField *) textfield {
    Log(@"textfiled.text = %@",textfield.text);
    if (textfield.text.length > 5 && _userNameText.text.length == 11) {
        _nextBtn.backgroundColor = RGB(56, 166, 241);
        _nextBtn.userInteractionEnabled = YES;  //此时按钮可以点击
    }else {
        _nextBtn.backgroundColor = RGB(229, 229, 229);
        _nextBtn.userInteractionEnabled = NO;  //此时按钮不可以点击
    }
}



/**
 下一步按钮点击事件
 */
- (void) pushNextViewController {
    
    if(_landingBlock){
        _landingBlock(@{@"userName":_userNameText.text,@"password":_passwordText.text});
    }
}



@end


















