//
//  AddProductView.m
//  Shop
//
//  Created by 朱啸 on 2018/5/12.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "AddProductView.h"

@interface AddProductView()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *mainScroll; //最底层滑动视图

@property (strong, nonatomic) UILabel *idLabel;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *iconLabel;
@property (strong, nonatomic) UILabel *classLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UILabel *marketPriceLabel;
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic) UILabel *brandLabel;
@property (strong, nonatomic) UILabel *placeLabel;
@property (strong, nonatomic) UILabel *modelLabel;
@property (strong, nonatomic) UILabel *ageLabel;
@property (strong, nonatomic) UILabel *topImageLabel;
@property (strong, nonatomic) UILabel *detialImageLabel;

@end

@implementation AddProductView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.mainScroll];
        
        [self.mainScroll addSubview:self.idLabel];
        [self.mainScroll addSubview:self.idText];
        [self.mainScroll addSubview:self.nameLabel];
        [self.mainScroll addSubview:self.nameText];
        [self.mainScroll addSubview:self.iconLabel];
        [self.mainScroll addSubview:self.classLabel];
        [self.mainScroll addSubview:self.classText];
        [self.mainScroll addSubview:self.priceLabel];
        [self.mainScroll addSubview:self.priceText];
        [self.mainScroll addSubview:self.marketPriceLabel];
        [self.mainScroll addSubview:self.marketPriceText];
        [self.mainScroll addSubview:self.descriptionLabel];
        [self.mainScroll addSubview:self.descriptionText];
        [self.mainScroll addSubview:self.brandLabel];
        [self.mainScroll addSubview:self.brandText];
        [self.mainScroll addSubview:self.placeLabel];
        [self.mainScroll addSubview:self.placeText];
        [self.mainScroll addSubview:self.modelLabel];
        [self.mainScroll addSubview:self.modelText];
        [self.mainScroll addSubview:self.ageLabel];
        [self.mainScroll addSubview:self.ageText];
        [self.mainScroll addSubview:self.topImageLabel];
        [self.mainScroll addSubview:self.detialImageLabel];
        
        [self.mainScroll addSubview:self.iconPhotoButton];
        [self.mainScroll addSubview:self.topPhotoButton1];
        [self.mainScroll addSubview:self.topPhotoButton2];
        [self.mainScroll addSubview:self.topPhotoButton3];
        [self.mainScroll addSubview:self.topPhotoButton4];
        [self.mainScroll addSubview:self.detailPhotoButton1];
        [self.mainScroll addSubview:self.detailPhotoButton2];
        [self.mainScroll addSubview:self.detailPhotoButton3];
        [self.mainScroll addSubview:self.detailPhotoButton4];
        
        [self.mainScroll addSubview:self.addProductButton];
    }
    return self;
}


- (void) layoutSubviews {
    __weak typeof (self) weakSelf = self;
    
    [_idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mainScroll.mas_top).offset(10);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.right.equalTo(weakSelf.mas_left).offset(80);
        make.height.mas_equalTo(@28);
    }];
    
    [_idText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.idLabel.mas_top);
        make.left.equalTo(weakSelf.idLabel.mas_right).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(-10);
        make.height.mas_equalTo(@28);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.idLabel.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.idLabel.mas_left);
        make.right.equalTo(weakSelf.mas_left).offset(50);
        make.height.mas_equalTo(@28);
    }];
    [_nameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLabel.mas_top);
        make.left.equalTo(weakSelf.nameLabel.mas_right).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(-10);
        make.height.mas_equalTo(@28);
    }];
    
    [_iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.nameLabel);
        make.right.equalTo(weakSelf.mas_left).offset(50);
        make.height.mas_equalTo(@28);
    }];
    [_iconPhotoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.iconLabel.mas_top);
        make.left.equalTo(weakSelf.iconLabel.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [_classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.iconPhotoButton.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.iconLabel);
        make.right.equalTo(weakSelf.mas_left).offset(50);
        make.height.mas_equalTo(@28);
    }];
    [_classText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.classLabel.mas_top);
        make.left.equalTo(weakSelf.classLabel.mas_right).offset(10);
        make.right.equalTo(weakSelf.nameText.mas_right);
        make.height.mas_equalTo(@28);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.classLabel.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.classLabel);
        make.right.equalTo(weakSelf.mas_left).offset(50);
        make.height.mas_equalTo(@28);
    }];
    [_priceText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.priceLabel.mas_top);
        make.left.equalTo(weakSelf.priceLabel.mas_right).offset(10);
        make.right.equalTo(weakSelf.nameText.mas_right);
        make.height.mas_equalTo(@28);
    }];
    
    [_marketPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.priceLabel.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.classLabel);
        make.right.equalTo(weakSelf.mas_left).offset(100);
        make.height.mas_equalTo(@28);
    }];
    [_marketPriceText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.marketPriceLabel.mas_top);
        make.left.equalTo(weakSelf.marketPriceLabel.mas_right).offset(10);
        make.right.equalTo(weakSelf.nameText.mas_right);
        make.height.mas_equalTo(@28);
    }];
    
    [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.marketPriceLabel.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.classLabel);
        make.right.equalTo(weakSelf.mas_left).offset(50);
        make.height.mas_equalTo(@28);
    }];
    [_descriptionText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.descriptionLabel.mas_top);
        make.left.equalTo(weakSelf.descriptionLabel.mas_right).offset(10);
        make.right.equalTo(weakSelf.nameText.mas_right);
        make.height.mas_equalTo(@100);
    }];
    
    [_brandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.descriptionText.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.classLabel);
        make.right.equalTo(weakSelf.mas_left).offset(50);
        make.height.mas_equalTo(@28);
    }];
    [_brandText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.brandLabel.mas_top);
        make.left.equalTo(weakSelf.brandLabel.mas_right).offset(10);
        make.right.equalTo(weakSelf.nameText.mas_right);
        make.height.mas_equalTo(@28);
    }];
    
    [_placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.brandLabel.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.classLabel);
        make.right.equalTo(weakSelf.mas_left).offset(50);
        make.height.mas_equalTo(@28);
    }];
    [_placeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.placeLabel.mas_top);
        make.left.equalTo(weakSelf.placeLabel.mas_right).offset(10);
        make.right.equalTo(weakSelf.nameText.mas_right);
        make.height.mas_equalTo(@28);
    }];
    
    [_modelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.placeLabel.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.classLabel);
        make.right.equalTo(weakSelf.mas_left).offset(50);
        make.height.mas_equalTo(@28);
    }];
    [_modelText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.modelLabel.mas_top);
        make.left.equalTo(weakSelf.modelLabel.mas_right).offset(10);
        make.right.equalTo(weakSelf.nameText.mas_right);
        make.height.mas_equalTo(@28);
    }];
    
    [_ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.modelLabel.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.classLabel);
        make.right.equalTo(weakSelf.mas_left).offset(100);
        make.height.mas_equalTo(@28);
    }];
    [_ageText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.ageLabel.mas_top);
        make.left.equalTo(weakSelf.ageLabel.mas_right).offset(10);
        make.right.equalTo(weakSelf.nameText.mas_right);
        make.height.mas_equalTo(@28);
    }];
    
    [_topImageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.ageLabel.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.classLabel);
        make.right.equalTo(weakSelf.mas_left).offset(100);
        make.height.mas_equalTo(@28);
    }];
    [_topPhotoButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.topImageLabel.mas_top);
        make.left.equalTo(weakSelf.topImageLabel.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [_topPhotoButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.topImageLabel.mas_top);
        make.left.equalTo(weakSelf.topPhotoButton1.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [_topPhotoButton3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.topImageLabel.mas_top);
        make.left.equalTo(weakSelf.topPhotoButton2.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [_topPhotoButton4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.topImageLabel.mas_top);
        make.left.equalTo(weakSelf.topPhotoButton3.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [_detialImageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.topPhotoButton1.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.classLabel);
        make.right.equalTo(weakSelf.mas_left).offset(100);
        make.height.mas_equalTo(@28);
    }];
    [_detailPhotoButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.detialImageLabel.mas_top);
        make.left.equalTo(weakSelf.detialImageLabel.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [_detailPhotoButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.detialImageLabel.mas_top);
        make.left.equalTo(weakSelf.detailPhotoButton1.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [_detailPhotoButton3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.detialImageLabel.mas_top);
        make.left.equalTo(weakSelf.detailPhotoButton2.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    [_detailPhotoButton4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.detialImageLabel.mas_top);
        make.left.equalTo(weakSelf.detailPhotoButton3.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [_addProductButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.detailPhotoButton1.mas_bottom).offset(20);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(VIEW_WIDTH, 45));
    }];
}

- (UIScrollView *)mainScroll {
    if (!_mainScroll) {
        _mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
        _mainScroll.contentSize = CGSizeMake(0, 838);  //滑动范围
        _mainScroll.delegate = self;
        _mainScroll.backgroundColor = MainColor;
    }
    return _mainScroll;
}

- (UILabel *)idLabel {
    if (!_idLabel) {
        _idLabel = [[UILabel alloc] init];
        _idLabel.font = [UIFont systemFontOfSize:18.0];
        _idLabel.text = @"商品id";
        _idLabel.backgroundColor = [UIColor whiteColor];
        _idLabel.layer.cornerRadius = 10;
        _idLabel.clipsToBounds = YES;
    }
    return _idLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:18.0];
        _nameLabel.text = @"名称";
        _nameLabel.backgroundColor = [UIColor whiteColor];
        _nameLabel.layer.cornerRadius = 10;
        _nameLabel.clipsToBounds = YES;
    }
    return _nameLabel;
}

- (UILabel *)iconLabel {
    if (!_iconLabel) {
        _iconLabel = [[UILabel alloc] init];
        _iconLabel.font = [UIFont systemFontOfSize:18.0];
        _iconLabel.text = @"图片";
        _iconLabel.backgroundColor = [UIColor whiteColor];
        _iconLabel.layer.cornerRadius = 10;
        _iconLabel.clipsToBounds = YES;
    }
    return _iconLabel;
}

- (UILabel *)classLabel {
    if (!_classLabel) {
        _classLabel = [[UILabel alloc] init];
        _classLabel.font = [UIFont systemFontOfSize:18.0];
        _classLabel.text = @"类别";
        _classLabel.backgroundColor = [UIColor whiteColor];
        _classLabel.layer.cornerRadius = 10;
        _classLabel.clipsToBounds = YES;
    }
    return _classLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont systemFontOfSize:18.0];
        _priceLabel.text = @"价格";
        _priceLabel.backgroundColor = [UIColor whiteColor];
        _priceLabel.layer.cornerRadius = 10;
        _priceLabel.clipsToBounds = YES;
    }
    return _priceLabel;
}

- (UILabel *)marketPriceLabel {
    if (!_marketPriceLabel) {
        _marketPriceLabel = [[UILabel alloc] init];
        _marketPriceLabel.font = [UIFont systemFontOfSize:18.0];
        _marketPriceLabel.text = @"市场价格";
        _marketPriceLabel.backgroundColor = [UIColor whiteColor];
        _marketPriceLabel.layer.cornerRadius = 10;
        _marketPriceLabel.clipsToBounds = YES;
    }
    return _marketPriceLabel;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] init];
        _descriptionLabel.font = [UIFont systemFontOfSize:18.0];
        _descriptionLabel.text = @"描述";
        _descriptionLabel.backgroundColor = [UIColor whiteColor];
        _descriptionLabel.layer.cornerRadius = 10;
        _descriptionLabel.clipsToBounds = YES;
    }
    return _descriptionLabel;
}

- (UILabel *)brandLabel {
    if (!_brandLabel) {
        _brandLabel = [[UILabel alloc] init];
        _brandLabel.font = [UIFont systemFontOfSize:18.0];
        _brandLabel.text = @"品牌";
        _brandLabel.backgroundColor = [UIColor whiteColor];
        _brandLabel.layer.cornerRadius = 10;
        _brandLabel.clipsToBounds = YES;
    }
    return _brandLabel;
}

- (UILabel *)placeLabel {
    if (!_placeLabel) {
        _placeLabel = [[UILabel alloc] init];
        _placeLabel.font = [UIFont systemFontOfSize:18.0];
        _placeLabel.text = @"产地";
        _placeLabel.backgroundColor = [UIColor whiteColor];
        _placeLabel.layer.cornerRadius = 10;
        _placeLabel.clipsToBounds = YES;
    }
    return _placeLabel;
}

- (UILabel *)modelLabel {
    if (!_modelLabel) {
        _modelLabel = [[UILabel alloc] init];
        _modelLabel.font = [UIFont systemFontOfSize:18.0];
        _modelLabel.text = @"型号";
        _modelLabel.backgroundColor = [UIColor whiteColor];
        _modelLabel.layer.cornerRadius = 10;
        _modelLabel.clipsToBounds = YES;
    }
    return _modelLabel;
}

- (UILabel *)ageLabel {
    if (!_ageLabel) {
        _ageLabel = [[UILabel alloc] init];
        _ageLabel.font = [UIFont systemFontOfSize:18.0];
        _ageLabel.text = @"适用年龄";
        _ageLabel.backgroundColor = [UIColor whiteColor];
        _ageLabel.layer.cornerRadius = 10;
        _ageLabel.clipsToBounds = YES;
    }
    return _ageLabel;
}

- (UILabel *)topImageLabel {
    if (!_topImageLabel) {
        _topImageLabel = [[UILabel alloc] init];
        _topImageLabel.font = [UIFont systemFontOfSize:18.0];
        _topImageLabel.text = @"轮播图片";
        _topImageLabel.backgroundColor = [UIColor whiteColor];
        _topImageLabel.layer.cornerRadius = 10;
        _topImageLabel.clipsToBounds = YES;
    }
    return _topImageLabel;
}

- (UILabel *)detialImageLabel {
    if (!_detialImageLabel) {
        _detialImageLabel = [[UILabel alloc] init];
        _detialImageLabel.font = [UIFont systemFontOfSize:18.0];
        _detialImageLabel.text = @"详情图片";
        _detialImageLabel.backgroundColor = [UIColor whiteColor];
        _detialImageLabel.layer.cornerRadius = 10;
        _detialImageLabel.clipsToBounds = YES;
    }
    return _detialImageLabel;
}






- (UITextField *)idText {
    if (!_idText) {
        _idText = [[UITextField alloc] init];
        _idText.font = [UIFont systemFontOfSize:18.0];
        _idText.backgroundColor = [UIColor whiteColor];
        _idText.layer.borderColor = [UIColor colorWithRed:0xbf/255.0f green:0xbf/255.0f blue:0xbf/255.0f alpha:1].CGColor;
        _idText.layer.borderWidth = 1.0f;
    }
    return _idText;
}

- (UITextField *)nameText {
    if (!_nameText) {
        _nameText = [[UITextField alloc] init];
        _nameText.font = [UIFont systemFontOfSize:18.0];
        _nameText.backgroundColor = [UIColor whiteColor];
        _nameText.layer.borderColor= [UIColor colorWithRed:0xbf/255.0f green:0xbf/255.0f blue:0xbf/255.0f alpha:1].CGColor;
        _nameText.layer.borderWidth = 1.0f;
    }
    return _nameText;
}

- (UITextField *)classText {
    if (!_classText) {
        _classText = [[UITextField alloc] init];
        _classText.font = [UIFont systemFontOfSize:18.0];
        _classText.backgroundColor = [UIColor whiteColor];
        _classText.layer.borderColor = [UIColor colorWithRed:0xbf/255.0f green:0xbf/255.0f blue:0xbf/255.0f alpha:1].CGColor;
        _classText.layer.borderWidth = 1.0f;
    }
    return _classText;
}

- (UITextField *)priceText {
    if (!_priceText) {
        _priceText = [[UITextField alloc] init];
        _priceText.font = [UIFont systemFontOfSize:18.0];
        _priceText.backgroundColor = [UIColor whiteColor];
        _priceText.layer.borderColor = [UIColor colorWithRed:0xbf/255.0f green:0xbf/255.0f blue:0xbf/255.0f alpha:1].CGColor;
        _priceText.layer.borderWidth = 1.0f;
    }
    return _priceText;
}

- (UITextField *)marketPriceText {
    if (!_marketPriceText) {
        _marketPriceText = [[UITextField alloc] init];
        _marketPriceText.font = [UIFont systemFontOfSize:18.0];
        _marketPriceText.backgroundColor = [UIColor whiteColor];
        _marketPriceText.layer.borderColor = [UIColor colorWithRed:0xbf/255.0f green:0xbf/255.0f blue:0xbf/255.0f alpha:1].CGColor;
        _marketPriceText.layer.borderWidth = 1.0f;
    }
    return _marketPriceText;
}

- (UITextView *)descriptionText {
    if (!_descriptionText) {
        _descriptionText = [[UITextView alloc] init];
        _descriptionText.font = [UIFont systemFontOfSize:18.0];
        _descriptionText.backgroundColor = [UIColor whiteColor];
        _descriptionText.layer.borderColor = [UIColor colorWithRed:0xbf/255.0f green:0xbf/255.0f blue:0xbf/255.0f alpha:1].CGColor;
        _descriptionText.layer.borderWidth = 1.0f;
    }
    return _descriptionText;
}

- (UITextField *)brandText {
    if (!_brandText) {
        _brandText = [[UITextField alloc] init];
        _brandText.font = [UIFont systemFontOfSize:18.0];
        _brandText.backgroundColor = [UIColor whiteColor];
        _brandText.layer.borderColor = [UIColor colorWithRed:0xbf/255.0f green:0xbf/255.0f blue:0xbf/255.0f alpha:1].CGColor;
        _brandText.layer.borderWidth = 1.0f;
    }
    return _brandText;
}

- (UITextField *)placeText {
    if (!_placeText) {
        _placeText = [[UITextField alloc] init];
        _placeText.font = [UIFont systemFontOfSize:18.0];
        _placeText.backgroundColor = [UIColor whiteColor];
        _placeText.layer.borderColor = [UIColor colorWithRed:0xbf/255.0f green:0xbf/255.0f blue:0xbf/255.0f alpha:1].CGColor;
        _placeText.layer.borderWidth = 1.0f;
    }
    return _placeText;
}

- (UITextField *)modelText {
    if (!_modelText) {
        _modelText = [[UITextField alloc] init];
        _modelText.font = [UIFont systemFontOfSize:18.0];
        _modelText.backgroundColor = [UIColor whiteColor];
        _modelText.layer.borderColor = [UIColor colorWithRed:0xbf/255.0f green:0xbf/255.0f blue:0xbf/255.0f alpha:1].CGColor;
        _modelText.layer.borderWidth = 1.0f;
    }
    return _modelText;
}

- (UITextField *)ageText {
    if (!_ageText) {
        _ageText = [[UITextField alloc] init];
        _ageText.font = [UIFont systemFontOfSize:18.0];
        _ageText.backgroundColor = [UIColor whiteColor];
        _ageText.layer.borderColor = [UIColor colorWithRed:0xbf/255.0f green:0xbf/255.0f blue:0xbf/255.0f alpha:1].CGColor;
        _ageText.layer.borderWidth = 1.0f;
    }
    return _ageText;
}


- (UIButton *)iconPhotoButton {
    if (!_iconPhotoButton) {
        _iconPhotoButton = [[UIButton alloc] init];
//        _iconPhotoButton.backgroundColor = [UIColor yellowColor];
        [_iconPhotoButton setBackgroundImage:[UIImage imageNamed:@"增加商品图片"] forState:UIControlStateNormal];
    }
    return _iconPhotoButton;
}

- (UIButton *)topPhotoButton1 {
    if (!_topPhotoButton1) {
        _topPhotoButton1 = [[UIButton alloc] init];
//        _topPhotoButton1.backgroundColor = [UIColor yellowColor];
        [_topPhotoButton1 setBackgroundImage:[UIImage imageNamed:@"增加商品图片"] forState:UIControlStateNormal];
    }
    return _topPhotoButton1;
}

- (UIButton *)topPhotoButton2 {
    if (!_topPhotoButton2) {
        _topPhotoButton2 = [[UIButton alloc] init];
//        _topPhotoButton2.backgroundColor = [UIColor yellowColor];
        [_topPhotoButton2 setBackgroundImage:[UIImage imageNamed:@"增加商品图片"] forState:UIControlStateNormal];
    }
    return _topPhotoButton2;
}

- (UIButton *)topPhotoButton3 {
    if (!_topPhotoButton3) {
        _topPhotoButton3 = [[UIButton alloc] init];
//        _topPhotoButton3.backgroundColor = [UIColor yellowColor];
        [_topPhotoButton3 setBackgroundImage:[UIImage imageNamed:@"增加商品图片"] forState:UIControlStateNormal];
    }
    return _topPhotoButton3;
}

- (UIButton *)topPhotoButton4 {
    if (!_topPhotoButton4) {
        _topPhotoButton4 = [[UIButton alloc] init];
//        _topPhotoButton4.backgroundColor = [UIColor yellowColor];
        [_topPhotoButton4 setBackgroundImage:[UIImage imageNamed:@"增加商品图片"] forState:UIControlStateNormal];
    }
    return _topPhotoButton4;
}

- (UIButton *)detailPhotoButton1 {
    if (!_detailPhotoButton1) {
        _detailPhotoButton1 = [[UIButton alloc] init];
//        _detailPhotoButton1.backgroundColor = [UIColor yellowColor];
        [_detailPhotoButton1 setBackgroundImage:[UIImage imageNamed:@"增加商品图片"] forState:UIControlStateNormal];
    }
    return _detailPhotoButton1;
}

- (UIButton *)detailPhotoButton2 {
    if (!_detailPhotoButton2) {
        _detailPhotoButton2 = [[UIButton alloc] init];
//        _detailPhotoButton2.backgroundColor = [UIColor yellowColor];
        [_detailPhotoButton2 setBackgroundImage:[UIImage imageNamed:@"增加商品图片"] forState:UIControlStateNormal];
    }
    return _detailPhotoButton2;
}

- (UIButton *)detailPhotoButton3 {
    if (!_detailPhotoButton3) {
        _detailPhotoButton3 = [[UIButton alloc] init];
//        _detailPhotoButton3.backgroundColor = [UIColor yellowColor];
        [_detailPhotoButton3 setBackgroundImage:[UIImage imageNamed:@"增加商品图片"] forState:UIControlStateNormal];
    }
    return _detailPhotoButton3;
}

- (UIButton *)detailPhotoButton4 {
    if (!_detailPhotoButton4) {
        _detailPhotoButton4 = [[UIButton alloc] init];
//        _detailPhotoButton4.backgroundColor = [UIColor yellowColor];
        [_detailPhotoButton4 setBackgroundImage:[UIImage imageNamed:@"增加商品图片"] forState:UIControlStateNormal];
    }
    return _detailPhotoButton4;
}

- (UIButton *)addProductButton {
    if (!_addProductButton) {
        _addProductButton = [[UIButton alloc] init];
        [_addProductButton setTitle:@"增加商品" forState:UIControlStateNormal];
        _addProductButton.backgroundColor = [UIColor orangeColor];
        [_addProductButton.layer setCornerRadius:15.0];
    }
    return _addProductButton;
}


@end


















