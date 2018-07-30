//
//  PriceView.h
//  Shop
//
//  Created by 朱啸 on 2018/5/6.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^gotoInsertBlock)(void);

@interface PriceView : UIView

@property (strong, nonatomic)   UILabel *priceLabel;    //商品价格

@property (copy, nonatomic) gotoInsertBlock gotoInsert; //去结算回调,用于去结算按钮的点击事件

@end
