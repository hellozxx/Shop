//
//  ManageSendView.m
//  Shop
//
//  Created by 朱啸 on 2018/5/13.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "ManageSendView.h"
#import "LMJDropdownMenu.h"

@interface ManageSendView()<LMJDropdownMenuDelegate>

@property (strong, nonatomic) UILabel *sendLabel;
//@property (strong, nonatomic) LMJDropdownMenu * dropdownMenu;   //下拉菜单

@end

@implementation ManageSendView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.sendLabel];
        [self addSubview:self.numberText];
        [self addSubview:self.sendButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak typeof (self) weakSelf = self;
    [_sendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(100);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.right.equalTo(weakSelf.mas_left).offset(80);
        make.height.mas_offset(@30);
    }];
    
    [_numberText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.sendLabel.mas_top);
        make.left.equalTo(weakSelf.sendLabel.mas_right).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(-10);
        make.height.mas_equalTo(@30);
    }];
    
    [_sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.sendLabel.mas_bottom).offset(30);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(VIEW_WIDTH - 60, 50));
    }];
}

- (UITextField *)numberText {
    if (!_numberText) {
        _numberText = [[UITextField alloc] init];
        _numberText.font = [UIFont systemFontOfSize:16.0];
        _numberText.backgroundColor = [UIColor whiteColor];
        [_numberText.layer setCornerRadius:10.0];
    }
    return _numberText;
}

- (UILabel *)sendLabel {
    if (!_sendLabel) {
        _sendLabel = [[UILabel alloc] init];
        _sendLabel.text = @"快递单号";
        _sendLabel.font = [UIFont systemFontOfSize:16.0];
        _sendLabel.backgroundColor = [UIColor whiteColor];
        _sendLabel.layer.cornerRadius = 10;
        _sendLabel.clipsToBounds = YES;
    }
    return _sendLabel;
}

- (UIButton *)sendButton {
    if (!_sendButton) {
        _sendButton = [[UIButton alloc] init];
        [_sendButton setTitle:@"确定" forState:UIControlStateNormal];
        _sendButton.backgroundColor = [UIColor orangeColor];
        [_sendButton.layer setCornerRadius:15.0];
    }
    return _sendButton;
}


@end
