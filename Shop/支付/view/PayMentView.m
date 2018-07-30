//
//  PayMentView.m
//  Shop
//
//  Created by 朱啸 on 2018/5/8.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "PayMentView.h"

@interface PayMentView()

@property (strong, nonatomic) UIImageView *topImageView;    //顶部背景图片

@property (strong, nonatomic) UIImageView *backImageView1;  //背景图片1
@property (strong, nonatomic) UIImageView *backImageView2;  //背景图片2

@property (strong, nonatomic) UIImageView *aliPayImage;  //支付宝图标
@property (strong, nonatomic) UIImageView *weChatImage;  //微信图标

@property (strong, nonatomic) UILabel *aliPayLabel; //支付宝label
@property (strong, nonatomic) UILabel *weChatLabel; //微信label


@property (assign, nonatomic) BOOL flag;    //用户判断两个button是否被选中


@end

@implementation PayMentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.topImageView];
        [self addSubview:self.backImageView1];
        [self addSubview:self.backImageView2];
        [self addSubview:self.aliPayImage];
        [self addSubview:self.weChatImage];
        [self addSubview:self.aliPayLabel];
        [self addSubview:self.weChatLabel];
        [self addSubview:self.aliPayButton];
        [self addSubview:self.weChatButton];
        self.flag = YES;
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    __weak typeof (self) weakSelf = self;
    
    [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.left.right.equalTo(weakSelf);
        make.height.mas_offset(@110);
    }];
    
    [_backImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.topImageView.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(-10);
        make.height.mas_equalTo(@90);
    }];
    
    [_aliPayImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.backImageView1.mas_centerY);
        make.left.equalTo(weakSelf.backImageView1.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [_aliPayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.backImageView1.mas_centerY);
        make.left.equalTo(weakSelf.aliPayImage.mas_right).offset(15);
        make.height.mas_equalTo(@30);
    }];
    
    [_aliPayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.backImageView1.mas_centerY);
        make.right.equalTo(weakSelf.backImageView1.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    
    [_backImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.backImageView1.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.backImageView1.mas_left);
        make.right.equalTo(weakSelf.backImageView1.mas_right);
        make.height.mas_equalTo(@90);
    }];
    
    [_weChatImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.backImageView2.mas_centerY);
        make.left.equalTo(weakSelf.backImageView2.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [_weChatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.backImageView2.mas_centerY);
        make.left.equalTo(weakSelf.weChatImage.mas_right).offset(15);
        make.height.mas_equalTo(@30);
    }];
    
    [_weChatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.backImageView2.mas_centerY);
        make.right.equalTo(weakSelf.backImageView2.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
}

- (UIImageView *)topImageView {
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] init];
        _topImageView.image = [UIImage imageNamed:@"支付界面顶部背景图片"];
    }
    return _topImageView;
}

- (UIImageView *)backImageView1 {
    if (!_backImageView1) {
        _backImageView1 = [[UIImageView alloc] init];
        _backImageView1.backgroundColor = [UIColor whiteColor];
        [_backImageView1.layer setCornerRadius:10.0];
    }
    return _backImageView1;
}

- (UIImageView *)backImageView2 {
    if (!_backImageView2) {
        _backImageView2 = [[UIImageView alloc] init];
        _backImageView2.backgroundColor = [UIColor whiteColor];
        [_backImageView2.layer setCornerRadius:10.0];
    }
    return _backImageView2;
}

- (UIImageView *)aliPayImage {
    if (!_aliPayImage) {
        _aliPayImage = [[UIImageView alloc] init];
        _aliPayImage.image = [UIImage imageNamed:@"支付宝图标"];
    }
    return _aliPayImage;
}

- (UIImageView *)weChatImage {
    if (!_weChatImage) {
        _weChatImage = [[UIImageView alloc] init];
        _weChatImage.image = [UIImage imageNamed:@"微信支付图标"];
        _weChatImage.layer.cornerRadius = 10;
         _weChatImage.clipsToBounds = YES;
    }
    return _weChatImage;
}

- (UILabel *)aliPayLabel {
    if (!_aliPayLabel) {
        _aliPayLabel = [[UILabel alloc] init];
        _aliPayLabel.textColor = [UIColor blackColor];
        _aliPayLabel.font = [UIFont systemFontOfSize:20.0];
        _aliPayLabel.text = @"支付宝";
    }
    return _aliPayLabel;
}

- (UILabel *)weChatLabel {
    if (!_weChatLabel) {
        _weChatLabel = [[UILabel alloc] init];
        _weChatLabel.textColor = [UIColor blackColor];
        _weChatLabel.font = [UIFont systemFontOfSize:20.0];
        _weChatLabel.text = @"微信";
    }
    return _weChatLabel;
}

- (UIButton *)aliPayButton {
    if (!_aliPayButton) {
        _aliPayButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_aliPayButton setImage:[UIImage imageNamed:@"购物车界面商品未选中"] forState:UIControlStateNormal];
        [_aliPayButton setImage:[UIImage imageNamed:@"购物车界面商品选中对号按钮"] forState:UIControlStateSelected];
//        _aliPayButton.selected = YES;
        [_aliPayButton addTarget:self action:@selector(btnIsSelect) forControlEvents:UIControlEventTouchUpInside];
    }
    return _aliPayButton;
}

- (UIButton *)weChatButton {
    if (!_weChatButton) {
        _weChatButton = [[UIButton alloc] init];
        [_weChatButton setImage:[UIImage imageNamed:@"购物车界面商品未选中"] forState:UIControlStateNormal];
        [_weChatButton setImage:[UIImage imageNamed:@"购物车界面商品选中对号按钮"] forState:UIControlStateSelected];
//        _weChatButton.selected = YES;
        [_weChatButton addTarget:self action:@selector(btnIsSelect) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weChatButton;
}

- (void) btnIsSelect {
    
    if (self.flag) {
        _aliPayButton.selected = YES;
        _weChatButton.selected = NO;
        self.flag = NO;
    } else {
        _aliPayButton.selected = NO;
        _weChatButton.selected = YES;
        self.flag = YES;
    }

}

@end















