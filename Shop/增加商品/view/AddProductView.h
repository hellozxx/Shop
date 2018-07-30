//
//  AddProductView.h
//  Shop
//
//  Created by 朱啸 on 2018/5/12.
//  Copyright © 2018年 朱啸. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddProductView : UIView

@property (strong, nonatomic) UITextField *idText;
@property (strong, nonatomic) UITextField *nameText;
@property (strong, nonatomic) UITextField *classText;
@property (strong, nonatomic) UITextField *priceText;
@property (strong, nonatomic) UITextField *marketPriceText;
@property (strong, nonatomic) UITextView *descriptionText;
@property (strong, nonatomic) UITextField *brandText;
@property (strong, nonatomic) UITextField *placeText;
@property (strong, nonatomic) UITextField *modelText;
@property (strong, nonatomic) UITextField *ageText;

@property (strong, nonatomic) UIButton *iconPhotoButton;

@property (strong, nonatomic) UIButton *topPhotoButton1;
@property (strong, nonatomic) UIButton *topPhotoButton2;
@property (strong, nonatomic) UIButton *topPhotoButton3;
@property (strong, nonatomic) UIButton *topPhotoButton4;

@property (strong, nonatomic) UIButton *detailPhotoButton1;
@property (strong, nonatomic) UIButton *detailPhotoButton2;
@property (strong, nonatomic) UIButton *detailPhotoButton3;
@property (strong, nonatomic) UIButton *detailPhotoButton4;

@property (strong, nonatomic) UIButton *addProductButton;

@end
