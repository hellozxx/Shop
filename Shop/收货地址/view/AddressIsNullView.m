//
//  AddressIsNullView.m
//  Shop
//
//  Created by 朱啸 on 2018/5/7.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "AddressIsNullView.h"
@interface AddressIsNullView()

@property (strong, nonatomic) UIImageView *addressImage;
@property (strong, nonatomic) UILabel *title1;
@property (strong, nonatomic) UILabel *title2;

@end

@implementation AddressIsNullView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.addressImage];
        [self addSubview:self.title1];
        [self addSubview:self.title2];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak typeof (self) weakSelf = self;
    
    
    [_addressImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(128, 128));
        make.top.equalTo(weakSelf.mas_top).offset(80);
        make.centerX.equalTo(weakSelf.mas_centerX);
    }];
    
    [_title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.addressImage.mas_bottom).offset(14);
        make.centerX.equalTo(weakSelf);
        make.height.mas_equalTo(@20);
    }];
    
    [_title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.title1.mas_bottom).offset(22);
        make.centerX.equalTo(weakSelf);
        make.height.mas_equalTo(@16);
    }];
    
}

- (UIImageView *)addressImage {
    if (!_addressImage) {
        _addressImage = [[UIImageView alloc] init];
        _addressImage.image = [UIImage imageNamed:@"收货地址是空的"];
    }
    return _addressImage;
}

- (UILabel *)title1 {
    if (!_title1) {
        _title1 = [[UILabel alloc] init];
        _title1.text = @"目前还没有收货地址哟，快去添加吧";
        _title1.font = [UIFont boldSystemFontOfSize:20.0];
        _title1.textColor = RGB(119, 119, 119);
    }
    return _title1;
}

- (UILabel *)title2 {
    if (!_title2) {
        _title2 = [[UILabel alloc] init];
        _title2.text = @"加入我们，让你拥有无限的乐趣~";
        _title2.font = [UIFont systemFontOfSize:16.0];
        _title2.textColor = RGB(182, 182, 182);
    }
    return _title2;
}


@end
