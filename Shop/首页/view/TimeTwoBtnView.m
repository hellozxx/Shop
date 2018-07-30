//
//  TimeTwoBtnView.m
//  Shop
//
//  Created by 朱啸 on 2018/4/25.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "TimeTwoBtnView.h"

@interface TimeTwoBtnView()



@end

@implementation TimeTwoBtnView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.button1];
        [self addSubview:self.button2];
    }
    return self;
}

- (UIButton *)button1{
    if (!_button1) {
        _button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        //        _button1.backgroundColor = MainColor;
        _button1.frame = CGRectMake(0, 0, VIEW_WIDTH/2, 50);
//        [_button1 addTarget:self action:@selector(changeTableFrame:) forControlEvents:UIControlEventTouchUpInside];
        
        [_button1 setTitle:@"全部商品" forState:UIControlStateNormal];
        [_button1 setImage:[UIImage imageNamed:@"限时特卖界面新品团购图标未选中"] forState:UIControlStateNormal];
        [_button1 setImage:[UIImage imageNamed:@"限时特卖界面新品团购图标"] forState:UIControlStateSelected];
        [_button1 setTitleColor:RGB(56, 166, 243) forState:UIControlStateNormal];
        [_button1 setTitleColor:RGB(213, 48, 34) forState:UIControlStateSelected];
        _button1.selected = YES;    //默认为选中状态
    }
    return _button1;
}

- (UIButton *)button2{
    if (!_button2) {
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        //        _button2.backgroundColor = MainColor;
        _button2.frame = CGRectMake(VIEW_WIDTH/2, 0, VIEW_WIDTH/2, 50);
//        [_button2 addTarget:self action:@selector(changeTableFrame:) forControlEvents:UIControlEventTouchUpInside];
        
        [_button2 setTitle:@"查看论坛" forState:UIControlStateNormal];
        [_button2 setImage:[UIImage imageNamed:@"限时特卖界面品牌团购图标"] forState:UIControlStateNormal];
        [_button2 setImage:[UIImage imageNamed:@"限时特卖界面品牌团购图标选中"] forState:UIControlStateSelected];
        [_button2 setTitleColor:RGB(56, 166, 243) forState:UIControlStateNormal];
        [_button2 setTitleColor:RGB(213, 48, 34) forState:UIControlStateSelected];
        _button2.selected = NO;    //默认为不选中状态
    }
    return _button2;
}

@end
