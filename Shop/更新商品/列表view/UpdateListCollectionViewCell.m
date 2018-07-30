//
//  UpdateListCollectionViewCell.m
//  Shop
//
//  Created by 朱啸 on 2018/5/13.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "UpdateListCollectionViewCell.h"
#import "NSMutableAttributedString+AttributedHelp.h"   //拼接价格

@interface UpdateListCollectionViewCell()

@property (strong, nonatomic)   UIImageView *productImage;              /** 商品图片 */
@property (strong, nonatomic)   UILabel *titleLabel;              /** 商品标题 */
@property (strong, nonatomic)   UILabel *priceLabel;              /** 价格label */

@end

@implementation UpdateListCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.productImage];
        [self addSubview:self.titleLabel];
        [self addSubview:self.priceLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    __weak typeof (self) weakSelf = self;
    [_productImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf).with.insets(UIEdgeInsetsMake(0, 0, 80, 0));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.productImage.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.mas_left).offset(11);
        make.right.equalTo(weakSelf.mas_right).offset(-11);
        make.height.equalTo(@40);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(11);
        make.right.equalTo(weakSelf.mas_right).offset(-11);
        make.height.equalTo(@23);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(5);
    }];
    
}


- (void)setListCellModel:(ProductListSearchModel *)listCellModel {
    _productImage.image = [UIImage imageWithContentsOfFile:listCellModel.product_iconimage];
    _titleLabel.text = listCellModel.product_name;
    _priceLabel.attributedText = [NSMutableAttributedString makeListPriceText:listCellModel.product_marketprice WithMarketPrice:listCellModel.product_price];
}

- (UIImageView *)productImage{
    if (!_productImage) {
        _productImage = [[UIImageView alloc]init];
    }
    return _productImage;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UIFont systemFontOfSize:15.0];
    }
    return _titleLabel;
}

- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLabel;
}
@end
