//
//  MyMessageHeadView.h
//  Shop
//
//  Created by 朱啸 on 2018/4/12.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LandingButtonBlock)(void);
typedef void(^loginButtonBlock)(void);

@interface MyMessageHeadView : UIView

@property (copy, nonatomic) LandingButtonBlock landingBlock;
@property (copy, nonatomic) loginButtonBlock loginBlock;

- (void) reloadHeadView;

@end
