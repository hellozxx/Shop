//
//  AddProductViewController.m
//  Shop
//
//  Created by 朱啸 on 2018/5/12.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "AddProductViewController.h"
#import "AddProductView.h"
#import "SZKImagePickerVC.h"
#import "UIView+Toast.h"    //toast弹框
#import "DBProduct.h"
#import "DBProductDetail.h"

@interface AddProductViewController ()<SZKImagePickerVCDelegate,UIActionSheetDelegate>

@property (strong, nonatomic) AddProductView *addProductView;
@property (assign, nonatomic) int whichOneButton;   //0:iconButton  1-4:topPhotoButton  5-8:detailPhotoButton

@end

@implementation AddProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.addProductView];
    
    //注册观察键盘的变化
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(transformView:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (AddProductView *)addProductView {
    if (!_addProductView) {
        _addProductView = [[AddProductView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT-100)];
        
        [[DBProduct sharedInstance] LinkDatabaseAndAddToQueue];
        [[DBProductDetail sharedInstance] LinkDatabaseAndAddToQueue];
        
        [_addProductView.iconPhotoButton addTarget:self action:@selector(iconPhotoButtonMethod) forControlEvents:UIControlEventTouchUpInside];
        [_addProductView.topPhotoButton1 addTarget:self action:@selector(topPhotoButton1Method) forControlEvents:UIControlEventTouchUpInside];
        [_addProductView.topPhotoButton2 addTarget:self action:@selector(topPhotoButton2Method) forControlEvents:UIControlEventTouchUpInside];
        [_addProductView.topPhotoButton3 addTarget:self action:@selector(topPhotoButton3Method) forControlEvents:UIControlEventTouchUpInside];
        [_addProductView.topPhotoButton4 addTarget:self action:@selector(topPhotoButton4Method) forControlEvents:UIControlEventTouchUpInside];
        [_addProductView.detailPhotoButton1 addTarget:self action:@selector(detailPhotoButton1Method) forControlEvents:UIControlEventTouchUpInside];
        [_addProductView.detailPhotoButton2 addTarget:self action:@selector(detailPhotoButton2Method) forControlEvents:UIControlEventTouchUpInside];
        [_addProductView.detailPhotoButton3 addTarget:self action:@selector(detailPhotoButton3Method) forControlEvents:UIControlEventTouchUpInside];
        [_addProductView.detailPhotoButton4 addTarget:self action:@selector(detailPhotoButton4Method) forControlEvents:UIControlEventTouchUpInside];
        [_addProductView.addProductButton addTarget:self action:@selector(addProductButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addProductView;
}

#pragma mark----跳转到SZKImagePickerVC中
- (void)iconPhotoButtonMethod {
    if ([_addProductView.idText.text isEqualToString:@""]) {
        [self.view makeToast:@"请先输入商品ID" duration:1.5 position:@"center"];
    }else if ([[DBProduct sharedInstance] selectWithProduct_id:_addProductView.idText.text]){
        self.whichOneButton = 0;
        [self isSupportCamera];
    }else {
        [self.view makeToast:@"此商品ID已存在，请重新输入" duration:2 position:@"center"];
    }
}

- (void)topPhotoButton1Method {
    if ([_addProductView.idText.text isEqualToString:@""]) {
        [self.view makeToast:@"请先输入商品ID" duration:1.5 position:@"center"];
    }else if ([[DBProduct sharedInstance] selectWithProduct_id:_addProductView.idText.text]){
        self.whichOneButton = 1;
        [self isSupportCamera];
    }else {
        [self.view makeToast:@"此商品ID已存在，请重新输入" duration:2 position:@"center"];
    }
}

- (void)topPhotoButton2Method {
    if ([_addProductView.idText.text isEqualToString:@""]) {
        [self.view makeToast:@"请先输入商品ID" duration:1.5 position:@"center"];
    }else if ([[DBProduct sharedInstance] selectWithProduct_id:_addProductView.idText.text]){
        self.whichOneButton = 2;
        [self isSupportCamera];
    }else {
        [self.view makeToast:@"此商品ID已存在，请重新输入" duration:2 position:@"center"];
    }
}

- (void)topPhotoButton3Method {
    if ([_addProductView.idText.text isEqualToString:@""]) {
        [self.view makeToast:@"请先输入商品ID" duration:1.5 position:@"center"];
    }else if ([[DBProduct sharedInstance] selectWithProduct_id:_addProductView.idText.text]){
        self.whichOneButton = 3;
        [self isSupportCamera];
    }else {
        [self.view makeToast:@"此商品ID已存在，请重新输入" duration:2 position:@"center"];
    }
}

- (void)topPhotoButton4Method {
    if ([_addProductView.idText.text isEqualToString:@""]) {
        [self.view makeToast:@"请先输入商品ID" duration:1.5 position:@"center"];
    }else if ([[DBProduct sharedInstance] selectWithProduct_id:_addProductView.idText.text]){
        self.whichOneButton = 4;
        [self isSupportCamera];
    }else {
        [self.view makeToast:@"此商品ID已存在，请重新输入" duration:2 position:@"center"];
    }
}

- (void)detailPhotoButton1Method {
    if ([_addProductView.idText.text isEqualToString:@""]) {
        [self.view makeToast:@"请先输入商品ID" duration:1.5 position:@"center"];
    }else if ([[DBProduct sharedInstance] selectWithProduct_id:_addProductView.idText.text]){
        self.whichOneButton = 5;
        [self isSupportCamera];
    }else {
        [self.view makeToast:@"此商品ID已存在，请重新输入" duration:2 position:@"center"];
    }
}

- (void)detailPhotoButton2Method {
    if ([_addProductView.idText.text isEqualToString:@""]) {
        [self.view makeToast:@"请先输入商品ID" duration:1.5 position:@"center"];
    }else if ([[DBProduct sharedInstance] selectWithProduct_id:_addProductView.idText.text]){
        self.whichOneButton = 6;
        [self isSupportCamera];
    }else {
        [self.view makeToast:@"此商品ID已存在，请重新输入" duration:2 position:@"center"];
    }
}

- (void)detailPhotoButton3Method {
    if ([_addProductView.idText.text isEqualToString:@""]) {
        [self.view makeToast:@"请先输入商品ID" duration:1.5 position:@"center"];
    }else if ([[DBProduct sharedInstance] selectWithProduct_id:_addProductView.idText.text]){
        self.whichOneButton = 7;
        [self isSupportCamera];
    }else {
        [self.view makeToast:@"此商品ID已存在，请重新输入" duration:2 position:@"center"];
    }
}

- (void)detailPhotoButton4Method {
    if ([_addProductView.idText.text isEqualToString:@""]) {
        [self.view makeToast:@"请先输入商品ID" duration:1.5 position:@"center"];
    }else if ([[DBProduct sharedInstance] selectWithProduct_id:_addProductView.idText.text]){
        self.whichOneButton = 8;
        [self isSupportCamera];
    }else {
        [self.view makeToast:@"此商品ID已存在，请重新输入" duration:2 position:@"center"];
    }
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
            [_addProductView.iconPhotoButton setBackgroundImage:image forState:UIControlStateNormal];
            imageName = [NSString stringWithFormat:@"%@%@",_addProductView.idText.text,name0];
            break;
        case 1:
            [_addProductView.topPhotoButton1 setBackgroundImage:image forState:UIControlStateNormal];
            imageName = [NSString stringWithFormat:@"%@%@",_addProductView.idText.text,name1];
            break;
        case 2:
            [_addProductView.topPhotoButton2 setBackgroundImage:image forState:UIControlStateNormal];
            imageName = [NSString stringWithFormat:@"%@%@",_addProductView.idText.text,name2];
            break;
        case 3:
            [_addProductView.topPhotoButton3 setBackgroundImage:image forState:UIControlStateNormal];
            imageName = [NSString stringWithFormat:@"%@%@",_addProductView.idText.text,name3];
            break;
        case 4:
            [_addProductView.topPhotoButton4 setBackgroundImage:image forState:UIControlStateNormal];
            imageName = [NSString stringWithFormat:@"%@%@",_addProductView.idText.text,name4];
            break;
        case 5:
            [_addProductView.detailPhotoButton1 setBackgroundImage:image forState:UIControlStateNormal];
            imageName = [NSString stringWithFormat:@"%@%@",_addProductView.idText.text,name5];
            break;
        case 6:
            [_addProductView.detailPhotoButton2 setBackgroundImage:image forState:UIControlStateNormal];
            imageName = [NSString stringWithFormat:@"%@%@",_addProductView.idText.text,name6];
            break;
        case 7:
            [_addProductView.detailPhotoButton3 setBackgroundImage:image forState:UIControlStateNormal];
            imageName = [NSString stringWithFormat:@"%@%@",_addProductView.idText.text,name7];
            break;
        case 8:
            [_addProductView.detailPhotoButton4 setBackgroundImage:image forState:UIControlStateNormal];
            imageName = [NSString stringWithFormat:@"%@%@",_addProductView.idText.text,name8];
            break;
        default:
            break;
    }
    
    //保存到沙盒中
    [SZKImagePickerVC saveImageToSandbox:image andImageNage:imageName andResultBlock:^(BOOL success) {
        NSLog(@"保存成功");
    }];
}

- (void) addProductButtonMethod {
    BOOL flag = YES;
    if ([_addProductView.idText.text isEqualToString:@""]) {
        flag = NO;
        [self.view makeToast:@"请检查是否输入所有的内容" duration:1.5 position:@"center"];
    }
    if ([_addProductView.nameText.text isEqualToString:@""]) {
        flag = NO;
        [self.view makeToast:@"请检查是否输入所有的内容" duration:1.5 position:@"center"];
    }
    if ([_addProductView.classText.text isEqualToString:@""]) {
        flag = NO;
        [self.view makeToast:@"请检查是否输入所有的内容" duration:1.5 position:@"center"];
    }
    if ([_addProductView.priceText.text isEqualToString:@""]) {
        flag = NO;
        [self.view makeToast:@"请检查是否输入所有的内容" duration:1.5 position:@"center"];
    }
    if ([_addProductView.marketPriceText.text isEqualToString:@""]) {
        flag = NO;
        [self.view makeToast:@"请检查是否输入所有的内容" duration:1.5 position:@"center"];
    }
    if ([_addProductView.descriptionText.text isEqualToString:@""]) {
        flag = NO;
        [self.view makeToast:@"请检查是否输入所有的内容" duration:1.5 position:@"center"];
    }
    if ([_addProductView.brandText.text isEqualToString:@""]) {
        flag = NO;
        [self.view makeToast:@"请检查是否输入所有的内容" duration:1.5 position:@"center"];
    }
    if ([_addProductView.placeText.text isEqualToString:@""]) {
        flag = NO;
        [self.view makeToast:@"请检查是否输入所有的内容" duration:1.5 position:@"center"];
    }
    if ([_addProductView.modelText.text isEqualToString:@""]) {
        flag = NO;
        [self.view makeToast:@"请检查是否输入所有的内容" duration:1.5 position:@"center"];
    }
    if ([_addProductView.ageText.text isEqualToString:@""]) {
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
        NSString *productID = _addProductView.idText.text;
        NSString *name = _addProductView.nameText.text;
        NSString *iconimage = [self filePath:[NSString stringWithFormat:@"%@%@",_addProductView.idText.text,name0]];
        NSString *class = _addProductView.classText.text;
        NSString *price = _addProductView.priceText.text;
        NSString *marketPrice = _addProductView.marketPriceText.text;
        NSString *description = _addProductView.marketPriceText.text;
        NSString *brand = _addProductView.brandText.text;
        NSString *place = _addProductView.placeText.text;
        NSString *model = _addProductView.modelText.text;
        NSString *age = _addProductView.ageText.text;
        NSString *top1 = [self filePath:[NSString stringWithFormat:@"%@%@",_addProductView.idText.text,name1]];
        NSString *top2 = [self filePath:[NSString stringWithFormat:@"%@%@",_addProductView.idText.text,name2]];
        NSString *top3 = [self filePath:[NSString stringWithFormat:@"%@%@",_addProductView.idText.text,name3]];
        NSString *top4 = [self filePath:[NSString stringWithFormat:@"%@%@",_addProductView.idText.text,name4]];
        NSString *detail1 = [self filePath:[NSString stringWithFormat:@"%@%@",_addProductView.idText.text,name5]];
        NSString *detail2 = [self filePath:[NSString stringWithFormat:@"%@%@",_addProductView.idText.text,name6]];
        NSString *detail3 = [self filePath:[NSString stringWithFormat:@"%@%@",_addProductView.idText.text,name7]];
        NSString *detail4 = [self filePath:[NSString stringWithFormat:@"%@%@",_addProductView.idText.text,name8]];
        
        [[DBProduct sharedInstance] insetProduct_Id:productID WithProduct_Name:name WithProduct_IconImage:iconimage WithProduct_CategoryID:class WithProduct_Price:price WithProduct_MarketPrice:marketPrice WithProduct_Description:description];
        [[DBProductDetail sharedInstance] insetProduct_Id:productID WithBrand:brand WithTitle:name WithPrice:price WithMarketPrice:marketPrice WithPlace:place WithModel:model WithCategory:class WithAge:age WithTopImage1:top1 WithTopImage2:top2 WithTopImage3:top3 WithTopImage4:top4 WithDetailImage1:detail1 WithDetailImage2:detail2 WithDetailImage3:detail3 WithDetailImage4:detail4];
        
        [[DBProduct sharedInstance] selectAllMethod];
        [[DBProductDetail sharedInstance] selectAllMethod];
        [self.view makeToast:@"增加成功" duration:1.5 position:@"center"];
        //跳转回“我的”页面,并延时1秒执行
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
    //[self.textName resignFirstResponder];
    //[self.textSummary resignFirstResponder];
    [self.view endEditing:YES];
    [self.addProductView endEditing:YES];
    
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
