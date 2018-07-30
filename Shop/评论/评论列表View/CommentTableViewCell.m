//
//  CommentTableViewCell.m
//  Shop
//
//  Created by 朱啸 on 2018/5/20.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "CommentTableViewCell.h"

@interface CommentTableViewCell()

@property (strong, nonatomic) UIImageView *headImage;   //头像Image
@property (strong, nonatomic) UILabel *userNameLabel;  //用户名Label

@end

@implementation CommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.headImage];
        [self addSubview:self.userNameLabel];
        [self addSubview:self.timeLabel];
        [self addSubview:self.text];
    }
    return self;
}

- (void)layoutSubviews {
    __weak typeof (self) weakSelf = self;
    [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.headImage.mas_centerY);
        make.left.equalTo(weakSelf.headImage.mas_right).offset(10);
        make.height.mas_equalTo(@18);
    }];

    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headImage.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.headImage);
        make.height.mas_equalTo(@18);
    }];

    [_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.timeLabel.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.headImage);
        make.right.equalTo(weakSelf.mas_right).offset(-10);
        make.height.mas_equalTo(80);
    }];
    
    
}

- (UIImageView *)headImage {
    if (!_headImage) {
        _headImage = [[UIImageView alloc] init];
        _headImage.image = [UIImage imageNamed:@"评论头像"];
//        _headImage.backgroundColor = [UIColor yellowColor];
    }
    return _headImage;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.textColor = RGB(103, 13, 168);
        _userNameLabel.text = @"乐高官方直售，畅享乐趣";
        _userNameLabel.font = [UIFont systemFontOfSize:14.0];
//        _userNameLabel.backgroundColor = [UIColor yellowColor];
    }
    return _userNameLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = RGB(130, 130, 130);
        _timeLabel.text = @"这里应该是时间";
        _timeLabel.font = [UIFont systemFontOfSize:12.0];
//        _timeLabel.backgroundColor = [UIColor yellowColor];
    }
    return _timeLabel;
}

- (UILabel *)text {
    if (!_text) {
        _text = [[UILabel alloc] init];
        _text.textColor = RGB(40, 40, 40);
        _text.text = @"这里应该是正文";
        _text.textAlignment = NSTextAlignmentCenter;
        _text.numberOfLines = 0;
//        _text.backgroundColor = [UIColor yellowColor];
    }
    return _text;
}


@end
