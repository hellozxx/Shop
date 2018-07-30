//
//  DetailsContentView.m
//  Shop
//
//  Created by 朱啸 on 2018/5/3.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "DetailsContentView.h"
#import "DetailsModel.h"
#import "NSString+StringHelp.h"

@interface DetailsContentView()

@property (strong, nonatomic) UILabel *tostLineLabel;   //提示文字线
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *titleContentLabel;   //商品名称后面的具体内容--单独一个Label，因为有可能占用两行
@property (strong, nonatomic) UILabel *brandLable;
@property (strong, nonatomic) UILabel *placeLabel;
@property (strong, nonatomic) UILabel *modelLabel;
@property (strong, nonatomic) UILabel *categoryLabel;
@property (strong, nonatomic) UILabel *ageLabel;


@end

@implementation DetailsContentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.tostLineLabel];
        [self addSubview:self.titleLabel];
        [self addSubview:self.titleContentLabel];
        [self addSubview:self.brandLable];
        [self addSubview:self.placeLabel];
        [self addSubview:self.modelLabel];
        [self addSubview:self.categoryLabel];
        [self addSubview:self.ageLabel];
    }
    return self;
}

- (void) layoutSubviews {    
    __weak typeof (self) weakSelf = self;
    [_tostLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(4);
        make.left.equalTo(weakSelf.mas_left).offset(15);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.height.equalTo(@1);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.tostLineLabel.mas_bottom).offset(2);
        make.left.equalTo(weakSelf.tostLineLabel);
        make.right.equalTo(weakSelf.tostLineLabel.mas_left).offset(67);
        make.height.equalTo(@20);
    }];
    
//    [_titleContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.titleLabel);
//        make.left.equalTo(weakSelf.titleLabel.mas_right);
//        make.right.equalTo(weakSelf.tostLineLabel);
//        make.height.equalTo(weakSelf.titleLabel);
//    }];
//
    [_brandLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleContentLabel.mas_bottom);
        make.left.right.equalTo(weakSelf.tostLineLabel);
        make.height.equalTo(@20);
    }];
    
    [_placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.brandLable.mas_bottom);
        make.left.right.equalTo(weakSelf.tostLineLabel);
        make.height.equalTo(@20);
    }];
    
    [_modelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.placeLabel.mas_bottom);
        make.left.right.equalTo(weakSelf.tostLineLabel);
        make.height.equalTo(@20);
    }];
    
    [_categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.modelLabel.mas_bottom);
        make.left.right.equalTo(weakSelf.tostLineLabel);
        make.height.equalTo(@20);
    }];
    
    [_ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.categoryLabel.mas_bottom);
        make.left.right.equalTo(weakSelf.tostLineLabel);
        make.height.equalTo(@20);
    }];
}

- (void) setContentArray:(NSArray *)contentArray {
    _contentArray = contentArray;
    
    CGFloat textHeight = 0;
    
    for ( DetailsModel *model in contentArray) {
        if ([model.product_id isEqualToString:_productID]) {
            
            CGFloat height = [NSString returnLabelTextHeight:model.title width:VIEW_WIDTH - 190 fontSize:[UIFont systemFontOfSize:13.0]];
//            [_titleContentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(height);
//                Log(@"height-2:%f",height);
//            }];
            
            __weak typeof (self) weakSelf = self;
            [_titleContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.titleLabel);
                make.left.equalTo(weakSelf.titleLabel.mas_right);
                make.right.equalTo(weakSelf.tostLineLabel);
                make.height.mas_equalTo(height);
            }];
            _titleContentLabel.font = [UIFont systemFontOfSize:13.0];
            _titleContentLabel.text = model.title;
            
            _brandLable.text = [NSString stringWithFormat:@"品       牌：%@",model.brand];
            _placeLabel.text = [NSString stringWithFormat:@"产       地：%@",model.place];
            _modelLabel.text = [NSString stringWithFormat:@"型       号：%@",model.model];
            _categoryLabel.text = [NSString stringWithFormat:@"玩具类型：%@",model.category];
            _ageLabel.text = [NSString stringWithFormat:@"适用年龄：%@",model.age];
            
            textHeight = height + 107;
        }
    }
    if (_heightBlock) {
        _heightBlock(textHeight);
    }
    
}



- (UILabel *)tostLineLabel {
    if (!_tostLineLabel) {
        _tostLineLabel = [[UILabel alloc] init];
        _tostLineLabel.backgroundColor = RGB(242, 242, 242);
    }
    return _tostLineLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:13.0];
        _titleLabel.text = @"商品名称：";
//        _titleLabel.backgroundColor = [UIColor blueColor];
    }
    return _titleLabel;
}

- (UILabel *)titleContentLabel {
    if (!_titleContentLabel) {
        _titleContentLabel = [[UILabel alloc] init];
        _titleContentLabel.font = [UIFont systemFontOfSize:13.0];
        _titleContentLabel.numberOfLines = 0;
//        _titleContentLabel.backgroundColor = [UIColor yellowColor];
    }
    return _titleContentLabel;
}

- (UILabel *)brandLable {
    if (!_brandLable) {
        _brandLable = [[UILabel alloc] init];
        _brandLable.font = [UIFont systemFontOfSize:13.0];
    }
    return _brandLable;
}

- (UILabel *)placeLabel {
    if (!_placeLabel) {
        _placeLabel = [[UILabel alloc] init];
        _placeLabel.font = [UIFont systemFontOfSize:13.0];
//        _placeLabel.text = @"产地：";
    }
    return _placeLabel;
}

- (UILabel *)modelLabel {
    if (!_modelLabel) {
        _modelLabel = [[UILabel alloc] init];
        _modelLabel.font = [UIFont systemFontOfSize:13.0];
//        _modelLabel.text = @"型号：";
    }
    return _modelLabel;
}

- (UILabel *)categoryLabel {
    if (!_categoryLabel) {
        _categoryLabel = [[UILabel alloc] init];
        _categoryLabel.font = [UIFont systemFontOfSize:13.0];
//        _categoryLabel.text = @"类别：";
    }
    return _categoryLabel;
}

- (UILabel *)ageLabel {
    if (!_ageLabel) {
        _ageLabel = [[UILabel alloc] init];
        _ageLabel.font = [UIFont systemFontOfSize:13.0];
//        _ageLabel.text = @"适用年龄：";
    }
    return _ageLabel;
}

@end
