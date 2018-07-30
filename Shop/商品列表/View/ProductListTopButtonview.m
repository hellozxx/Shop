//
//  ProductListTopButtonview.m
//  Shop
//
//  Created by 朱啸 on 2018/5/4.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "ProductListTopButtonview.h"

@interface ProductListTopButtonview()

@property (strong, nonatomic)   UILabel *lineLabel;              /** 选中的横线 */
@property (strong, nonatomic)   UIButton *oldBtn;              //之前选中的button,用于传递

@end

@implementation ProductListTopButtonview

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.defaultBtn];
        [self addSubview:self.priceBtn];
        [self addSubview:self.saleBtn];
        [self addSubview:self.lineLabel];
        [self addLayout];
        self.oldBtn = self.defaultBtn;
    }
    return self;
}

- (void)addLayout {
    __weak typeof (self) weakSelf = self;
    [_defaultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(weakSelf);
        make.width.mas_equalTo(VIEW_WIDTH/3);
    }];
    
    [_priceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(weakSelf);
        make.width.mas_equalTo(VIEW_WIDTH/3);
        make.left.equalTo(weakSelf.defaultBtn.mas_right);
    }];
    
    [_saleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(VIEW_WIDTH/3);
        make.left.equalTo(weakSelf.priceBtn.mas_right);
    }];
    
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(40, 2));
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.centerX.equalTo(weakSelf.defaultBtn.mas_centerX);
    }];
}

//几个button的点击事件
- (void)threeBtnTouchMethod:(UIButton *)selectBtn {
    selectBtn.selected = YES;
    _oldBtn.selected = NO;
    _oldBtn = selectBtn;
    __weak typeof (self) weakSelf = self;
    [_lineLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(40, 2));
        make.bottom.equalTo(weakSelf.mas_bottom);
        make.centerX.equalTo(selectBtn.mas_centerX);
    }];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    //动画效果
    [UIView animateWithDuration:0.3 animations:^{
    [self layoutIfNeeded];  //告诉系统，layout需要更新
    }];
}

- (UIButton *)defaultBtn{
    if (!_defaultBtn) {
        _defaultBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_defaultBtn setTitle:@"默认" forState:(UIControlStateNormal)];
        _defaultBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [_defaultBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_defaultBtn setTitleColor:RGB(56, 166, 243) forState:(UIControlStateSelected)];
        [_defaultBtn addTarget:self action:@selector(threeBtnTouchMethod:) forControlEvents:(UIControlEventTouchUpInside)];
        _defaultBtn.selected = YES;
//        _defaultBtn.backgroundColor = [UIColor yellowColor];
    }
    return _defaultBtn;
}

- (UIButton *)priceBtn{
    if (!_priceBtn) {
        _priceBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_priceBtn setTitle:@"价格" forState:(UIControlStateNormal)];
        _priceBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [_priceBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_priceBtn setTitleColor:RGB(56, 166, 243) forState:(UIControlStateSelected)];
        [_priceBtn addTarget:self action:@selector(threeBtnTouchMethod:) forControlEvents:(UIControlEventTouchUpInside)];
        _priceBtn.selected = NO;
//        _priceBtn.backgroundColor = [UIColor blueColor];
    }
    return _priceBtn;
}

- (UIButton *)saleBtn{
    if (!_saleBtn) {
        _saleBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_saleBtn setTitle:@"销量" forState:(UIControlStateNormal)];
        _saleBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [_saleBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_saleBtn setTitleColor:RGB(56, 166, 243) forState:(UIControlStateSelected)];
        [_saleBtn addTarget:self action:@selector(threeBtnTouchMethod:) forControlEvents:(UIControlEventTouchUpInside)];
        _saleBtn.selected = NO;
        //        _priceBtn.backgroundColor = [UIColor blueColor];
    }
    return _saleBtn;
}

- (UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = RGB(56, 166, 243);
    }
    return _lineLabel;
}

@end
