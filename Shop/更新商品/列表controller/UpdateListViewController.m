//
//  UpdateListViewController.m
//  Shop
//
//  Created by 朱啸 on 2018/5/13.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "UpdateListViewController.h"
#import "UpdateCollectionView.h"
#import "UpdateDetailViewController.h"

@interface UpdateListViewController ()

@property (strong, nonatomic) UpdateCollectionView *listView;  //展示列表

@end

@implementation UpdateListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainColor;
    self.edgesForExtendedLayout = 0;
    [self.view addSubview:self.listView];
    [_listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(10);
    }];
}


- (UpdateCollectionView *)listView {
    if (!_listView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        NSInteger itemWidth = (VIEW_WIDTH - 10) / 2;
        flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth / 0.725);  //10是两个框直接的间隔,高是按照宽的比例来算的
        _listView = [[UpdateCollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
        _listView.backgroundColor = MainColor;
        _listView.proguctListArray = self.listModel;    //把值表单传到ProductListSearchView中的proguctListArray
        
        //把productID传给DetailsViewController
        __weak typeof (self) weakSelf = self;
        _listView.productIdBlock = ^(NSString *productID) {
            [weakSelf updateMethod:productID];
        };
    }
    return _listView;
}

//点击事件
- (void) updateMethod:(NSString *)productID {
    UpdateDetailViewController *detial = [[UpdateDetailViewController alloc] init];
    detial.productID = productID;
    [self.navigationController pushViewController:detial animated:YES];
    Log(@"productID = %@",productID);
}


@end
