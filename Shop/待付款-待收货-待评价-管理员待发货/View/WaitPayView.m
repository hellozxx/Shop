//
//  WaitPayView.m
//  Shop
//
//  Created by 朱啸 on 2018/5/10.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "WaitPayView.h"




@interface WaitPayView()

@property (strong, nonatomic) UIImageView *backImage;   //背景


@property (strong, nonatomic) UILabel *lineLabel1;   //横线Label
@property (strong, nonatomic) UILabel *lineLabel2;   //横线Label
@property (strong, nonatomic) UILabel *lineLabel3;   //横线Label




@property (assign, nonatomic) CGFloat backHeight;
@property (assign, nonatomic) CGFloat waitPayTableHeight;



@end

@implementation WaitPayView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        NSArray *waitProductArray = [[NSUserDefaults standardUserDefaults] valueForKey:@"WaitProductArray"];
        self.backHeight = 215 + 95 * waitProductArray.count;
        self.waitPayTableHeight = 95 * waitProductArray.count;
        
        [self addSubview:self.backImage];
        [self addSubview:self.orderLabel];
        [self addSubview:self.afterSaleButton];
        [self addSubview:self.waitPayTable];
        [self addSubview:self.priceLabel];
        [self addSubview:self.payButton];
        [self addSubview:self.lineLabel1];
        [self addSubview:self.lineLabel2];
        [self addSubview:self.lineLabel3];
        [self addSubview:self.addressView];
        [self addSubview:self.courierLabel];
        
        self.waitPayTable.separatorStyle = UITableViewCellEditingStyleNone;     //让tableview不显示分割线
        
        [_backImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(@(self.backHeight));
        }];
        [_waitPayTable mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(@(self.waitPayTableHeight));
        }];
    }
    return self;
}

- (void)layoutSubviews {
    __weak typeof (self) weakSelf = self;
    [_backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(-10);
//        make.height.mas_offset(@210);//===========================================@(weakSelf.backHeight)
    }];
    
    [_orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.backImage.mas_top).offset(10);
        make.left.equalTo(weakSelf.backImage.mas_left).offset(10);
        make.height.mas_equalTo(@20);
    }];
    
    [_afterSaleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orderLabel);
        make.right.equalTo(weakSelf.backImage.mas_right).offset(-10);
        make.size.mas_offset(CGSizeMake(50, 20));
    }];
    
    [_lineLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orderLabel.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.orderLabel.mas_left);
        make.right.equalTo(weakSelf.backImage.mas_right).offset(-10);
        make.height.mas_equalTo(@1);
    }];
    
    [_waitPayTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orderLabel.mas_bottom).offset(11);
        make.left.equalTo(weakSelf.orderLabel.mas_left);
        make.right.equalTo(weakSelf.lineLabel1);
//        make.height.mas_equalTo(@95);//===========================================@(weakSelf.waitPayTableHeight)
    }];
    
    [_lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.waitPayTable.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.orderLabel.mas_left);
        make.right.equalTo(weakSelf.backImage.mas_right).offset(-10);
        make.height.mas_equalTo(@1);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.waitPayTable.mas_bottom).offset(11);
        make.right.equalTo(weakSelf.waitPayTable);
        make.height.mas_equalTo(@20);
    }];
    
    [_lineLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.priceLabel.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.orderLabel.mas_left);
        make.right.equalTo(weakSelf.backImage.mas_right).offset(-10);
        make.height.mas_equalTo(@1);
    }];
    
    [_addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lineLabel3.mas_bottom).offset(10);
        make.right.equalTo(weakSelf.priceLabel);
        make.left.equalTo(weakSelf.orderLabel.mas_left);
        make.height.mas_equalTo(@80);
    }];
    
    [_payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.addressView.mas_bottom).offset(10);
        make.right.equalTo(weakSelf.priceLabel);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    [_courierLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.payButton.mas_top);
        make.left.equalTo(weakSelf.orderLabel.mas_left);
        make.right.equalTo(weakSelf.payButton.mas_left).offset(-5);
        make.height.mas_equalTo(@30);
    }];
    
    
}

- (UIImageView *)backImage {
    if (!_backImage) {
        _backImage = [[UIImageView alloc] init];
        _backImage.backgroundColor = [UIColor whiteColor];
        [_backImage.layer setCornerRadius:10.0];
    }
    return _backImage;
}

- (UILabel *)orderLabel {
    if (!_orderLabel) {
        _orderLabel = [[UILabel alloc] init];
//        _orderLabel.text = [NSString stringWithFormat:@"订单号：%@",self.order_id];
        _orderLabel.font = [UIFont systemFontOfSize:16.0];
    }
    return _orderLabel;
}

- (WaitPayTableView *)waitPayTable {
    if (!_waitPayTable) {
        _waitPayTable = [[WaitPayTableView alloc] init];
        _waitPayTable.backgroundColor = MainColor;
    }
    return _waitPayTable;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
//        _priceLabel.text = [NSString stringWithFormat:@"订单总金额：￥%@",_waitPayTable.price];
        _priceLabel.font = [UIFont systemFontOfSize:16.0];
    }
    return _priceLabel;
}

- (UIButton *)payButton {
    if (!_payButton) {
        _payButton = [[UIButton alloc] init];
        _payButton.backgroundColor = [UIColor orangeColor];
        [_payButton.layer setCornerRadius:15];
        [_payButton addTarget:self action:@selector(payButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payButton;
}

- (UILabel *)lineLabel1 {
    if (!_lineLabel1) {
        _lineLabel1 = [[UILabel alloc] init];
        _lineLabel1.backgroundColor = MainColor;
    }
    return _lineLabel1;
}

- (UILabel *)lineLabel2 {
    if (!_lineLabel2) {
        _lineLabel2 = [[UILabel alloc] init];
        _lineLabel2.backgroundColor = MainColor;
    }
    return _lineLabel2;
}

- (UILabel *)lineLabel3 {
    if (!_lineLabel3) {
        _lineLabel3 = [[UILabel alloc] init];
        _lineLabel3.backgroundColor = MainColor;
    }
    return _lineLabel3;
}

- (void) payButtonMethod {
    if (_payButtonBlock) {
        _payButtonBlock();
    }
}

- (OrderAdressView *)addressView {
    if (!_addressView) {
        _addressView = [[OrderAdressView alloc] init];
        _addressView.editAdress.hidden = YES;   //隐藏编辑收货地址的button
    }
    return _addressView;
}

- (UILabel *)courierLabel {
    if (!_courierLabel) {
        _courierLabel = [[UILabel alloc] init];
        _courierLabel.font = [UIFont systemFontOfSize:16.0];
    }
    return _courierLabel;
}

- (UIButton *)afterSaleButton {
    if (!_afterSaleButton) {
        _afterSaleButton = [[UIButton alloc] init];
        _afterSaleButton.backgroundColor = MainColor;
        [_afterSaleButton setTitle:@"退货" forState:UIControlStateNormal];
        [_afterSaleButton.layer setCornerRadius:10.0];
        _afterSaleButton.hidden = YES;
        [_afterSaleButton addTarget:self action:@selector(afterSaleButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _afterSaleButton;
}

- (void) afterSaleButtonMethod {
    if (_returnProductButtonBlock) {
        _returnProductButtonBlock();
    }
}




@end
