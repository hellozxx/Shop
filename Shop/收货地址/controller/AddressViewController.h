//
//  AddressViewController.h
//  Shop
//
//  Created by 朱啸 on 2018/5/7.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^freshAddressViewBlock)(void);

@interface AddressViewController : UIViewController

- (void) addressISNil;

@property (strong, nonatomic) freshAddressViewBlock freshAddress;

@end
