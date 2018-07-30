//
//  NewAddressView.h
//  Shop
//
//  Created by 朱啸 on 2018/5/7.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^saveAddressBlock)(void);

@interface NewAddressView : UIView

@property (strong, nonatomic) UITextField *consigneeText;
@property (strong, nonatomic) UITextField *phoneNumberText;
@property (strong, nonatomic) UITextView *addressText;

@property (strong, nonatomic) saveAddressBlock saveAddress; //保存地址的回调，保存button的点击事件

@end
