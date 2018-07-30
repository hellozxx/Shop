//
//  UpdateDetailViewController.m
//  Shop
//
//  Created by 朱啸 on 2018/5/13.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "UpdateDetailViewController.h"
#import "AddProductView.h"
#import "DBProduct.h"
#import "DBProductDetail.h"
#import "UIView+Toast.h"    //toast弹框
#import "SZKImagePickerVC.h"

@interface UpdateDetailViewController ()<SZKImagePickerVCDelegate,UIActionSheetDelegate>

@property (strong, nonatomic) AddProductView *updateProductView;
@property (assign, nonatomic) int whichOneButton;   //0:iconButton  1-4:topPhotoButton  5-8:detailPhotoButton

@end

@implementation UpdateDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.updateProductView];
    //注册观察键盘的变化
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(transformView:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (AddProductView *)updateProductView {
    if (!_updateProductView) {
        _updateProductView = [[AddProductView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT-100)];
        [self defaultText];
        
        
        [[DBProduct sharedInstance] LinkDatabaseAndAddToQueue];
        [[DBProductDetail sharedInstance] LinkDatabaseAndAddToQueue];
        
        [_updateProductView.iconPhotoButton addTarget:self action:@selector(iconPhotoButtonMethod) forControlEvents:UIControlEventTouchUpInside];
        [_updateProductView.topPhotoButton1 addTarget:self action:@selector(topPhotoButton1Method) forControlEvents:UIControlEventTouchUpInside];
        [_updateProductView.topPhotoButton2 addTarget:self action:@selector(topPhotoButton2Method) forControlEvents:UIControlEventTouchUpInside];
        [_updateProductView.topPhotoButton3 addTarget:self action:@selector(topPhotoButton3Method) forControlEvents:UIControlEventTouchUpInside];
        [_updateProductView.topPhotoButton4 addTarget:self action:@selector(topPhotoButton4Method) forControlEvents:UIControlEventTouchUpInside];
        [_updateProductView.detailPhotoButton1 addTarget:self action:@selector(detailPhotoButton1Method) forControlEvents:UIControlEventTouchUpInside];
        [_updateProductView.detailPhotoButton2 addTarget:self action:@selector(detailPhotoButton2Method) forControlEvents:UIControlEventTouchUpInside];
        [_updateProductView.detailPhotoButton3 addTarget:self action:@selector(detailPhotoButton3Method) forControlEvents:UIControlEventTouchUpInside];
        [_updateProductView.detailPhotoButton4 addTarget:self action:@selector(detailPhotoButton4Method) forControlEvents:UIControlEventTouchUpInside];
        [_updateProductView.addProductButton addTarget:self action:@selector(updateProductButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _updateProductView;
}

//设置默认的text
- (void) defaultText {
    [_updateProductView.idText setEnabled:NO];  //设置id为不可编辑
    [_updateProductView.addProductButton setTitle:@"确认更新" forState:UIControlStateNormal];   //改变button的文字
    
    //先把数据库中的数据展现在text中
    NSArray *productListArray = [[NSUserDefaults standardUserDefaults] valueForKey:@"ArryProduct"];
    for (NSDictionary *productListDic in productListArray) {
        if ([[productListDic valueForKey:@"product_id"] isEqualToString:self.productID]) {
            _updateProductView.idText.text = self.productID;
            _updateProductView.nameText.text = [productListDic valueForKey:@"product_name"];
            [_updateProductView.iconPhotoButton setBackgroundImage:[UIImage imageWithContentsOfFile:[productListDic valueForKey:@"product_iconimage"]] forState:UIControlStateNormal];
            _updateProductView.classText.text = [productListDic valueForKey:@"product_categoryid"];
            _updateProductView.priceText.text = [productListDic valueForKey:@"product_price"];
            _updateProductView.marketPriceText.text = [productListDic valueForKey:@"product_marketprice"];
            _updateProductView.descriptionText.text = [productListDic valueForKey:@"product_description"];
        }
    }
    
    NSArray *producDetailArray = [[NSUserDefaults standardUserDefaults] valueForKey:@"ArrayProductDetial"];
    for (NSDictionary *productDetialDic in producDetailArray) {
        if ([[productDetialDic valueForKey:@"product_id"] isEqualToString:self.productID]) {
            _updateProductView.brandText.text = [productDetialDic valueForKey:@"brand"];
            _updateProductView.placeText.text = [productDetialDic valueForKey:@"place"];
            _updateProductView.modelText.text = [productDetialDic valueForKey:@"model"];
            _updateProductView.ageText.text = [productDetialDic valueForKey:@"age"];
            [_updateProductView.topPhotoButton1 setBackgroundImage:[UIImage imageWithContentsOfFile:[productDetialDic valueForKey:@"topImage1"]] forState:UIControlStateNormal];
            [_updateProductView.topPhotoButton2 setBackgroundImage:[UIImage imageWithContentsOfFile:[productDetialDic valueForKey:@"topImage2"]] forState:UIControlStateNormal];
            [_updateProductView.topPhotoButton3 setBackgroundImage:[UIImage imageWithContentsOfFile:[productDetialDic valueForKey:@"topImage3"]] forState:UIControlStateNormal];
            [_updateProductView.topPhotoButton4 setBackgroundImage:[UIImage imageWithContentsOfFile:[productDetialDic valueForKey:@"topImage4"]] forState:UIControlStateNormal];
            
            [_updateProductView.detailPhotoButton1 setBackgroundImage:[UIImage imageWithContentsOfFile:[productDetialDic valueForKey:@"detailImage1"]] forState:UIControlStateNormal];
            [_updateProductView.detailPhotoButton2 setBackgroundImage:[UIImage imageWithContentsOfFile:[productDetialDic valueForKey:@"detailImage2"]] forState:UIControlStateNormal];
            [_updateProductView.detailPhotoButton3 setBackgroundImage:[UIImage imageWithContentsOfFile:[productDetialDic valueForKey:@"detailImage3"]] forState:UIControlStateNormal];
            [_updateProductView.detailPhotoButton4 setBackgroundImage:[UIImage imageWithContentsOfFile:[productDetialDic valueForKey:@"detailImage4"]] forState:UIControlStateNormal];
        }
    }
}

#pragma mark----跳转到SZKImagePickerVC中
- (void)iconPhotoButtonMethod {
        self.whichOneButton = 0;
        [self isSupportCamera];
}

- (void)topPhotoButton1Method {
    self.whichOneButton = 1;
    [self isSupportCamera];
}

- (void)topPhotoButton2Method {
    self.whichOneButton = 2;
    [self isSupportCamera];
}

- (void)topPhotoButton3Method {
    self.whichOneButton = 3;
    [self isSupportCamera];
}

- (void)topPhotoButton4Method {
    self.whichOneButton = 4;
    [self isSupportCamera];
}

- (void)detailPhotoButton1Method {
    self.whichOneButton = 5;
    [self isSupportCamera];
}

- (void)detailPhotoButton2Method {
    self.whichOneButton = 6;
    [self isSupportCamera];
}

- (void)detailPhotoButton3Method {
    self.whichOneButton = 7;
    [self isSupportCamera];
}

- (void)detailPhotoButton4Method {
    self.whichOneButton = 8;
    [self isSupportCamera];
}

- (void) isSupportCamera {
    //判断是否支持相机  模拟器去除相机功能
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"打开照相机",@"从相册上传" ,nil];
        [sheet showInView:self.view];
    }else{
        UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册上传" ,nil];
        [sheet showInView:self.view];
    }
}

#pragma mark-----UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //判断是否支持相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        switch (buttonIndex) {
            case 0:{
                [self presentViewController:ImagePickerStyleCamera];
            }
                break;
            case 1:{
                [self presentViewController:ImagePickerStylePhotoLibrary];
            }
                break;
            default:
                break;
        }
    }else{
        switch (buttonIndex) {
            case 0:{
                [self presentViewController:ImagePickerStylePhotoLibrary];
            }
                break;
            default:
                break;
        }
    }
}
#pragma mark----跳转到SZKImagePickerVC
-(void)presentViewController:(imagePickerStyle)style
{
    SZKImagePickerVC *picker=[[SZKImagePickerVC alloc]initWithImagePickerStyle:style];
    picker.SZKDelegate=self;
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma mark----SZKImagePickerVCDelegate
-(void)imageChooseFinish:(UIImage *)image
{
    //设置保存的图片名称
    NSString *imageName;
    NSString *name0 = @"iconImage";
    NSString *name1 = @"topImage1";
    NSString *name2 = @"topImage2";
    NSString *name3 = @"topImage3";
    NSString *name4 = @"topImage4";
    NSString *name5 = @"detailImage1";
    NSString *name6 = @"detailImage2";
    NSString *name7 = @"detailImage3";
    NSString *name8 = @"detailImage4";
    switch (_whichOneButton) {
        case 0:
            [_updateProductView.iconPhotoButton setBackgroundImage:image forState:UIControlStateNormal];
            imageName = [NSString stringWithFormat:@"%@%@",self.productID,name0];
            break;
        case 1:
            [_updateProductView.topPhotoButton1 setBackgroundImage:image forState:UIControlStateNormal];
            imageName = [NSString stringWithFormat:@"%@%@",self.productID,name1];
            break;
        case 2:
            [_updateProductView.topPhotoButton2 setBackgroundImage:image forState:UIControlStateNormal];
            imageName = [NSString stringWithFormat:@"%@%@",self.productID,name2];
            break;
        case 3:
            [_updateProductView.topPhotoButton3 setBackgroundImage:image forState:UIControlStateNormal];
            imageName = [NSString stringWithFormat:@"%@%@",self.productID,name3];
            break;
        case 4:
            [_updateProductView.topPhotoButton4 setBackgroundImage:image forState:UIControlStateNormal];
            imageName = [NSString stringWithFormat:@"%@%@",self.productID,name4];
            break;
        case 5:
            [_updateProductView.detailPhotoButton1 setBackgroundImage:image forState:UIControlStateNormal];
            imageName = [NSString stringWithFormat:@"%@%@",self.productID,name5];
            break;
        case 6:
            [_updateProductView.detailPhotoButton2 setBackgroundImage:image forState:UIControlStateNormal];
            imageName = [NSString stringWithFormat:@"%@%@",self.productID,name6];
            break;
        case 7:
            [_updateProductView.detailPhotoButton3 setBackgroundImage:image forState:UIControlStateNormal];
            imageName = [NSString stringWithFormat:@"%@%@",self.productID,name7];
            break;
        case 8:
            [_updateProductView.detailPhotoButton4 setBackgroundImage:image forState:UIControlStateNormal];
            imageName = [NSString stringWithFormat:@"%@%@",self.productID,name8];
            break;
        default:
            break;
    }
    
    //保存到沙盒中
    [SZKImagePickerVC saveImageToSandbox:image andImageNage:imageName andResultBlock:^(BOOL success) {
        NSLog(@"保存成功");
    }];
}



- (void) updateProductButtonMethod {
    BOOL flag = YES;
    if ([_updateProductView.nameText.text isEqualToString:@""]) {
        flag = NO;
        [self.view makeToast:@"请检查是否输入所有的内容" duration:1.5 position:@"center"];
    }
    if ([_updateProductView.classText.text isEqualToString:@""]) {
        flag = NO;
        [self.view makeToast:@"请检查是否输入所有的内容" duration:1.5 position:@"center"];
    }
    if ([_updateProductView.priceText.text isEqualToString:@""]) {
        flag = NO;
        [self.view makeToast:@"请检查是否输入所有的内容" duration:1.5 position:@"center"];
    }
    if ([_updateProductView.marketPriceText.text isEqualToString:@""]) {
        flag = NO;
        [self.view makeToast:@"请检查是否输入所有的内容" duration:1.5 position:@"center"];
    }
    if ([_updateProductView.descriptionText.text isEqualToString:@""]) {
        flag = NO;
        [self.view makeToast:@"请检查是否输入所有的内容" duration:1.5 position:@"center"];
    }
    if ([_updateProductView.brandText.text isEqualToString:@""]) {
        flag = NO;
        [self.view makeToast:@"请检查是否输入所有的内容" duration:1.5 position:@"center"];
    }
    if ([_updateProductView.placeText.text isEqualToString:@""]) {
        flag = NO;
        [self.view makeToast:@"请检查是否输入所有的内容" duration:1.5 position:@"center"];
    }
    if ([_updateProductView.modelText.text isEqualToString:@""]) {
        flag = NO;
        [self.view makeToast:@"请检查是否输入所有的内容" duration:1.5 position:@"center"];
    }
    if ([_updateProductView.ageText.text isEqualToString:@""]) {
        flag = NO;
        [self.view makeToast:@"请检查是否输入所有的内容" duration:1.5 position:@"center"];
    }
    
    if (flag) {
        
        NSString *name0 = @"iconImage";
        NSString *name1 = @"topImage1";
        NSString *name2 = @"topImage2";
        NSString *name3 = @"topImage3";
        NSString *name4 = @"topImage4";
        NSString *name5 = @"detailImage1";
        NSString *name6 = @"detailImage2";
        NSString *name7 = @"detailImage3";
        NSString *name8 = @"detailImage4";
        NSString *name = _updateProductView.nameText.text;
        NSString *iconimage = [self filePath:[NSString stringWithFormat:@"%@%@",_updateProductView.idText.text,name0]];
        NSString *class = _updateProductView.classText.text;
        NSString *price = _updateProductView.priceText.text;
        NSString *marketPrice = _updateProductView.marketPriceText.text;
        NSString *description = _updateProductView.marketPriceText.text;
        NSString *brand = _updateProductView.brandText.text;
        NSString *place = _updateProductView.placeText.text;
        NSString *model = _updateProductView.modelText.text;
        NSString *age = _updateProductView.ageText.text;
        NSString *top1 = [self filePath:[NSString stringWithFormat:@"%@%@",_updateProductView.idText.text,name1]];
        NSString *top2 = [self filePath:[NSString stringWithFormat:@"%@%@",_updateProductView.idText.text,name2]];
        NSString *top3 = [self filePath:[NSString stringWithFormat:@"%@%@",_updateProductView.idText.text,name3]];
        NSString *top4 = [self filePath:[NSString stringWithFormat:@"%@%@",_updateProductView.idText.text,name4]];
        NSString *detail1 = [self filePath:[NSString stringWithFormat:@"%@%@",_updateProductView.idText.text,name5]];
        NSString *detail2 = [self filePath:[NSString stringWithFormat:@"%@%@",_updateProductView.idText.text,name6]];
        NSString *detail3 = [self filePath:[NSString stringWithFormat:@"%@%@",_updateProductView.idText.text,name7]];
        NSString *detail4 = [self filePath:[NSString stringWithFormat:@"%@%@",_updateProductView.idText.text,name8]];
        
        [[DBProduct sharedInstance] updateWithProduct_Id:self.productID WithName:name WithIconImage:iconimage WithCategoryId:class WithPrice:price WithMarketPrice:marketPrice WithDescription:description];
        [[DBProductDetail sharedInstance] updateWithProduct_Id:self.productID WithBrand:brand WithTitle:name WithPrice:price WithMarketPrice:marketPrice WithPlace:place WithModel:model WithCategory:class WithAge:age WithTopImage1:top1 WithTopImage2:top2 WithTopImage3:top3 WithTopImage4:top4 WithDetailImage1:detail1 WithDetailImage2:detail2 WithDetailImage3:detail3 WithDetailImage4:detail4];
        
        
        [[DBProduct sharedInstance] selectAllMethod];
        [[DBProductDetail sharedInstance] selectAllMethod];
        [self.view makeToast:@"更新成功" duration:1.5 position:@"center"];
        //跳转回“我的”页面,并延时1.5秒执行
        [self performSelector:@selector(popMyViewController) withObject:nil afterDelay:1.5];
        
    }
    
}


#pragma mark----获取沙盒路径
-(NSString *)filePath:(NSString *)fileName
{
    //获取沙盒目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //保存文件名称
    NSString *filePath=[paths[0] stringByAppendingPathComponent:fileName];
    
    return filePath;
}


//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [self.updateProductView endEditing:YES];
    
}

//移动UIView
-(void)transformView:(NSNotification *)aNSNotification
{
    //获取键盘弹出前的Rect
    NSValue *keyBoardBeginBounds=[[aNSNotification userInfo]objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect beginRect=[keyBoardBeginBounds CGRectValue];
    
    //获取键盘弹出后的Rect
    NSValue *keyBoardEndBounds=[[aNSNotification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect  endRect=[keyBoardEndBounds CGRectValue];
    
    //获取键盘位置变化前后纵坐标Y的变化值
    CGFloat deltaY=endRect.origin.y-beginRect.origin.y;
    NSLog(@"看看这个变化的Y值:%f",deltaY);
    
    //在0.25s内完成self.view的Frame的变化，等于是给self.view添加一个向上移动deltaY的动画
    [UIView animateWithDuration:0.25f animations:^{
        [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+deltaY, self.view.frame.size.width, self.view.frame.size.height)];
    }];
}

/**
 跳转回“购物车”页面
 */
- (void)popMyViewController{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
