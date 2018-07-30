//
//  ForumDetialView.m
//  Shop
//
//  Created by 朱啸 on 2018/5/11.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "ForumDetialView.h"
#import "NSString+StringHelp.h"

@interface ForumDetialView()




@end

@implementation ForumDetialView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.userNameLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.textLabel];
        [self addSubview:self.image1];
        [self addSubview:self.image2];
    }
    return self;
}

- (void)layoutSubviews {
    __weak typeof (self) weakSelf = self;
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
        make.height.mas_equalTo(@40);   //字体大小给30
    }];
    
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(15);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.right.equalTo(weakSelf.mas_left).offset(180);
        make.height.mas_equalTo(@18);   //字体大小给14
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.userNameLabel.mas_top);
        make.left.equalTo(weakSelf.userNameLabel.mas_right).offset(8);
//        make.right.equalTo(weakSelf.mas_right).offset(-10);
        make.height.mas_equalTo(@18);   //字体大小给14
    }];
    
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.userNameLabel.mas_bottom).offset(15);
        make.left.equalTo(weakSelf.userNameLabel.mas_left);
        make.right.equalTo(weakSelf.mas_right).offset(-10);
        make.height.mas_equalTo(@200);
    }];
    
    [_image1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.textLabel.mas_bottom).offset(10);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    
    [_image2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.image1.mas_bottom).offset(10);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = RGB(51, 51, 51);
        _titleLabel.text = @"这里应该是一个标题";
//        _titleLabel.backgroundColor = [UIColor grayColor];
    }
    return _titleLabel;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.textColor = RGB(103, 13, 168);
        _userNameLabel.text = @"乐高官方直售，畅享乐趣";
        _userNameLabel.font = [UIFont systemFontOfSize:14.0];
//        _userNameLabel.backgroundColor = [UIColor redColor];
    }
    return _userNameLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = RGB(130, 130, 130);
        _timeLabel.text = @"这里应该是时间";
        _timeLabel.font = [UIFont systemFontOfSize:12.0];
//        _timeLabel.backgroundColor = [UIColor blueColor];
    }
    return _timeLabel;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.textColor = RGB(40, 40, 40);
        _textLabel.text = @"这里应该是正文";
//        _textLabel.backgroundColor = [UIColor orangeColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.numberOfLines = 0;
    }
    return _textLabel;
}

- (UIImageView *)image1 {
    if (!_image1) {
        _image1 = [[UIImageView alloc] init];
        [_image1.layer setCornerRadius:10.0];
        _image1.image = [UIImage imageNamed:@"01"];
//        _image1.backgroundColor = [UIColor yellowColor];
    }
    return _image1;
}

- (UIImageView *)image2 {
    if (!_image2) {
        _image2 = [[UIImageView alloc] init];
        [_image2.layer setCornerRadius:10.0];
        _image2.image = [UIImage imageNamed:@"02"];
    }
    return _image2;
}

@end











