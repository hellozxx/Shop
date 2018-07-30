//
//  LandingPutView.h
//  Shop
//
//  Created by 朱啸 on 2018/4/16.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^nextViewControllerBlock)(NSDictionary *dic);

typedef NS_ENUM(NSInteger, JxbLoginShowType) {
    JxbLoginShowType_NONE,
    JxbLoginShowType_USER,
    JxbLoginShowType_PASS
};

@interface LandingInPutView : UIView

@property (copy, nonatomic) nextViewControllerBlock landingBlock;//去往下一个页面回调的block

@end
