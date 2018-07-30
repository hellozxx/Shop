//
//  DeleteProductTableViewCell.m
//  Shop
//
//  Created by 朱啸 on 2018/5/13.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "DeleteProductTableViewCell.h"

@interface DeleteProductTableViewCell()

@property (strong, nonatomic) UILabel *idLabel;
@property (strong, nonatomic) UIImageView *iconImage;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *priceLabel;


@end
@implementation DeleteProductTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.idLabel];
        [self addSubview:self.iconImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.priceLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    __weak typeof (self) weakSelf = self;
    
    [_idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.height.mas_equalTo(@24);
    }];
    
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.idLabel.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.idLabel.mas_left);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.iconImage.mas_top).offset(5);
        make.left.equalTo(weakSelf.iconImage.mas_right).offset(10);
        make.height.mas_equalTo(@24);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.nameLabel.mas_left);
        make.height.mas_equalTo(@24);
    }];
}
- (void)setProductDic:(NSDictionary *)productDic {
    _productDic = productDic;
    _idLabel.text = [NSString stringWithFormat:@"商品ID：%@",[_productDic valueForKey:@"product_id"]];
    _iconImage.image = [UIImage imageWithContentsOfFile:[_productDic valueForKey:@"product_iconimage"]];
    _nameLabel.text = [_productDic valueForKey:@"product_name"];
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",[_productDic valueForKey:@"product_price"]];
}


- (UILabel *)idLabel {
    if (!_idLabel) {
        _idLabel = [[UILabel alloc] init];
        _idLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _idLabel;
}

- (UIImageView *)iconImage {
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] init];
    }
    return _iconImage;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _nameLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont systemFontOfSize:14.0];
        _priceLabel.textColor = [UIColor redColor];
    }
    return _priceLabel;
}

@end
