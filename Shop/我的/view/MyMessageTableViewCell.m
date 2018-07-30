//
//  MyMessageTableViewCell.m
//  Shop
//
//  Created by 朱啸 on 2018/4/12.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "MyMessageTableViewCell.h"

@interface MyMessageTableViewCell()

@property (strong ,nonatomic) UIImageView *iconImage;   //图标
@property (strong ,nonatomic) UILabel *titleLable;  //cell中显示文字的Lable
@property (strong, nonatomic) UIImageView *nextImage;   //下一步image
@property (strong, nonatomic) UILabel *lineLable;   //分割线

@end

@implementation MyMessageTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.iconImage];
        [self addSubview:self.titleLable];
        [self addSubview:self.nextImage];
        [self addSubview:self.lineLable];
    }
    return self;
}


- (void) layoutSubviews{
    [super layoutSubviews];
    __weak typeof (self) weakSelf = self;
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.equalTo(weakSelf.mas_left).offset(15);
        make.centerY.equalTo(weakSelf.mas_centerY);
    }];
    
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(140, 15));
        make.centerY.equalTo(weakSelf.mas_centerY); //垂直居中
        make.left.equalTo(weakSelf.iconImage.mas_right).offset(15);
    }];
    
    [_nextImage mas_makeConstraints:^(MASConstraintMaker *make){
        make.size.mas_equalTo(CGSizeMake(10, 14));
        make.centerY.equalTo(weakSelf.mas_centerY); //垂直居中
        make.right.equalTo(weakSelf.mas_right).offset(-15);
    }];
    
    [_lineLable mas_makeConstraints:^(MASConstraintMaker *make){
        make.height.mas_equalTo(1);
        make.left.equalTo(weakSelf.titleLable.mas_left);
        make.right.equalTo(weakSelf.mas_right);
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
}

- (void) setSourceDic:(NSDictionary *)sourceDic{
    //给列表赋值
    _titleLable.text = sourceDic[@"title"];
    _iconImage.image = [UIImage imageNamed:sourceDic[@"image"]];
}


//初始化控件
- (UIImageView *) iconImage{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc] init];
    }
    return _iconImage;
}

//初始化控件
- (UILabel *) titleLable{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightRegular];
        _titleLable.textColor = [UIColor blackColor];
    }
    return _titleLable;
}

//初始化控件
- (UIImageView *) nextImage{
    if (!_nextImage) {
        _nextImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"下一步"]];
    }
    return _nextImage;
}

//初始化控件
- (UILabel *) lineLable{
    if (!_lineLable) {
        _lineLable = [[UILabel alloc] init];
        _lineLable.backgroundColor = MainColor;
    }
    return _lineLable;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
