//
//  ClassView.m
//  Shop
//
//  Created by 朱啸 on 2018/5/11.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "ClassView.h"

@interface ClassView()

@property (strong, nonatomic) UIImageView *backImage1;
@property (strong, nonatomic) UIImageView *backImage2;

@property (strong, nonatomic) UILabel *classAgeLabel;   //人群分类Label


@property (strong, nonatomic) UILabel *classSeriesLabel;    //系列Label



@end

@implementation ClassView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backImage1];
        [self addSubview:self.classAgeLabel];
        [self addSubview:self.babyButton];
        [self addSubview:self.ChildButton];
        [self addSubview:self.adultButton];
        
        [self addSubview:self.backImage2];
        [self addSubview:self.classSeriesLabel];
        [self addSubview:self.cityButton];
        [self addSubview:self.architectureButton];
        [self addSubview:self.ideaButton];
    }
    return self;
}

- (void)layoutSubviews {
    __weak typeof (self) weakSelf = self;
    
    [_backImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(-10);
        make.height.mas_equalTo(@105);
    }];
    
    [_classAgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.backImage1.mas_top).offset(10);
        make.left.equalTo(weakSelf.backImage1.mas_left).offset(10);
        make.height.mas_equalTo(@20);
    }];
    
    [_babyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.classAgeLabel.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.classAgeLabel.mas_left);
        make.size.mas_equalTo(CGSizeMake((VIEW_WIDTH - 50)/2, 25));
    }];
    
    [_ChildButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.babyButton.mas_top);
        make.right.equalTo(weakSelf.backImage1.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake((VIEW_WIDTH - 50)/2, 25));
    }];
    
    [_adultButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.babyButton.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.babyButton.mas_left);
        make.size.mas_equalTo(CGSizeMake((VIEW_WIDTH - 50)/2, 25));
    }];
    
    
    [_backImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.backImage1.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.backImage1.mas_left);
        make.right.equalTo(weakSelf.backImage1.mas_right);
        make.height.mas_equalTo(@105);
    }];
    
    [_classSeriesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.backImage2.mas_top).offset(10);
        make.left.equalTo(weakSelf.backImage2.mas_left).offset(10);
        make.height.mas_equalTo(@20);
    }];
    
    [_cityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.classSeriesLabel.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.classSeriesLabel.mas_left);
        make.size.mas_equalTo(CGSizeMake((VIEW_WIDTH - 50)/2, 25));
    }];
    
    [_architectureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.cityButton.mas_top);
        make.right.equalTo(weakSelf.backImage2.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake((VIEW_WIDTH - 50)/2, 25));
    }];
    
    [_ideaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.cityButton.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.cityButton.mas_left);
        make.size.mas_equalTo(CGSizeMake((VIEW_WIDTH - 50)/2, 25));
    }];
}

- (UIImageView *)backImage1 {
    if (!_backImage1) {
        _backImage1 = [[UIImageView alloc] init];
        _backImage1.backgroundColor = [UIColor whiteColor];
        [_backImage1.layer setCornerRadius:10.0];
    }
    return _backImage1;
}

- (UIImageView *)backImage2 {
    if (!_backImage2) {
        _backImage2 = [[UIImageView alloc] init];
        _backImage2.backgroundColor = [UIColor whiteColor];
        [_backImage2.layer setCornerRadius:10.0];
    }
    return _backImage2;
}

- (UILabel *)classAgeLabel {
    if (!_classAgeLabel) {
        _classAgeLabel = [[UILabel alloc] init];
        _classAgeLabel.text = @"人群分类";
        _classAgeLabel.font = [UIFont systemFontOfSize:15.0];
    }
    return _classAgeLabel;
}

- (UIButton *)babyButton {
    if (!_babyButton) {
        _babyButton = [[UIButton alloc] init];
        _babyButton.backgroundColor = [UIColor grayColor];
        [_babyButton setTitle:@"学龄前" forState:UIControlStateNormal];
        [_babyButton.layer setCornerRadius:10.0];
    }
    return _babyButton;
}

- (UIButton *)ChildButton {
    if (!_ChildButton) {
        _ChildButton = [[UIButton alloc] init];
        _ChildButton.backgroundColor = [UIColor grayColor];
        [_ChildButton setTitle:@"儿童" forState:UIControlStateNormal];
        [_ChildButton.layer setCornerRadius:10.0];
    }
    return _ChildButton;
}

- (UIButton *)adultButton {
    if (!_adultButton) {
        _adultButton = [[UIButton alloc] init];
        _adultButton.backgroundColor = [UIColor grayColor];
        [_adultButton setTitle:@"成人粉丝" forState:UIControlStateNormal];
        [_adultButton.layer setCornerRadius:10.0];
    }
    return _adultButton;
}

- (UILabel *)classSeriesLabel {
    if (!_classSeriesLabel) {
        _classSeriesLabel = [[UILabel alloc] init];
        _classSeriesLabel.text = @"系列";
        _classSeriesLabel.font = [UIFont systemFontOfSize:15.0];
    }
    return _classSeriesLabel;
}

- (UIButton *)cityButton {
    if (!_cityButton) {
        _cityButton = [[UIButton alloc] init];
        _cityButton.backgroundColor = [UIColor grayColor];
        [_cityButton setTitle:@"乐高城市组" forState:UIControlStateNormal];
        [_cityButton.layer setCornerRadius:10.0];
    }
    return _cityButton;
}

- (UIButton *)architectureButton {
    if (!_architectureButton) {
        _architectureButton = [[UIButton alloc] init];
        _architectureButton.backgroundColor = [UIColor grayColor];
        [_architectureButton setTitle:@"乐高建筑系列" forState:UIControlStateNormal];
        [_architectureButton.layer setCornerRadius:10.0];
    }
    return _architectureButton;
}

- (UIButton *)ideaButton {
    if (!_ideaButton) {
        _ideaButton = [[UIButton alloc] init];
        _ideaButton.backgroundColor = [UIColor grayColor];
        [_ideaButton setTitle:@"乐高创意百变组" forState:UIControlStateNormal];
        [_ideaButton.layer setCornerRadius:10.0];
    }
    return _ideaButton;
}

@end
















