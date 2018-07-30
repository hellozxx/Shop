//
//  ClassListViewController.m
//  Shop
//
//  Created by 朱啸 on 2018/5/11.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "ClassListViewController.h"
#import "ClassListCollectionView.h"   //商品列表
#import "DetailsViewController.h"   //商品详情页面

@interface ClassListViewController ()

@property (strong, nonatomic) ClassListCollectionView *listView;  //展示列表

@end


@implementation ClassListViewController

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


- (ClassListCollectionView *)listView {
    if (!_listView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        NSInteger itemWidth = (VIEW_WIDTH - 10) / 2;
        flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth / 0.725);  //10是两个框直接的间隔,高是按照宽的比例来算的
        _listView = [[ClassListCollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
        _listView.backgroundColor = MainColor;
        _listView.proguctListArray = self.listModel;    //把值表单传到ProductListSearchView中的proguctListArray
        
        //把productID传给DetailsViewController
        __weak typeof (self) weakSelf = self;
        _listView.productIdBlock = ^(NSString *productID) {
            [weakSelf pushDetailsViewController:productID];
        };
    }
    return _listView;
}

//把productID传给DetailsViewController，并跳转到商品详情页面
- (void) pushDetailsViewController:(NSString *)productID {
    DetailsViewController *details = [[DetailsViewController alloc] init];
    details.DetailsProductId = productID;
    [self.navigationController pushViewController:details animated:YES];
}


@end
