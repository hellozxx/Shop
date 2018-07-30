//
//  AddForumView.m
//  Shop
//
//  Created by 朱啸 on 2018/5/24.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "AddForumView.h"

@interface AddForumView()


@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UILabel *imageLabel;


@end

@implementation AddForumView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = MainColor;
        [self addSubview:self.titleLabel];
        [self addSubview:self.titleText];
        [self addSubview:self.textLabel];
        [self addSubview:self.textTextView];
        [self addSubview:self.imageLabel];
        [self addSubview:self.image1];
        [self addSubview:self.image2];
        [self addSubview:self.addButton];
    }
    return self;
}

- (void)layoutSubviews {
    __weak typeof (self) weakSelf = self;
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.left.equalTo(weakSelf.mas_left).offset(10);
        make.right.equalTo(weakSelf.mas_left).offset(90);
        make.height.mas_equalTo(@28);
    }];
    
    [_titleText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_top);
        make.left.equalTo(weakSelf.titleLabel.mas_right).offset(10);
        make.right.equalTo(weakSelf.mas_right).offset(-10);
        make.height.mas_equalTo(@28);
    }];
    
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.titleLabel.mas_left);
        make.right.equalTo(weakSelf.titleLabel.mas_right);
        make.height.mas_equalTo(@28);
    }];
    
    [_textTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.textLabel.mas_top);
        make.left.equalTo(weakSelf.textLabel.mas_right).offset(10);
        make.right.equalTo(weakSelf.titleText.mas_right);
        make.height.mas_equalTo(@180);
    }];
    
    [_imageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.textTextView.mas_bottom).offset(10);
        make.left.equalTo(weakSelf.titleLabel);
        make.right.equalTo(weakSelf.titleLabel);
        make.height.mas_equalTo(@28);
    }];
    
    [_image1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.imageLabel);
        make.left.equalTo(weakSelf.imageLabel.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    [_image2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.imageLabel);
        make.left.equalTo(weakSelf.image1.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.image1.mas_bottom).offset(60);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(VIEW_WIDTH - 40, 45));
    }];
}



- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"帖子标题";
        _titleLabel.font = [UIFont systemFontOfSize:18.0];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.layer.cornerRadius = 6;
        _titleLabel.clipsToBounds = YES;
    }
    return _titleLabel;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.text = @"详情描述";
        _textLabel.font = [UIFont systemFontOfSize:18.0];
        _textLabel.backgroundColor = [UIColor whiteColor];
        _textLabel.layer.cornerRadius = 6;
        _textLabel.clipsToBounds = YES;
    }
    return _textLabel;
}

- (UILabel *)imageLabel {
    if (!_imageLabel) {
        _imageLabel = [[UILabel alloc] init];
        _imageLabel.text = @"  图    片   ";
        _imageLabel.font = [UIFont systemFontOfSize:18.0];
        _imageLabel.backgroundColor = [UIColor whiteColor];
        _imageLabel.layer.cornerRadius = 6;
        _imageLabel.clipsToBounds = YES;
    }
    return _imageLabel;
}

- (UITextField *)titleText {
    if (!_titleText) {
        _titleText = [[UITextField alloc] init];
        _titleText.backgroundColor = [UIColor whiteColor];
    }
    return _titleText;
}

- (UITextView *)textTextView {
    if (!_textTextView) {
        _textTextView = [[UITextView alloc] init];
        _textTextView.backgroundColor = [UIColor whiteColor];
    }
    return _textTextView;
}

- (UIButton *)image1 {
    if (!_image1) {
        _image1 = [[UIButton alloc] init];
        [_image1 setImage:[UIImage imageNamed:@"增加商品图片"] forState:UIControlStateNormal];
    }
    return _image1;
}

- (UIButton *)image2 {
    if (!_image2) {
        _image2 = [[UIButton alloc] init];
        [_image2 setImage:[UIImage imageNamed:@"增加商品图片"] forState:UIControlStateNormal];
    }
    return _image2;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [[UIButton alloc] init];
        [_addButton setTitle:@"发布帖子" forState:UIControlStateNormal];
        [_addButton.layer setCornerRadius:10.0];
        _addButton.backgroundColor = [UIColor orangeColor];
    }
    return _addButton;
}




@end









