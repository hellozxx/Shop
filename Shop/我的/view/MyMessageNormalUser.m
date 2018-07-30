//
//  MyMessageNormalUser.m
//  Shop
//
//  Created by 朱啸 on 2018/5/8.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "MyMessageNormalUser.h"

@interface MyMessageNormalUser()

@property (strong, nonatomic) UIImageView *bacImage;    //背景图片

@property (strong, nonatomic) UIImageView *moreOrderImage;  //查看更多订单图片
@property (strong, nonatomic) UIImageView *payImage;    //待付款图片
@property (strong, nonatomic) UIImageView *sendImage;    //待发货图片
@property (strong, nonatomic) UIImageView *receiveImage;    //待收货图片
@property (strong, nonatomic) UIImageView *commentImage;    //待评价图片
@property (strong, nonatomic) UIImageView *afterSaleImage;  //售后图片

@property (strong, nonatomic) UILabel *orderLabel;  //我的订单Label
@property (strong, nonatomic) UILabel *lineLabel;   //横线Label
@property (strong, nonatomic) UILabel *moreOrderLabel;  //查看更多订单Label
@property (strong, nonatomic) UILabel *payLabel;    //待付款Label
@property (strong, nonatomic) UILabel *sendLabel;    //待发货Label
@property (strong, nonatomic) UILabel *receiveLabel;    //待收货Label
@property (strong, nonatomic) UILabel *commentLabel;    //待评价Label
@property (strong, nonatomic) UILabel *afterSaleLabel;  //售后Label





@end

@implementation MyMessageNormalUser

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bacImage];
        
        [self addSubview:self.orderLabel];
        [self addSubview:self.moreOrderLabel];
        [self addSubview:self.moreOrderImage];
        [self addSubview:self.moreOrderButton];
        
        [self addSubview:self.lineLabel];
        
        
        
        [self addSubview:self.payButton];
        [self addSubview:self.payImage];
        [self addSubview:self.payLabel];
        
        [self addSubview:self.sendButton];
        [self addSubview:self.sendImage];
        [self addSubview:self.sendLabel];
        
        [self addSubview:self.receiveButton];
        [self addSubview:self.receiveImage];
        [self addSubview:self.receiveLabel];
        
        [self addSubview:self.commentButton];
        [self addSubview:self.commentImage];
        [self addSubview:self.commentLabel];
        
        [self addSubview:self.afterSaleButton];
        [self addSubview:self.afterSaleImage];
        [self addSubview:self.afterSaleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    __weak typeof (self) weakSelf = self;
    
    [_bacImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(-10);
        make.height.mas_offset(@123);
    }];
    
    [_orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bacImage.mas_top).offset(10);
        make.left.equalTo(weakSelf.bacImage.mas_left).offset(10);
        make.height.mas_equalTo(@26);
    }];
    
    
    [_moreOrderImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.orderLabel.mas_centerY);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    [_moreOrderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.orderLabel.mas_centerY);
        make.right.equalTo(weakSelf.moreOrderImage.mas_left).offset(-2);
        make.height.mas_equalTo(@20);
    }];
    [_moreOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.moreOrderImage.mas_top).offset(-2);
        make.left.equalTo(weakSelf.moreOrderLabel.mas_left).offset(-2);
        make.right.equalTo(weakSelf.moreOrderImage.mas_right).offset(2);
        make.height.mas_equalTo(@24);
    }];
    
    
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orderLabel.mas_bottom).offset(5);
        make.left.right.equalTo(weakSelf.bacImage);
        make.height.mas_equalTo(@1);
    }];
    
    
    
    [_payImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lineLabel.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.bacImage.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [_payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.payImage.mas_bottom).offset(2);
        make.centerX.equalTo(weakSelf.payImage.mas_centerX);
        make.height.mas_equalTo(@26);
    }];
    
    [_payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.payImage.mas_top).offset(-2);
        make.left.equalTo(weakSelf.payImage.mas_left).offset(-2);
        make.size.mas_equalTo(CGSizeMake(70, 100));
    }];
    
    
    
    [_sendImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.payImage.mas_top);
        make.left.equalTo(weakSelf.payImage.mas_right).offset(25);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [_sendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.sendImage.mas_bottom).offset(2);
        make.centerX.equalTo(weakSelf.sendImage.mas_centerX);
        make.height.mas_equalTo(@26);
    }];
    [_sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.sendImage.mas_top).offset(-2);
        make.left.equalTo(weakSelf.sendImage.mas_left).offset(-2);
        make.size.mas_equalTo(CGSizeMake(70, 100));
    }];
    
    

    [_receiveImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.payImage.mas_top);
        make.left.equalTo(weakSelf.sendImage.mas_right).offset(25);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [_receiveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.receiveImage.mas_bottom).offset(2);
        make.centerX.equalTo(weakSelf.receiveImage.mas_centerX);
        make.height.mas_equalTo(@26);
    }];
    [_receiveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.receiveImage.mas_top).offset(-2);
        make.left.equalTo(weakSelf.receiveImage.mas_left).offset(-2);
        make.size.mas_equalTo(CGSizeMake(70, 100));
    }];
    
    

    [_commentImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.payImage.mas_top);
        make.left.equalTo(weakSelf.receiveImage.mas_right).offset(25);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.commentImage.mas_bottom);
        make.centerX.equalTo(weakSelf.commentImage.mas_centerX);
        make.height.mas_equalTo(@26);
    }];
    [_commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.commentImage.mas_top).offset(-2);
        make.left.equalTo(weakSelf.commentImage.mas_left).offset(-2);
        make.size.mas_equalTo(CGSizeMake(70, 100));
    }];
    
    
    [_afterSaleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.payImage.mas_top);
        make.left.equalTo(weakSelf.commentImage.mas_right).offset(25);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [_afterSaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.afterSaleImage.mas_bottom);
        make.centerX.equalTo(weakSelf.afterSaleImage.mas_centerX);
        make.height.mas_equalTo(@26);
    }];
    [_afterSaleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.afterSaleImage.mas_top).offset(-2);
        make.left.equalTo(weakSelf.afterSaleImage.mas_left).offset(-2);
        make.size.mas_equalTo(CGSizeMake(70, 100));
    }];

}


- (UIImageView *)bacImage {
    if (!_bacImage) {
        _bacImage = [[UIImageView alloc] init];
        _bacImage.backgroundColor = [UIColor whiteColor];
        [_bacImage.layer setCornerRadius:10.0];
    }
    return _bacImage;
}

- (UILabel *)orderLabel {
    if (!_orderLabel) {
        _orderLabel = [[UILabel alloc] init];
        _orderLabel.textColor = [UIColor blackColor];
        _orderLabel.font = [UIFont boldSystemFontOfSize:20.0];
        _orderLabel.text = @"我的订单";
    }
    return _orderLabel;
}

- (UILabel *)moreOrderLabel {
    if (!_moreOrderLabel) {
        _moreOrderLabel = [[UILabel alloc] init];
        _moreOrderLabel.textColor = MainColor;
        _moreOrderLabel.font = [UIFont systemFontOfSize:16.0];
        _moreOrderLabel.text = @"查看更多订单";
    }
    return _moreOrderLabel;
}

- (UILabel *)lineLabel {
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = MainColor;
    }
    return _lineLabel;
}

- (UIImageView *)moreOrderImage {
    if (!_moreOrderImage) {
        _moreOrderImage = [[UIImageView alloc] init];
        _moreOrderImage.image = [UIImage imageNamed:@"下一步"];
    }
    return _moreOrderImage;
}

- (UIImageView *)payImage {
    if (!_payImage) {
        _payImage = [[UIImageView alloc] init];
        _payImage.image = [UIImage imageNamed:@"待付款"];
    }
    return _payImage;
}

- (UIImageView *)sendImage {
    if (!_sendImage) {
        _sendImage = [[UIImageView alloc] init];
        _sendImage.image = [UIImage imageNamed:@"待发货"];
    }
    return _sendImage;
}

- (UIImageView *)receiveImage {
    if (!_receiveImage) {
        _receiveImage = [[UIImageView alloc] init];
        _receiveImage.image = [UIImage imageNamed:@"待收货"];
    }
    return _receiveImage;
}

- (UIImageView *)commentImage {
    if (!_commentImage) {
        _commentImage = [[UIImageView alloc] init];
        _commentImage.image = [UIImage imageNamed:@"待评价"];
    }
    return _commentImage;
}

- (UIImageView *)afterSaleImage {
    if (!_afterSaleImage) {
        _afterSaleImage = [[UIImageView alloc] init];
        _afterSaleImage.image = [UIImage imageNamed:@"售后图片"];
    }
    return _afterSaleImage;
}

- (UILabel *)payLabel {
    if (!_payLabel) {
        _payLabel = [[UILabel alloc] init];
        _payLabel.textColor = [UIColor blackColor];
        _payLabel.font = [UIFont systemFontOfSize:14.0];
        _payLabel.text = @"待付款";
    }
    return _payLabel;
}

- (UILabel *)sendLabel {
    if (!_sendLabel) {
        _sendLabel = [[UILabel alloc] init];
        _sendLabel.textColor = [UIColor blackColor];
        _sendLabel.font = [UIFont systemFontOfSize:14.0];
        _sendLabel.text = @"待发货";
    }
    return _sendLabel;
}

- (UILabel *)receiveLabel {
    if (!_receiveLabel) {
        _receiveLabel = [[UILabel alloc] init];
        _receiveLabel.textColor = [UIColor blackColor];
        _receiveLabel.font = [UIFont systemFontOfSize:14.0];
        _receiveLabel.text = @"待收货";
    }
    return _receiveLabel;
}

- (UILabel *)commentLabel {
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.textColor = [UIColor blackColor];
        _commentLabel.font = [UIFont systemFontOfSize:14.0];
        _commentLabel.text = @"待评价";
    }
    return _commentLabel;
}

- (UILabel *)afterSaleLabel {
    if (!_afterSaleLabel) {
        _afterSaleLabel = [[UILabel alloc] init];
        _afterSaleLabel.textColor = [UIColor blackColor];
        _afterSaleLabel.font = [UIFont systemFontOfSize:14.0];
        _afterSaleLabel.text = @"售后";
    }
    return _afterSaleLabel;
}

-(UIButton *)moreOrderButton {
    if (!_moreOrderButton) {
        _moreOrderButton = [[UIButton alloc] init];
    }
    return _moreOrderButton;
}

- (UIButton *)payButton {
    if (!_payButton) {
        _payButton = [[UIButton alloc] init];
    }
    return _payButton;
}

- (UIButton *)sendButton {
    if (!_sendButton) {
        _sendButton = [[UIButton alloc] init];
    }
    return _sendButton;
}

- (UIButton *)receiveButton {
    if (!_receiveButton) {
        _receiveButton = [[UIButton alloc] init];
    }
    return _receiveButton;
}

- (UIButton *)commentButton {
    if (!_commentButton) {
        _commentButton = [[UIButton alloc] init];
    }
    return _commentButton;
}

- (UIButton *)afterSaleButton {
    if (!_afterSaleButton) {
        _afterSaleButton = [[UIButton alloc] init];
    }
    return _afterSaleButton;
}


@end
