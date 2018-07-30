//
//  GroupTableCell.m
//  Shop
//
//  Created by 朱啸 on 2018/4/24.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "ForumTableCell.h"

@interface ForumTableCell()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *forumImage1;  //团购展示图
@property (strong, nonatomic) UIImageView *forumImage2;

@end

@implementation ForumTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.forumImage1];
        [self addSubview:self.forumImage2];
    }
    return self;
}

-(void) layoutSubviews {
    [super layoutSubviews];
    __weak typeof (self) weakSelf = self;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(15);
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.height.equalTo(@15);
    }];
    [_forumImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(55);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(125, 125));
    }];
    [_forumImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.forumImage1.mas_right).offset(15);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(125, 125));
    }];
}

-(void)setForumModel:(ForumListModel *)forumModel {
    _titleLabel.text = forumModel.forum_title;
    _forumImage1.image = [UIImage imageWithContentsOfFile:forumModel.forum_image1];
    _forumImage2.image = [UIImage imageWithContentsOfFile:forumModel.forum_image2];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _titleLabel.textColor = RGB(81, 81, 81);
        _titleLabel.text = @"11111111111111111111111111";
    }
    return _titleLabel;
}

- (UIImageView *)forumImage1 {
    if (!_forumImage1) {
        _forumImage1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"04"]];
//        _forumImage.backgroundColor = [UIColor redColor];
    }
    return _forumImage1;
}

- (UIImageView *)forumImage2 {
    if (!_forumImage2) {
        _forumImage2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"01"]];
    }
    return _forumImage2;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
