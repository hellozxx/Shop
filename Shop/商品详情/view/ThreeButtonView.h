//
//  ThreeButtonView.h
//  Shop
//
//  Created by 朱啸 on 2018/5/3.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^addshoppingCartBlock)();

@interface ThreeButtonView : UIView

@property (copy,nonatomic) addshoppingCartBlock addBlock;   //加入购物车回调
@property (copy, nonatomic) NSString *productID;    //传过来的productID

@end
