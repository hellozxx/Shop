//
//  AddForumViewController.m
//  Shop
//
//  Created by 朱啸 on 2018/5/24.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import "AddForumViewController.h"
#import "AddForumView.h"
#import "SZKImagePickerVC.h"
#import "UIView+Toast.h"    //toast弹框
#import "DBForum.h"

@interface AddForumViewController ()<SZKImagePickerVCDelegate,UIActionSheetDelegate>

@property (strong, nonatomic) AddForumView *addForumView;
@property (assign, nonatomic) int whichOneButton;   //1:image1  2:image2

@end

@implementation AddForumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = MainColor;
    [self.view addSubview:self.addForumView];
}

- (AddForumView *)addForumView {
    if (!_addForumView) {
        _addForumView = [[AddForumView alloc] initWithFrame:CGRectMake(0, 100, VIEW_WIDTH, 500)];
        [[DBForum sharedInstance] LinkDatabaseAndAddToQueue];
        [_addForumView.image1 addTarget:self action:@selector(image1Method) forControlEvents:UIControlEventTouchUpInside];
        [_addForumView.image2 addTarget:self action:@selector(image2Method) forControlEvents:UIControlEventTouchUpInside];
        [_addForumView.addButton addTarget:self action:@selector(addButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addForumView;
}


#pragma mark----跳转到SZKImagePickerVC中
- (void)image1Method {
    if ([_addForumView.titleText.text isEqualToString:@""]) {
        [self.view makeToast:@"请先输入帖子标题" duration:1.5 position:@"center"];
    }else if ([[DBForum sharedInstance] selectWithForum_title:_addForumView.titleText.text]){
        self.whichOneButton = 1;
        [self isSupportCamera];
    }else {
        [self.view makeToast:@"此商品ID已存在，请重新输入" duration:2 position:@"center"];
    }
}

- (void)image2Method {
    if ([_addForumView.titleText.text isEqualToString:@""]) {
        [self.view makeToast:@"请先输入帖子标题" duration:1.5 position:@"center"];
    }else if ([[DBForum sharedInstance] selectWithForum_title:_addForumView.titleText.text]){
        self.whichOneButton = 2;
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
    NSString *name1 = @"forumImage1";
    NSString *name2 = @"forumImage2";
    switch (_whichOneButton) {
        case 1:
            [_addForumView.image1 setImage:image forState:UIControlStateNormal];
            imageName = [NSString stringWithFormat:@"%@%@",_addForumView.titleText.text,name1];
            break;
        case 2:
            [_addForumView.image2 setImage:image forState:UIControlStateNormal];
            imageName = [NSString stringWithFormat:@"%@%@",_addForumView.titleText.text,name2];
            break;
        default:
            break;
    }
    //保存到沙盒中
    [SZKImagePickerVC saveImageToSandbox:image andImageNage:imageName andResultBlock:^(BOOL success) {
        Log(@"保存成功");
    }];
}

- (void) addButtonMethod {
    BOOL flag = YES;
    if ([_addForumView.titleText.text isEqualToString:@""]) {
        flag = NO;
        [self.view makeToast:@"请检查是否输入所有的内容" duration:1.5 position:@"center"];
    }
    if ([_addForumView.textTextView.text isEqualToString:@""]) {
        flag = NO;
        [self.view makeToast:@"请检查是否输入所有的内容" duration:1.5 position:@"center"];
    }
    
    if (flag) {
        NSString *title = _addForumView.titleText.text;
        NSString *text = _addForumView.textTextView.text;
        NSString *name1 = @"forumImage1";
        NSString *name2 = @"forumImage2";
        NSString *image1 = [self filePath:[NSString stringWithFormat:@"%@%@",_addForumView.titleText.text,name1]];
        NSString *image2 = [self filePath:[NSString stringWithFormat:@"%@%@",_addForumView.titleText.text,name2]];
        [[DBForum sharedInstance] insetForum_Title:title WithForum_Text:text WithForum_Image1:image1 WithForum_Image2:image2];
        [[DBForum sharedInstance] selectAllMethod];
        [self.view makeToast:@"新增帖子成功" duration:1.5 position:@"center"];
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

/**
 跳转回“购物车”页面
 */
- (void)popMyViewController{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
