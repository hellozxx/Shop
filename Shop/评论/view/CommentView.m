//
//  CommentView.m
//  Shop
//
//  Created by 朱啸 on 2018/5/20.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "CommentView.h"
#import "DBProduct.h"

@interface CommentView()


@property (strong, nonatomic) UILabel *label1;

@property (strong, nonatomic) UILabel *label2;



@end

@implementation CommentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.productImage];
        [self addSubview:self.label1];
        [self addSubview:self.textView];
        [self addSubview:self.label2];
        [self addSubview:self.submitButton];
    }
    return self;
}


- (void) layoutSubviews {
    __weak typeof (self) weakSelf = self;
    [_productImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(64, 64));
    }];
    
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.productImage.mas_top).offset(5);
        make.left.equalTo(weakSelf.productImage.mas_right).offset(10);
        make.height.mas_equalTo(@25);
    }];
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.productImage.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.productImage.mas_left);
        make.right.equalTo(weakSelf.mas_right).offset(-10);
        make.height.mas_equalTo(@180);
    }];
    
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.textView.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.productImage.mas_left);
        make.height.mas_equalTo(@20);
    }];
    
    [_submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.label2.mas_bottom).offset(20);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(VIEW_WIDTH - 20, 50));
    }];
}


- (UIImageView *)productImage {
    if (!_productImage) {
        _productImage = [[UIImageView alloc] init];
    }
    return _productImage;
}

- (UILabel *)label1 {
    if (!_label1) {
        _label1 = [[UILabel alloc] init];
        _label1.text = @"商品评分";
        _label1.font = [UIFont boldSystemFontOfSize:16.0];
        _label1.textColor = [UIColor blackColor];
    }
    return _label1;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.font = [UIFont systemFontOfSize:14.0];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.layer.borderColor = [UIColor colorWithRed:0xbf/255.0f green:0xbf/255.0f blue:0xbf/255.0f alpha:1].CGColor;
        _textView.layer.borderWidth = 1.0f;
    }
    return _textView;
}

- (UILabel *)label2 {
    if (!_label2) {
        _label2 = [[UILabel alloc] init];
        _label2.text = @"所有评价均为匿名评价";
        _label2.font = [UIFont systemFontOfSize:14.0];
        _label2.textColor = RGB(207, 207, 207);
    }
    return _label2;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [[UIButton alloc] init];
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        _submitButton.backgroundColor = [UIColor orangeColor];
        [_submitButton.layer setCornerRadius:15.0];
    }
    return _submitButton;
}

@end
