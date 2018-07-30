//
//  DeleteProductViewController.m
//  Shop
//
//  Created by 朱啸 on 2018/5/13.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "DeleteProductViewController.h"
#import "DeleteProductTableView.h"
#import "DBProduct.h"

@interface DeleteProductViewController ()

@property (strong, nonatomic) DeleteProductTableView *deleteTableView;

@end

@implementation DeleteProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.deleteTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self.view addSubview:self.deleteTableView];
}

- (DeleteProductTableView *)deleteTableView {
    if (!_deleteTableView) {
        _deleteTableView = [[DeleteProductTableView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT - 50)];
        _deleteTableView.productArray = [NSMutableArray array];
        [_deleteTableView.productArray  addObjectsFromArray:[self requestProductData]];
    }
    return _deleteTableView;
}

- (NSArray *) requestProductData {
    [[DBProduct sharedInstance] LinkDatabaseAndAddToQueue];
    [[DBProduct sharedInstance] selectAllMethod];
    NSArray *productArray = [[NSUserDefaults standardUserDefaults] valueForKey:@"ArryProduct"];
    return productArray;
}


@end
