//
//  ShoppingCartIsNullView.m
//  Shop
//
//  Created by 朱啸 on 2018/5/6.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "ShoppingCartIsNullView.h"

@interface ShoppingCartIsNullView()



@end


@implementation ShoppingCartIsNullView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.cartImage];
        [self addSubview:self.title1];
        [self addSubview:self.title2];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak typeof (self) weakSelf = self;
    
    
    [_cartImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(128, 128));
        make.top.equalTo(weakSelf.mas_top).offset(80);
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    
    [_title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.cartImage.mas_bottom).offset(14);
        make.centerX.equalTo(weakSelf);
        make.height.mas_equalTo(@20);
    }];
    
    [_title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.title1.mas_bottom).offset(22);
        make.centerX.equalTo(weakSelf);
        make.height.mas_equalTo(@16);
    }];
    
}

- (UIImageView *)cartImage {
    if (!_cartImage) {
        _cartImage = [[UIImageView alloc] init];
        _cartImage.image = [UIImage imageNamed:@"购物车是空的"];
    }
    return _cartImage;
}

- (UILabel *)title1 {
    if (!_title1) {
        _title1 = [[UILabel alloc] init];
//        _title1.text = @"购物车竟然是空的";
        _title1.font = [UIFont boldSystemFontOfSize:20.0];
        _title1.textColor = RGB(119, 119, 119);
    }
    return _title1;
}

- (UILabel *)title2 {
    if (!_title2) {
        _title2 = [[UILabel alloc] init];
//        _title2.text = @"再忙，也要记得买点什么犒劳自己~";
        _title2.font = [UIFont systemFontOfSize:16.0];
        _title2.textColor = RGB(182, 182, 182);
    }
    return _title2;
}

@end
