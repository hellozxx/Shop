//
//  LoginView.h
//  Shop
//
//  Created by 朱啸 on 2018/4/17.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^loginMethodBlock)(NSDictionary *dic);
typedef NS_ENUM(NSInteger, JxbLoginShowType) {
    JxbLoginShowType_NONE,
    JxbLoginShowType_USER,
    JxbLoginShowType_PASS
};

@interface LoginView : UIView

@property (copy, nonatomic) loginMethodBlock loginBlock;  //登录信息返回，去往下一个页面的block

@end
