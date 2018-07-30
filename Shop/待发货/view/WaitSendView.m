//
//  WaitSendView.m
//  Shop
//
//  Created by 朱啸 on 2018/5/11.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "WaitSendView.h"

@interface WaitSendView()

@property (strong, nonatomic) UIImageView *backImage;   //背景

//@property (strong, nonatomic) UIButton *payButton;

@property (strong, nonatomic) UILabel *lineLabel1;   //横线Label
@property (strong, nonatomic) UILabel *lineLabel2;   //横线Label
@property (strong, nonatomic) UILabel *lineLabel3;   //横线Label

@property (assign, nonatomic) CGFloat backHeight;
@property (assign, nonatomic) CGFloat waitPayTableHeight;



@end

@implementation WaitSendView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        NSArray *waitProductArray = [[NSUserDefaults standardUserDefaults] valueForKey:@"WaitProductArray"];
        self.backHeight = 115 + 95 * waitProductArray.count;
        self.waitPayTableHeight = 95 * waitProductArray.count;
        //
        
        
        [self addSubview:self.backImage];
        [self addSubview:self.orderLabel];
        [self addSubview:self.waitSendTable];
        [self addSubview:self.priceLabel];
//        [self addSubview:self.payButton];
        [self addSubview:self.lineLabel1];
        [self addSubview:self.lineLabel2];
        [self addSubview:self.lineLabel3];
        self.waitSendTable.separatorStyle = UITableViewCellEditingStyleNone;     //让tableview不显示分割线
        
        [_backImage mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(@(self.backHeight));
        }];
        [_waitSendTable mas_updateConstraints:^(MASConstraintMaker *make) {
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
    }];
    
    [_orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.backImage.mas_top).offset(10);
        make.left.equalTo(weakSelf.backImage.mas_left).offset(10);
        make.height.mas_equalTo(@20);
    }];
    
    [_lineLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orderLabel.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.orderLabel.mas_left);
        make.right.equalTo(weakSelf.backImage.mas_right).offset(-10);
        make.height.mas_equalTo(@1);
    }];
    
    [_waitSendTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orderLabel.mas_bottom).offset(11);
        make.left.equalTo(weakSelf.orderLabel.mas_left);
        make.right.equalTo(weakSelf.lineLabel1);
    }];
    
    [_lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.waitSendTable.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.orderLabel.mas_left);
        make.right.equalTo(weakSelf.backImage.mas_right).offset(-10);
        make.height.mas_equalTo(@1);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.waitSendTable.mas_bottom).offset(11);
        make.right.equalTo(weakSelf.waitSendTable);
        make.height.mas_equalTo(@20);
    }];
    
    [_lineLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.priceLabel.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.orderLabel.mas_left);
        make.right.equalTo(weakSelf.backImage.mas_right).offset(-10);
        make.height.mas_equalTo(@1);
    }];
    
//    [_payButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.priceLabel.mas_bottom).offset(10);
//        make.right.equalTo(weakSelf.priceLabel);
//        make.size.mas_equalTo(CGSizeMake(100, 30));
//    }];
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

- (WaitSendTableView *)waitSendTable {
    if (!_waitSendTable) {
        _waitSendTable = [[WaitSendTableView alloc] init];
        _waitSendTable.backgroundColor = MainColor;
    }
    return _waitSendTable;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        //        _priceLabel.text = [NSString stringWithFormat:@"订单总金额：￥%@",_waitPayTable.price];
        _priceLabel.font = [UIFont systemFontOfSize:16.0];
    }
    return _priceLabel;
}

//- (UIButton *)payButton {
//    if (!_payButton) {
//        _payButton = [[UIButton alloc] init];
//        [_payButton setTitle:@"立即付款" forState:UIControlStateNormal];
//        _payButton.backgroundColor = [UIColor orangeColor];
//        [_payButton.layer setCornerRadius:15];
//    }
//    return _payButton;
//}

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


@end
