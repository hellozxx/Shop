//
//  DetailsTopImageView.m
//  Shop
//
//  Created by 朱啸 on 2018/4/25.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "DetailsTopImageView.h"
#import "SDCycleScrollView.h"
#import "DetailsModel.h"

@interface DetailsTopImageView()

@property (strong, nonatomic) SDCycleScrollView *headImageView; //广告轮播
@property (strong, nonatomic) UILabel *buyNumLabel; //已经有所少人购买了

@end

@implementation DetailsTopImageView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headImageView];
//        [self addSubview:self.buyNumLabel];
        
        __weak typeof (self) weakSelf = self;
        
        [_buyNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(90, 22));
            make.bottom.equalTo(weakSelf.mas_bottom).offset(-30);
            make.right.equalTo(weakSelf.mas_right).offset(11);  //右移一个圆弧的距离
        }];
    }
    return self;
}

- (void)setImageArray:(NSArray *)imageArray {
    _headImageView.localizationImageNamesGroup = imageArray;
}

- (void)setBuyNum:(NSString *)buyNum {
    _buyNumLabel.text = buyNum;
}

//请求轮播图数据
- (SDCycleScrollView *)headImageView {
    if (!_headImageView) {
        
        // 情景一：采用本地图片实现
//        NSArray *imageNames = @[@"01.png",
//                                @"02.png",
//                                @"03.png",
//                                @"04.png"// 本地图片请填写全名
//                                ];
        // >>>>>>>>>>>>>>>>>>>>>>>>> demo轮播图1 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        // 本地加载 --- 创建不带标题的图片轮播器
        //        _headImageView =[[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 230)];
//        _headImageView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 380) shouldInfiniteLoop:YES imageNamesGroup:imageNames];
        _headImageView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 380) delegate:nil placeholderImage:[UIImage imageNamed:@"图标"]];
        _headImageView.backgroundColor = [UIColor orangeColor];
        
        _headImageView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        _headImageView.scrollDirection = UICollectionViewScrollDirectionVertical;
        //         --- 轮播时间间隔，默认1.0秒，可自定义
        //cycleScrollView.autoScrollTimeInterval = 4.0;
        
    }
    return _headImageView;
}

- (UILabel *)buyNumLabel {
    if (!_buyNumLabel) {
        _buyNumLabel = [[UILabel alloc] init];
        _buyNumLabel.text = @"1000人已购买";
        _buyNumLabel.backgroundColor = RGB(230, 51, 37);
        _buyNumLabel.textColor = [UIColor whiteColor];
        //给Label画半圆角
        _buyNumLabel.layer.masksToBounds = YES;
        _buyNumLabel.layer.cornerRadius = 11;
        _buyNumLabel.textAlignment = NSTextAlignmentCenter; //文字居中
        _buyNumLabel.font = [UIFont systemFontOfSize:11.0];
    }
    return _buyNumLabel;
}

@end
