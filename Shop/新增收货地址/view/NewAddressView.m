//
//  NewAddressView.m
//  Shop
//
//  Created by 朱啸 on 2018/5/7.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "NewAddressView.h"

@interface NewAddressView()

@property (strong, nonatomic) UILabel *consigneeLabel;

@property (strong, nonatomic) UILabel *phoneNumberLabel;

@property (strong, nonatomic) UILabel *addressLabel;

@property (strong, nonatomic) UIButton *saveButton;

@end

@implementation NewAddressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.consigneeLabel];
        [self addSubview:self.consigneeText];
        [self addSubview:self.phoneNumberLabel];
        [self addSubview:self.phoneNumberText];
        [self addSubview:self.addressLabel];
        [self addSubview:self.addressText];
        [self addSubview:self.saveButton];
    }
    return self;
}


- (void) layoutSubviews {
    __weak typeof (self) weakSelf = self;
    [_consigneeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(-(VIEW_WIDTH - 100));
        make.height.mas_equalTo(@30);
    }];
    
    [_consigneeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.consigneeLabel.mas_top);
        make.left.equalTo(weakSelf.consigneeLabel.mas_right).offset(2);
        make.right.equalTo(weakSelf.mas_right).offset(10);
        make.height.mas_equalTo(@30);
    }];
    
    
    [_phoneNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.consigneeLabel.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.consigneeLabel.mas_left);
        make.right.equalTo(weakSelf.consigneeLabel.mas_right);
        make.height.mas_equalTo(@30);
    }];

    [_phoneNumberText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.phoneNumberLabel.mas_top);
        make.left.equalTo(weakSelf.phoneNumberLabel.mas_right).offset(2);
        make.right.equalTo(weakSelf.mas_right).offset(10);
        make.height.mas_equalTo(@30);
    }];

    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.phoneNumberLabel.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.phoneNumberLabel.mas_left);
        make.right.equalTo(weakSelf.consigneeLabel.mas_right);
        make.height.mas_equalTo(@30);
    }];

    [_addressText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.addressLabel.mas_top);
        make.left.equalTo(weakSelf.addressLabel.mas_right).offset(2);
        make.right.equalTo(weakSelf.mas_right).offset(10);
        make.height.mas_equalTo(@80);
    }];

//    [_lineLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.addressLabel.mas_bottom);
//        make.left.equalTo(weakSelf.addressLabel.mas_left);
//        make.right.equalTo(weakSelf.addressText.mas_right);
//        make.height.mas_equalTo(@1);
//    }];
    
    [_saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.addressText.mas_bottom).offset(30);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(VIEW_WIDTH - 40, 40));
    }];
}

- (UILabel *)consigneeLabel {
    if (!_consigneeLabel) {
        _consigneeLabel = [[UILabel alloc] init];
        _consigneeLabel.text = @"收   货  人";
        _consigneeLabel.textColor = [UIColor blackColor];
        _consigneeLabel.font = [UIFont systemFontOfSize:20.0];
        _consigneeLabel.backgroundColor = [UIColor whiteColor];
        _consigneeLabel.layer.cornerRadius = 10;
        _consigneeLabel.clipsToBounds = YES;
    }
    return _consigneeLabel;
}
- (UILabel *)phoneNumberLabel {
    if (!_phoneNumberLabel) {
        _phoneNumberLabel = [[UILabel alloc] init];
        _phoneNumberLabel.text = @"联系电话";
        _phoneNumberLabel.textColor = [UIColor blackColor];
        _phoneNumberLabel.font = [UIFont systemFontOfSize:20.0];
        _phoneNumberLabel.backgroundColor = [UIColor whiteColor];
        _phoneNumberLabel.layer.cornerRadius = 10;
        _phoneNumberLabel.clipsToBounds = YES;
    }
    return _phoneNumberLabel;
}
- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.text = @"详细地址";
        _addressLabel.textColor = [UIColor blackColor];
        _addressLabel.font = [UIFont systemFontOfSize:20.0];
        _addressLabel.backgroundColor = [UIColor whiteColor];
        _addressLabel.layer.cornerRadius = 10;
        _addressLabel.clipsToBounds = YES;
    }
    return _addressLabel;
}


- (UITextField *)consigneeText {
    if (!_consigneeText) {
        _consigneeText = [[UITextField alloc] init];
        _consigneeText.textColor = [UIColor blackColor];
        _consigneeText.font = [UIFont systemFontOfSize:20.0];
        _consigneeText.placeholder = @"请输入收件人姓名";
        _consigneeText.backgroundColor = [UIColor whiteColor];
        _consigneeText.layer.cornerRadius = 10;
        _consigneeText.clipsToBounds = YES;
    }
    return _consigneeText;
}

- (UITextField *)phoneNumberText {
    if (!_phoneNumberText) {
        _phoneNumberText = [[UITextField alloc] init];
        _phoneNumberText.textColor = [UIColor blackColor];
        _phoneNumberText.font = [UIFont systemFontOfSize:20.0];
        _phoneNumberText.placeholder = @"请输入联系电话";
        _phoneNumberText.backgroundColor = [UIColor whiteColor];
        _phoneNumberText.layer.cornerRadius = 10;
        _phoneNumberText.clipsToBounds = YES;
    }
    return _phoneNumberText;
}

- (UITextView *)addressText {
    if (!_addressText) {
        _addressText = [[UITextView alloc] init];
        _addressText.textColor = [UIColor blackColor];
        _addressText.font = [UIFont systemFontOfSize:20.0];
        _phoneNumberText.layer.cornerRadius = 10;
        _phoneNumberText.clipsToBounds = YES;
    }
    return _addressText;
}

- (UIButton *)saveButton {
    if (!_saveButton) {
        _saveButton = [[UIButton alloc] init];
        [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
        [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _saveButton.backgroundColor = [UIColor orangeColor];
        [_saveButton.layer setCornerRadius:20.0];
        [_saveButton addTarget:self action:@selector(saveAddressMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}


- (void)saveAddressMethod {
    if (_saveAddress) {
        _saveAddress();
    }
}


@end

















