//
//  SingleTableViewCell.m
//  Shop
//
//  Created by 朱啸 on 2018/4/23.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "SingleTableViewCell.h"
#import "DBShoppingCart.h"
#import "DBShoppingCartDetail.h"
#import "UIView+Toast.h"    //toast弹框


@interface SingleTableViewCell()

@property (strong, nonatomic) UIImageView *iconImage;   //图片
@property (strong, nonatomic) UILabel *titleLable;  //标题Label
@property (strong, nonatomic) UILabel *contentLabel; //内容Label
@property (strong, nonatomic) UILabel *priceLabel;  //价格Label
@property (strong, nonatomic) UIButton *buyCarBtn;    //购物车按钮


@end

@implementation SingleTableViewCell


//初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.iconImage];
        [self addSubview:self.titleLable];
        [self addSubview:self.contentLabel];
        [self addSubview:self.priceLabel];
        [self addSubview:self.buyCarBtn];
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    __weak typeof (self) weakSelf = self;
    
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(140, 140));
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.left.equalTo(weakSelf.mas_left).offset(5);
    }];
    
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.left.equalTo(weakSelf.iconImage.mas_right).offset(6);
        make.top.equalTo(weakSelf.mas_top).offset(25);
        make.height.equalTo(@15);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLable.mas_bottom).offset(7);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.left.equalTo(weakSelf.iconImage.mas_right).offset(6);
        make.height.equalTo(@60);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@15);
        make.left.equalTo(weakSelf.iconImage.mas_right).offset(6);
        make.right.equalTo(weakSelf.buyCarBtn.mas_left).offset(-20);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-23);
        
    }];
    
    [_buyCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(37, 37));
        make.right.equalTo(weakSelf.mas_right).offset(-45);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-20);
    }];
}


/**
 给每一个cell赋值

 @param singleModel 模型
 */
- (void) setSingleModel:(SingleListModel *)singleModel {
    _singleModel = singleModel; //下面的priceAttributedString方法中需要使用
    _titleLable.text = singleModel.product_name;
    _contentLabel.text = singleModel.product_description;
    _iconImage.image = [UIImage imageWithContentsOfFile:singleModel.product_iconimage];
    [self priceAttributedString];
}


//价格Label的样式设置
- (void) priceAttributedString {
    //当前价格(需要手动添加人民币符号)
    NSString *nowPrice = [NSString stringWithFormat:@"￥%@ ",_singleModel.product_marketprice];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:nowPrice
                                                                               attributes:@{NSForegroundColorAttributeName:RGB(230, 51, 37),
                                                                                                                NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0]
                                                                                                                }];
    
    //过去价格(需要手动添加人民币符号)
//    NSString *oldString = [NSString stringWithFormat:@"%@ ",_singleModel.product_price];
    NSString *price = [NSString stringWithFormat:@"￥%@ ",_singleModel.product_price];
    NSMutableAttributedString *oldPrice = [[NSMutableAttributedString alloc] initWithString:price
                                                                                 attributes:@{NSForegroundColorAttributeName:RGB(132, 132, 132),
                                                                                                               NSFontAttributeName:[UIFont systemFontOfSize:12.0],
                                                                                                               NSStrikethroughStyleAttributeName:@(2)}];
    //把两个价格拼接一下
    [string insertAttributedString:oldPrice atIndex:string.length];
    //把拼接完成的string赋值给Label
    _priceLabel.attributedText = string;
}


- (UIImageView *)iconImage {
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] init];
    }
    return _iconImage;
}

- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.font = [UIFont boldSystemFontOfSize:14.0];
        _titleLable.textColor = RGB(81, 81, 81);
    }
    return _titleLable;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = RGB(35, 35, 35);
        _contentLabel.font = [UIFont systemFontOfSize:13.0];
        _contentLabel.numberOfLines = 3;    //行数最多三行
    }
    return _contentLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
    }
    return _priceLabel;
}

- (UIButton *)buyCarBtn {
    if (!_buyCarBtn) {
        _buyCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buyCarBtn setImage:[UIImage imageNamed:@"限时特卖界面购物车图标"] forState:UIControlStateNormal];
        [_buyCarBtn addTarget:self action:@selector(singleTableViewCellBuyBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyCarBtn;
}


//buycarbtn的点击事件--加入商品至购物车中
- (void) singleTableViewCellBuyBtnMethod {
    Log(@"singleTableViewCellBuyBtnMethod:%@",_productID);
    
    NSDictionary *landingDic = [[[NSUserDefaults standardUserDefaults] valueForKey:@"isLoginArray"] objectAtIndex:0];
    if (landingDic.count > 0) { //判断当前用户是否登录
        [self makeToast:@"加入购物车成功！" duration:1.5 position:@"center"];
        [[DBShoppingCart sharedInstance] LinkDatabaseAndAddToQueue];
        NSString *userID = [[[[NSUserDefaults standardUserDefaults] valueForKey:@"isLoginArray"] objectAtIndex:0] valueForKey:@"user_name"];
        NSString *cartID =  [[DBShoppingCart sharedInstance] selectWithUser_Id:userID];
        [[DBShoppingCartDetail sharedInstance] LinkDatabaseAndAddToQueue];
        [[DBShoppingCartDetail sharedInstance] insetCart_Id:cartID WithProduct_Id:_productID WithNumber:@"1"];
        [[DBShoppingCartDetail sharedInstance] selectAllMethod];
    } else {
        [self makeToast:@"您还没有登录，请先登录！" duration:2 position:@"center"];
    }
    
}


@end
