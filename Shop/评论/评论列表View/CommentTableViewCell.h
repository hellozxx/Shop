//
//  CommentTableViewCell.h
//  Shop
//
//  Created by 朱啸 on 2018/5/20.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell

@property (strong, nonatomic) UILabel *timeLabel;  //时间Label
@property (strong, nonatomic) UILabel *text;   //正文Label

@end
