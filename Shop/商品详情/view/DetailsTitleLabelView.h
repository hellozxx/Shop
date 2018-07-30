//
//  DetailsTitleLabelView.h
//  Shop
//
//  Created by 朱啸 on 2018/4/29.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailsModel.h"

typedef void(^returnViewHeightBlock)(CGFloat height);

@interface DetailsTitleLabelView : UIView

@property (strong, nonatomic) NSArray *titleArray; //titleView存储数据的model
@property (copy, nonatomic) NSString *productID;    //传过来的productID

@property (copy, nonatomic) returnViewHeightBlock heightBlock;    //  返回给viewcontroller的值：view的最终高度

@end
