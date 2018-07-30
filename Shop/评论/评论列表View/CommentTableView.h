//
//  CommentTableView.h
//  Shop
//
//  Created by 朱啸 on 2018/5/20.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableView : UITableView

@property (strong, nonatomic) NSArray *textArray;  //由评论列表controller传过来的text
@property (strong, nonatomic) NSArray *timeArray;  //由评论列表controller传过来的time

@end
