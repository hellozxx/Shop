//
//  BottomImageView.h
//  Shop
//
//  Created by 朱啸 on 2018/5/3.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^returnImageHeightBlock)(CGFloat height);

@interface BottomImageView : UIView

@property (strong, nonatomic) NSArray *imageArray;  //接收存储图片信息的数组
@property (copy, nonatomic) NSString *productID;    //传过来的productID

@property (copy, nonatomic) returnImageHeightBlock imageHeightBlock;    //返回图片高度Block

@end
