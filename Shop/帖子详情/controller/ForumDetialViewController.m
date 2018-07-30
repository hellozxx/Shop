//
//  ForumDetialViewController.m
//  Shop
//
//  Created by 朱啸 on 2018/5/11.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "ForumDetialViewController.h"
#import "ForumDetialView.h"
#import "ForumListModel.h"
#import "MJExtension.h" //mj数据转模型
#import "NSString+StringHelp.h"

@interface ForumDetialViewController()<UIScrollViewDelegate>

@property (strong, nonatomic) ForumDetialView *forumDetialView; //帖子详情view
@property (strong, nonatomic) UIScrollView *mainScroll; //最底层滑动视图

@property (strong, nonatomic) NSArray *forumModelArry;  //存放论坛数据模型的数组

@end

@implementation ForumDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mainScroll];
    
    [self requestForumData];
    
    [self.mainScroll addSubview:self.forumDetialView];
}

- (UIScrollView *)mainScroll {
    if (!_mainScroll) {
        _mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT - 50)];
        _mainScroll.contentSize = CGSizeMake(0, 1000);  //滑动范围
        _mainScroll.delegate = self;
    }
    return _mainScroll;
}

- (ForumDetialView *)forumDetialView {
    if (!_forumDetialView) {
        _forumDetialView = [[ForumDetialView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
        
//        _forumDetialView.timeLabel.text = [_forumModelArry valueForKey:@"forum_title"];
        
        for ( ForumListModel *model in _forumModelArry) {
            if ([model.forum_title isEqualToString:_DetailsForumId]) {
                _forumDetialView.titleLabel.text = model.forum_title;
                _forumDetialView.textLabel.text = model.forum_text;
                _forumDetialView.timeLabel.text = model.time;
                _forumDetialView.image1.image = [UIImage imageWithContentsOfFile:model.forum_image1];
                _forumDetialView.image2.image = [UIImage imageWithContentsOfFile:model.forum_image2];
            }
        }
    }
    return _forumDetialView;
}

- (void) requestForumData {
    self.forumModelArry = [ForumListModel mj_objectArrayWithKeyValuesArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"ArryForum"]];
//    Log(@"forumModelArry---%@",self.forumModelArry);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
