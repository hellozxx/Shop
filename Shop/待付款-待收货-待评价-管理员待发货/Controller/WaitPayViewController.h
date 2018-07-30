//
//  WaitPayViewController.h
//  Shop
//
//  Created by 朱啸 on 2018/5/10.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaitPayViewController : UIViewController

@property (strong, nonatomic) NSString *waitForWhat;    //传参数过来，这样就知道是执行哪一个操作：待付款、待收货、待评价、管理员的待发货

@end
