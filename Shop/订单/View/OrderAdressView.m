//
//  OrderAdressView.m
//  Shop
//
//  Created by 朱啸 on 2018/5/7.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "OrderAdressView.h"


@interface OrderAdressView()

@property (strong, nonatomic) UIImageView *addressImage;  //地址图标

@property (strong, nonatomic) UIImageView *backImage;   //背景button
@end


@implementation OrderAdressView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backImage];
        [self addSubview:self.addressImage];
        [self addSubview:self.addressLabel];
        [self addSubview:self.phoneLabel];
        [self addSubview:self.editAdress];
        [self addSubview:self.consigneeLabel];
//        [self addSubview:self.noAddressLabel];
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    __weak typeof (self) weakSelf = self;
    [_backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [_addressImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(8);
    }];
    
    [_consigneeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.left.equalTo(weakSelf.addressImage.mas_right).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(-80);
        make.height.equalTo(@30);
    }];
    
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.consigneeLabel.mas_top);
        make.right.equalTo(weakSelf.mas_right).offset(-10);
        make.height.mas_equalTo(@30);
    }];
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.addressImage.mas_right).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(-10);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-10);
        make.height.equalTo(@15);
    }];
    
    [_editAdress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-10);
        make.right.equalTo(weakSelf.mas_right).offset(-10);
        make.height.mas_equalTo(@22);
    }];
    
    [_noAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.mas_equalTo(@30);
    }];
}


- (UIImageView *)addressImage{
    if (!_addressImage) {
        _addressImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"位置"]];
    }
    return _addressImage;
}

- (UILabel *)consigneeLabel{
    if (!_consigneeLabel) {
        _consigneeLabel = [[UILabel alloc]init];
        _consigneeLabel.text = @"朱啸";
        _consigneeLabel.textColor = [UIColor grayColor];
        _consigneeLabel.font = [UIFont systemFontOfSize:13.0];
    }
    return _consigneeLabel;
}


- (UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.text = @"徐州工程学院";
        _addressLabel.textColor = [UIColor grayColor];
        _addressLabel.font = [UIFont systemFontOfSize:13.0];
    }
    return _addressLabel;
}

- (UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.text = @"13814437090";
        _phoneLabel.textColor = [UIColor grayColor];
        _phoneLabel.font = [UIFont systemFontOfSize:13.0];
    }
    return _phoneLabel;
}

- (UIButton *)editAdress {
    if (!_editAdress) {
        _editAdress = [[UIButton alloc] init];
//        [_editAdress setTitle:@"编辑地址" forState:UIControlStateNormal];
//        _editAdress.backgroundColor = [UIColor grayColor];
        [_editAdress setImage:[UIImage imageNamed:@"编辑收货地址"] forState:UIControlStateNormal];
        [_editAdress addTarget:self action:@selector(editAdressMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editAdress;
}

- (void) editAdressMethod {
    if (_gotoEditAdress) {
        _gotoEditAdress();
    }
}

- (UIImageView *)backImage{
    if (!_backImage) {
        _backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"地址背景"]];
    }
    return _backImage;
}

- (UILabel *)noAddressLabel {
    if (!_noAddressLabel) {
        _noAddressLabel = [[UILabel alloc]init];
        _noAddressLabel.text = @"您还没有收货地址哟，快去编辑吧";
        _noAddressLabel.textColor = [UIColor grayColor];
        _noAddressLabel.font = [UIFont systemFontOfSize:18.0];
    }
    return _noAddressLabel;

}


@end
