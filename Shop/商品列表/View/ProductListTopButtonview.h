//
//  ProductListTopButtonview.h
//  Shop
//
//  Created by 朱啸 on 2018/5/4.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductListTopButtonview : UIView

@property (strong, nonatomic)   UIButton *defaultBtn;              /** 默认 */
@property (strong, nonatomic)   UIButton *priceBtn;              /** 价格 */
@property (strong, nonatomic)   UIButton *saleBtn;              /** 销量 */

@end
