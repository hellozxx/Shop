//
//  AddressTableCell.m
//  Shop
//
//  Created by 朱啸 on 2018/5/7.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "AddressTableCell.h"

@interface AddressTableCell()

@property (strong, nonatomic) UILabel *consigneeLabel;    //收货人姓名
@property (strong, nonatomic) UILabel *phoneNumberLabel;    //收货人手机号码
@property (strong, nonatomic) UILabel *addressLabel;    //收货地址
@property (strong, nonatomic) UIButton *editBtn;    //编辑button


@end

@implementation AddressTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.consigneeLabel];
        [self addSubview:self.phoneNumberLabel];
        [self addSubview:self.addressLabel];
        [self addSubview:self.editBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak typeof (self) weakSelf = self;
    
    [_consigneeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.height.mas_equalTo(@16);
    }];
    [_phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.consigneeLabel.mas_top);
        make.right.equalTo(weakSelf.mas_right).offset(-10);
        make.height.mas_equalTo(@16);
    }];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.consigneeLabel.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.consigneeLabel.mas_left);
        make.height.mas_equalTo(@16);
    }];
    
    [_editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-10);
        make.right.equalTo(weakSelf.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(100, 16));
    }];
}

- (void)setAddressArray:(NSMutableArray *)addressArray {
    _addressArray = addressArray;
    _consigneeLabel.text = [_addressArray valueForKey:@"consignee"];
    _phoneNumberLabel.text = [_addressArray valueForKey:@"phonenumber"];
    _addressLabel.text = [_addressArray valueForKey:@"address"];
}

- (UILabel *)consigneeLabel {
    if (!_consigneeLabel) {
        _consigneeLabel = [[UILabel alloc] init];
        _consigneeLabel.font = [UIFont systemFontOfSize:16.0];
        _consigneeLabel.textColor = [UIColor blackColor];
        _consigneeLabel.text = @"朱啸";
    }
    return _consigneeLabel;
}

- (UILabel *)phoneNumberLabel {
    if (!_phoneNumberLabel) {
        _phoneNumberLabel = [[UILabel alloc] init];
        _phoneNumberLabel.font = [UIFont systemFontOfSize:16.0];
        _phoneNumberLabel.textColor = [UIColor blackColor];
        _phoneNumberLabel.text = @"13814437090";
    }
    return _phoneNumberLabel;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.font = [UIFont systemFontOfSize:16.0];
        _addressLabel.textColor = [UIColor blackColor];
        _addressLabel.text = @"江苏省徐州市云龙区徐州工程学院（中心校区）";
    }
    return _addressLabel;
}

- (UIButton *)editBtn {
    if (!_editBtn) {
        _editBtn = [[UIButton alloc] init];
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_editBtn setImage:[UIImage imageNamed:@"编辑收货地址"] forState:UIControlStateNormal];
    }
    return _editBtn;
}


@end


















