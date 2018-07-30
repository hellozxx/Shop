//
//  MyMessageTableView.h
//  Shop
//
//  Created by 朱啸 on 2018/4/12.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^exitBtnMethodBlock)(void);

@interface MyMessageTableView : UITableView

@property (copy, nonatomic) exitBtnMethodBlock exitBlock;

@end
