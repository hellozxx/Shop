//
//  BottomImageView.m
//  Shop
//
//  Created by 朱啸 on 2018/5/3.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "BottomImageView.h"
#import "DetailsModel.h"

@interface BottomImageView()


@end

@implementation BottomImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

//利用遍历数组中的值，添加图片view
- (void)setImageArray:(NSArray *)imageArray {
    
    CGFloat imageHeight = 0;
    for (NSString *imageModel in imageArray) {
        if (![imageModel isEqualToString:@""]) {    //为空则表示此数据库中的detailsImage没有存储图片
            CGFloat height = [UIImage imageWithContentsOfFile:imageModel].size.width / [UIImage imageWithContentsOfFile:imageModel].size.height * [UIImage imageWithContentsOfFile:imageModel].size.height / 2;
            Log(@"image = %@",imageModel);
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, imageHeight, VIEW_WIDTH, height)];
            image.image = [UIImage imageWithContentsOfFile:imageModel];
            Log(@"height：%f",height);
            [self addSubview:image];
            imageHeight += height;
        }
    }
    
    if (_imageHeightBlock) {
        _imageHeightBlock(imageHeight);
    }
}


@end
