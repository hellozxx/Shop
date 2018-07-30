//
//  CommentListViewController.m
//  Shop
//
//  Created by 朱啸 on 2018/5/23.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "CommentListViewController.h"
#import "CommentTableView.h"    //评论列表tableview
#import "DBComment.h"

@interface CommentListViewController ()

@property (strong, nonatomic) CommentTableView *commentTable;

@end

@implementation CommentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.commentTable];
}

- (CommentTableView *)commentTable {
    if (!_commentTable) {
        _commentTable = [[CommentTableView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT - 80)];
        
        [[DBComment sharedInstance] LinkDatabaseAndAddToQueue];
        _commentTable.textArray = [[DBComment sharedInstance] selectTextWithProduct_ID:self.productID];
        _commentTable.timeArray = [[DBComment sharedInstance] selecttimeWithProduct_ID:self.productID];
        
    }
    return _commentTable;
}


@end
