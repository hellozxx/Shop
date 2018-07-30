//
//  ManagerView.m
//  Shop
//
//  Created by 朱啸 on 2018/5/12.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "ManagerView.h"

@interface ManagerView()

@property (strong, nonatomic) UIImageView *bacImage;    //背景图片

@property (strong, nonatomic) UIImageView *moreOrderImage;  //查看更多订单图片
@property (strong, nonatomic) UIImageView *addProductImage;    //增加商品图片
@property (strong, nonatomic) UIImageView *deleteProductImage;    //删除商品图片
@property (strong, nonatomic) UIImageView *updateProductImage;    //更新商品图片
@property (strong, nonatomic) UIImageView *sendImage;    //待发货图片
@property (strong, nonatomic) UIImageView *afterSaleImage;  //售后图片
@property (strong, nonatomic) UIImageView *addForumImage;   //增加帖子图片

@property (strong, nonatomic) UILabel *orderLabel;  //我的订单Label
@property (strong, nonatomic) UILabel *lineLabel;   //横线Label
@property (strong, nonatomic) UILabel *moreOrderLabel;  //查看更多订单Label
@property (strong, nonatomic) UILabel *addProductLabel;    //增加商品Label
@property (strong, nonatomic) UILabel *deleteProductLabel;    //删除商品Label
@property (strong, nonatomic) UILabel *updateProductLabel;    //更新商品Label
@property (strong, nonatomic) UILabel *sendLabel;    //待发货Label
@property (strong, nonatomic) UILabel *afterSaleLabel;  //售后Label
@property (strong, nonatomic) UILabel *addForumLabel;   //增加帖子Label





@end

@implementation ManagerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bacImage];
        
        [self addSubview:self.orderLabel];
        [self addSubview:self.moreOrderLabel];
        [self addSubview:self.moreOrderImage];
        [self addSubview:self.moreOrderButton];
        
        [self addSubview:self.lineLabel];
        
        
        
        [self addSubview:self.addProductButton];
        [self addSubview:self.addProductImage];
        [self addSubview:self.addProductLabel];
        
        [self addSubview:self.deleteProductButton];
        [self addSubview:self.deleteProductImage];
        [self addSubview:self.deleteProductLabel];
        
        [self addSubview:self.updateProductButton];
        [self addSubview:self.updateProductImage];
        [self addSubview:self.updateProductLabel];
        
        [self addSubview:self.sendButton];
        [self addSubview:self.sendImage];
        [self addSubview:self.sendLabel];
        
        [self addSubview:self.afterSaleButton];
        [self addSubview:self.afterSaleImage];
        [self addSubview:self.afterSaleLabel];
        
        [self addSubview:self.addForumButton];
        [self addSubview:self.addForumImage];
        [self addSubview:self.addForumLabel];
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
        make.height.mas_offset(@200);
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
    
    
    
    [_addProductImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.lineLabel.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.bacImage.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [_addProductLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.addProductImage.mas_bottom).offset(2);
        make.centerX.equalTo(weakSelf.addProductImage.mas_centerX);
        make.height.mas_equalTo(@26);
    }];
    [_addProductButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.addProductImage.mas_top).offset(-2);
        make.left.equalTo(weakSelf.addProductImage.mas_left).offset(-2);
        make.size.mas_equalTo(CGSizeMake(70, 100));
    }];
    
    
    
    [_deleteProductImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.addProductImage.mas_top);
        make.left.equalTo(weakSelf.addProductImage.mas_right).offset(25);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [_deleteProductLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.deleteProductImage.mas_bottom).offset(2);
        make.centerX.equalTo(weakSelf.deleteProductImage.mas_centerX);
        make.height.mas_equalTo(@26);
    }];
    [_deleteProductButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.deleteProductImage.mas_top).offset(-2);
        make.left.equalTo(weakSelf.deleteProductImage.mas_left).offset(-2);
        make.size.mas_equalTo(CGSizeMake(70, 100));
    }];
    
    

    [_updateProductImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.addProductImage.mas_top);
        make.left.equalTo(weakSelf.deleteProductImage.mas_right).offset(25);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [_updateProductLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.updateProductImage.mas_bottom).offset(2);
        make.centerX.equalTo(weakSelf.updateProductImage.mas_centerX);
        make.height.mas_equalTo(@26);
    }];
    [_updateProductButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.updateProductImage.mas_top).offset(-2);
        make.left.equalTo(weakSelf.updateProductImage.mas_left).offset(-2);
        make.size.mas_equalTo(CGSizeMake(70, 100));
    }];
    
    
    
    [_sendImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.addProductImage.mas_top);
        make.left.equalTo(weakSelf.updateProductImage.mas_right).offset(25);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [_sendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.sendImage.mas_bottom);
        make.centerX.equalTo(weakSelf.sendImage.mas_centerX);
        make.height.mas_equalTo(@26);
    }];
    [_sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.sendImage.mas_top).offset(-2);
        make.left.equalTo(weakSelf.sendImage.mas_left).offset(-2);
        make.size.mas_equalTo(CGSizeMake(70, 100));
    }];
    
    
    [_afterSaleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.addProductImage.mas_top);
        make.left.equalTo(weakSelf.sendImage.mas_right).offset(25);
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
    
    
    [_addForumImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.addProductLabel.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.addProductImage.mas_left);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [_addForumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.addForumImage.mas_bottom);
        make.centerX.equalTo(weakSelf.addForumImage.mas_centerX);
        make.height.mas_equalTo(@26);
    }];
    [_addForumButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.addForumImage.mas_top).offset(-2);
        make.left.equalTo(weakSelf.addForumImage.mas_left).offset(-2);
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
        _orderLabel.text = @"所有订单";
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

- (UIImageView *)addProductImage {
    if (!_addProductImage) {
        _addProductImage = [[UIImageView alloc] init];
        _addProductImage.image = [UIImage imageNamed:@"添加商品"];
    }
    return _addProductImage;
}

- (UIImageView *)deleteProductImage {
    if (!_deleteProductImage) {
        _deleteProductImage = [[UIImageView alloc] init];
        _deleteProductImage.image = [UIImage imageNamed:@"删除商品"];
    }
    return _deleteProductImage;
}

- (UIImageView *)updateProductImage {
    if (!_updateProductImage) {
        _updateProductImage = [[UIImageView alloc] init];
        _updateProductImage.image = [UIImage imageNamed:@"更新商品"];
    }
    return _updateProductImage;
}

- (UIImageView *)sendImage {
    if (!_sendImage) {
        _sendImage = [[UIImageView alloc] init];
        _sendImage.image = [UIImage imageNamed:@"待发货"];
    }
    return _sendImage;
}

- (UIImageView *)afterSaleImage {
    if (!_afterSaleImage) {
        _afterSaleImage = [[UIImageView alloc] init];
        _afterSaleImage.image = [UIImage imageNamed:@"售后图片"];
    }
    return _afterSaleImage;
}

- (UIImageView *)addForumImage {
    if (!_addForumImage) {
        _addForumImage = [[UIImageView alloc] init];
        _addForumImage.image = [UIImage imageNamed:@"售后图片"];
    }
    return _addForumImage;
}

- (UILabel *)addProductLabel {
    if (!_addProductLabel) {
        _addProductLabel = [[UILabel alloc] init];
        _addProductLabel.textColor = [UIColor blackColor];
        _addProductLabel.font = [UIFont systemFontOfSize:14.0];
        _addProductLabel.text = @"增加商品";
    }
    return _addProductLabel;
}

- (UILabel *)deleteProductLabel {
    if (!_deleteProductLabel) {
        _deleteProductLabel = [[UILabel alloc] init];
        _deleteProductLabel.textColor = [UIColor blackColor];
        _deleteProductLabel.font = [UIFont systemFontOfSize:14.0];
        _deleteProductLabel.text = @"删除商品";
    }
    return _deleteProductLabel;
}

- (UILabel *)updateProductLabel {
    if (!_updateProductLabel) {
        _updateProductLabel = [[UILabel alloc] init];
        _updateProductLabel.textColor = [UIColor blackColor];
        _updateProductLabel.font = [UIFont systemFontOfSize:14.0];
        _updateProductLabel.text = @"更新商品";
    }
    return _updateProductLabel;
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

- (UILabel *)afterSaleLabel {
    if (!_afterSaleLabel) {
        _afterSaleLabel = [[UILabel alloc] init];
        _afterSaleLabel.textColor = [UIColor blackColor];
        _afterSaleLabel.font = [UIFont systemFontOfSize:14.0];
        _afterSaleLabel.text = @"售后";
    }
    return _afterSaleLabel;
}

- (UILabel *)addForumLabel {
    if (!_addForumLabel) {
        _addForumLabel = [[UILabel alloc] init];
        _addForumLabel.textColor = [UIColor blackColor];
        _addForumLabel.font = [UIFont systemFontOfSize:14.0];
        _addForumLabel.text = @"新增帖子";
    }
    return _addForumLabel;
}

-(UIButton *)moreOrderButton {
    if (!_moreOrderButton) {
        _moreOrderButton = [[UIButton alloc] init];
    }
    return _moreOrderButton;
}

- (UIButton *)addProductButton {
    if (!_addProductButton) {
        _addProductButton = [[UIButton alloc] init];
    }
    return _addProductButton;
}

- (UIButton *)deleteProductButton {
    if (!_deleteProductButton) {
        _deleteProductButton = [[UIButton alloc] init];
    }
    return _deleteProductButton;
}

- (UIButton *)updateProductButton {
    if (!_updateProductButton) {
        _updateProductButton = [[UIButton alloc] init];
    }
    return _updateProductButton;
}

- (UIButton *)sendButton {
    if (!_sendButton) {
        _sendButton = [[UIButton alloc] init];
    }
    return _sendButton;
}

- (UIButton *)afterSaleButton {
    if (!_afterSaleButton) {
        _afterSaleButton = [[UIButton alloc] init];
    }
    return _afterSaleButton;
}

- (UIButton *)addForumButton {
    if (!_addForumButton) {
        _addForumButton = [[UIButton alloc] init];
    }
    return _addForumButton;
}

@end
