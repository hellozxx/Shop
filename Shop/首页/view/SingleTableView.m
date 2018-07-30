//
//  SingleTableView.m
//  Shop
//
//  Created by 朱啸 on 2018/4/25.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "SingleTableView.h"
#import "SingleTableViewCell.h" //商品列表cell
#import "ForumTableCell.h"  //论坛列表cell

@interface SingleTableView()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SingleTableView

- (instancetype) initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.bounces = NO;
    }
    return self;
}

- (void) setSingleModelArray:(NSArray *)singleModelArray {
    _singleModelArray = singleModelArray;
    [self reloadData];
}

- (void) setForumModelArry:(NSArray *)forumModelArry {
    _forumModelArry = forumModelArry;
    [self reloadData];
}

//以后想要修改限时购页面显示的商品个数，必须要修改这里
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_isSingle) {
        Log(@"self.singleModelArray.count = %lu",(unsigned long)self.singleModelArray.count);
        return self.singleModelArray.count;
    }else {
        Log(@"self.forumModelArry.count = %lu",self.forumModelArry.count);
        return self.forumModelArry.count;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_isSingle) {
        return 170;
    }else
        return 200; //table中一个cell的高度
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
     if (!cell) {
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
     }
     cell.textLabel.text = [NSString stringWithFormat:@"%li",(long)indexPath.row];*/
    
    if (_isSingle) {
        //        cell.backgroundColor = [UIColor redColor];
        SingleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"singleCell"];
        if (!cell) {
            cell = [[SingleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"singleCell"];
            //把当前cell的productid创给cell
            cell.productID = [self.singleModelArray[indexPath.row] product_id];
        }
        cell.singleModel = self.singleModelArray[indexPath.row];
        return cell;
    }else {
        //        cell.backgroundColor = [UIColor purpleColor];
        ForumTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"forumCell"];
        if (!cell) {
            cell = [[ForumTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"forumCell"];
        }
        //        cell.textLabel.text = [NSString stringWithFormat:@"%li",(long)indexPath.row];
        cell.forumModel = self.forumModelArry[indexPath.row];
        return cell;
    }
    
}

//把productid传给controller，点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (_isSingle) {
        if (_productIDBlock) {
            _productIDBlock([self.singleModelArray[indexPath.row] product_id]);
        }
    }else {
        if (_forumIDBlock) {
            _forumIDBlock([self.forumModelArry[indexPath.row] forum_title]);
        }
    }
}







@end
