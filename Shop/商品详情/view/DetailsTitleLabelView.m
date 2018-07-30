//
//  DetailsTitleLabelView.m
//  Shop
//
//  Created by 朱啸 on 2018/4/29.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "DetailsTitleLabelView.h"
#import "NSString+StringHelp.h"
#import "NSMutableAttributedString+AttributedHelp.h"   //拼接价格

@interface DetailsTitleLabelView()

@property (strong, nonatomic) UILabel *titleLabel;  //标题Label
@property (strong, nonatomic) UILabel *priceLabel;  //价格Label

@end

@implementation DetailsTitleLabelView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.priceLabel];
        
        [self addLayout];
    }
    return self;
}

- (void) addLayout {    //因为这里的约束需要在使用的时候修改，所以不能使用LayoutSubViews
    __weak typeof (self) weakSelf = self;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top);
        make.right.equalTo(weakSelf.mas_right).offset(-15);
        make.left.equalTo(weakSelf.mas_left).offset(15);
        make.height.equalTo(@60); //因为此label的长度不定，有可能需要占用多行，在下面会重写，需要用update方法
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(25);
        make.left.right.equalTo(weakSelf);
        make.height.equalTo(@20);
    }];
}


//取出model中的值，并给Label赋值
- (void) setTitleArray:(NSArray *)titleArray {
    
    _titleArray = titleArray;
    
    for (DetailsModel *detailsModel in titleArray) {
        if ([detailsModel.product_id isEqualToString:_productID]) {
            _titleLabel.text = detailsModel.title;

            CGFloat titleLabelHeight = [NSString returnLabelTextHeight:detailsModel.title width:VIEW_WIDTH - 60 fontSize:[UIFont boldSystemFontOfSize:18.0]];
            [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(titleLabelHeight);
            }];
            
            _priceLabel.attributedText = [NSMutableAttributedString makeListPriceText:detailsModel.marketprice WithMarketPrice:detailsModel.price];
            
            if (_heightBlock) {
                _heightBlock(70.0 + titleLabelHeight);
            }
        }
    }
    
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
//        _titleLabel.text = @"test";
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.text = @"test";
//        _priceLabel.backgroundColor = [UIColor yellowColor];
    }
    return _priceLabel;
}

@end
