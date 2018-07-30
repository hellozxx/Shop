//
//  DetailsViewController.m
//  Shop
//
//  Created by 朱啸 on 2018/4/25.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "DetailsViewController.h"
#import "DetailsTopImageView.h" //顶部轮播图片
#import "DetailsModel.h"   //图片model
#import "MJExtension.h" //mj数据转模型
#import "DBObject.h"
#import "DBProductDetail.h"
#import "DetailsTwoBtnView.h"   //两个button的view
#import "DetailsTitleLabelView.h"   //商品名称和价格view
#import "DetailsContentView.h"  //图文详情View
#import "BottomImageView.h" //底部多张图片view
#import "ThreeButtonView.h" //底部购买按钮
#import "UIView+Toast.h"    //toast弹框
#import "SZKImagePickerVC.h"
#import "CommentListViewController.h"


@interface DetailsViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *mainScroll; //底部滚动式图
@property (strong, nonatomic) DetailsTopImageView *topImageView;    //顶部轮播图片

@property (strong, nonatomic) DetailsTitleLabelView *detailsTitleView;  //商品名称和价格view
@property (strong, nonatomic) DetailsTwoBtnView *twoButtonView;    //两个button的view
@property (strong, nonatomic) DetailsContentView *contentView;  //图文详情view
@property (strong, nonatomic) BottomImageView *bottomImageView; //底部图片展示View

@property (assign, nonatomic) CGFloat scrollContentHeight;  //scroll内部高度

@property (strong, nonatomic) ThreeButtonView *buyNowView;  //购买view
@property (assign, nonatomic) BOOL flag;    //用来判断当前选择的button为哪一个，然后决定显示哪一个View



@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.flag = YES;
    
    self.scrollContentHeight = 440; //先给一个轮播图的高度
    
    [self.view addSubview:self.mainScroll];
    
    __weak typeof (self) weakSelf = self;
    
    [_mainScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(0, 0, 45, 0));   //距离view的底部45px，留给购买的View
    }];
    
    [self.mainScroll addSubview:self.topImageView];
    
    [self.mainScroll addSubview:self.detailsTitleView];
    
    [_detailsTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.topImageView.mas_bottom);
        make.left.right.equalTo(weakSelf.view);
        make.height.equalTo(@100);
    }];
    
    [self.mainScroll addSubview:self.contentView];
    
    [self.mainScroll addSubview:self.twoButtonView];
    
    [_twoButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.detailsTitleView.mas_bottom);
        make.left.right.equalTo(weakSelf.view);
        make.height.equalTo(@50);
    }];
    
    
    
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.twoButtonView.mas_bottom);
        make.left.right.equalTo(weakSelf.view);
        
    }];
    
    [self.mainScroll addSubview:self.bottomImageView];
    [_bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.contentView.mas_bottom);
    }];
    
    [self.view addSubview:self.buyNowView];
    
    [self requestImageData];
    
    [self requestTitleData];
    
    [self requestGoodsDetail];
    
    [self requestBottomImageData];
    
    
}


//DetailsTopImageView调用
- (void) requestImageData {
    Log(@"detailsProductID = %@",_DetailsProductId);
    
    //把值传给model，然后DetailsTopImageView里面会调用
    NSArray *imageArray = [DetailsModel mj_objectArrayWithKeyValuesArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"ArrayProductDetial"]];
    
    NSMutableArray *topImageArray = [NSMutableArray arrayWithCapacity:0];
    
    for (DetailsModel *imageModel in imageArray) {
        if ([imageModel.product_id isEqualToString:_DetailsProductId]) {
            [topImageArray addObject:imageModel.topImage1];
            [topImageArray addObject:imageModel.topImage2];
            [topImageArray addObject:imageModel.topImage3];
            [topImageArray addObject:imageModel.topImage4];
        }
    }
    Log(@"imageArray : %@",imageArray);
    _topImageView.imageArray = topImageArray;
    
    
}


//DetailsTitleLabelView调用
- (void) requestTitleData {
    
    _detailsTitleView.productID = _DetailsProductId;    //必须要在上面，注意加载顺序
    
    NSArray *titleModel = [DetailsModel mj_objectArrayWithKeyValuesArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"ArrayProductDetial"]];
    _detailsTitleView.titleArray = titleModel;
    
    
}


//DetialsContentView调用
- (void) requestGoodsDetail {
    
    _contentView.productID = _DetailsProductId;
    
    NSArray *goodsModel = [DetailsModel mj_objectArrayWithKeyValuesArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"ArrayProductDetial"]];
    _contentView.contentArray = goodsModel;
}

//BottomImageView调用
- (void) requestBottomImageData {
    
    _bottomImageView.productID = _DetailsProductId;
    
    //把值传给model，然后BottomImageView里面会调用
    NSArray *imageArray = [DetailsModel mj_objectArrayWithKeyValuesArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"ArrayProductDetial"]];
    
    NSMutableArray *bottomImageArray = [NSMutableArray arrayWithCapacity:0];
    
    for (DetailsModel *imageModel in imageArray) {
        if ([imageModel.product_id isEqualToString:_DetailsProductId]) {
            [bottomImageArray addObject:imageModel.detailImage1];
            [bottomImageArray addObject:imageModel.detailImage2];
            [bottomImageArray addObject:imageModel.detailImage3];
            [bottomImageArray addObject:imageModel.detailImage4];
        }
    }
    _bottomImageView.imageArray = bottomImageArray;
}

- (UIScrollView *)mainScroll {
    if (!_mainScroll) {
        _mainScroll = [[UIScrollView alloc] init];
        _mainScroll.contentSize = CGSizeMake(0, 1000);
        _mainScroll.backgroundColor = [UIColor whiteColor];
        _mainScroll.delegate = self;
    }
    return _mainScroll;
}

//监听、滑动的时候形成吸附效果，把twoButtonView吸附
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > 580) { //滚动超过230
        CGRect rect = _twoButtonView.bounds;
        rect.origin.y = scrollView.contentOffset.y;
        _twoButtonView.frame = rect;
    }else {
        CGRect rect = _twoButtonView.bounds;
        rect.origin.y = 580;
        _twoButtonView.frame = rect;
    }
}

- (DetailsTopImageView *)topImageView {
    if (!_topImageView) {
        _topImageView = [[DetailsTopImageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 380)];
    }
    return _topImageView;
}

- (DetailsTitleLabelView *)detailsTitleView {
    if (!_detailsTitleView) {
        _detailsTitleView = [[DetailsTitleLabelView alloc] init];
//        _detailsTitleView.backgroundColor = [UIColor blueColor];
        
        __weak typeof (self) weakSelf = self;
        //由view传过来的值--view的高度
        _detailsTitleView.heightBlock = ^(CGFloat height) {
//            Log(@"height = %lf",height);
            [weakSelf.detailsTitleView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height);
            }];
            weakSelf.scrollContentHeight += height;
            weakSelf.mainScroll.contentSize = CGSizeMake(0, weakSelf.scrollContentHeight);
        };
        
    }
    return _detailsTitleView;
}

- (DetailsTwoBtnView *)twoButtonView {
    if (!_twoButtonView) {
        _twoButtonView = [[DetailsTwoBtnView alloc] init];
//        _twoButtonView = [[DetailsTwoBtnView alloc] initWithFrame:CGRectMake(0, 400, VIEW_WIDTH, 50)];
//        _twoButtonView.backgroundColor = [UIColor orangeColor];
//        [_twoButtonView.button1 addTarget:self action:@selector(changeTableFrame:) forControlEvents:UIControlEventTouchUpInside];
        [_twoButtonView.button2 addTarget:self action:@selector(jumpToCommentListMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _twoButtonView;
}

- (void) jumpToCommentListMethod {
    CommentListViewController *commentList = [[CommentListViewController alloc] init];
    commentList.productID = self.DetailsProductId;
    [self.navigationController pushViewController:commentList animated:YES];
}


- (DetailsContentView *)contentView {
    if (!_contentView) {
        _contentView = [[DetailsContentView alloc] init];
        
        //由view传过来的值--view的高度
        __weak typeof (self) weakSelf = self;
        _contentView.heightBlock = ^(CGFloat height) {
//            Log(@"height = %lf",height);
            [weakSelf.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height);
            }];
            weakSelf.scrollContentHeight += height;
            weakSelf.mainScroll.contentSize = CGSizeMake(0, weakSelf.scrollContentHeight);
        };
    }
    return _contentView;
}

- (BottomImageView *)bottomImageView {
    if (!_bottomImageView) {
        _bottomImageView = [[BottomImageView alloc] init];
        
        __weak typeof (self) weakSelf = self;
        
        _bottomImageView.imageHeightBlock = ^(CGFloat height) {
            [weakSelf.bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height);
            }];
            weakSelf.scrollContentHeight += height;
            weakSelf.mainScroll.contentSize = CGSizeMake(0, weakSelf.scrollContentHeight);
        };
    }
    return _bottomImageView;
}


- (ThreeButtonView *)buyNowView {
    if (!_buyNowView) {
        _buyNowView = [[ThreeButtonView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT - 120, VIEW_WIDTH, 60)];
        //把product_id传给加入购物车按钮
        _buyNowView.productID = _DetailsProductId;
//        __weak typeof (self) weakSelf = self;
//        _buyNowView.addBlock = ^{
//            [weakSelf addProductShoppingCartMethod];
//        };
    }
    return _buyNowView;
}




@end
