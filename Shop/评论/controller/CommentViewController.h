//
//  CommentViewController.h
//  Shop
//
//  Created by 朱啸 on 2018/5/20.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentViewController : UIViewController

@property (strong, nonatomic) NSString *productID;  //接收由待评价页面传过来的productID
@property (strong, nonatomic) NSString *orderID;    //接收由待评价页面传过来的orderID

@end
