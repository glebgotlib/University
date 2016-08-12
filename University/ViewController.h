//
//  ViewController.h
//  University
//
//  Created by Gotlib on 14.07.16.
//  Copyright © 2016 Yog.group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collection_view;
@property (weak, nonatomic) IBOutlet UILabel *title_lab;
@property (weak, nonatomic) IBOutlet UIImageView *img_cell;

- (IBAction)test:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logoHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heifhtView;
@property (weak, nonatomic) IBOutlet UIView *logo_view;

@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UILabel *lab4;
@property (weak, nonatomic) IBOutlet UILabel *lab5;

@property (weak, nonatomic) IBOutlet UIImageView *borderVer1;
@property (weak, nonatomic) IBOutlet UIImageView *borderHor1;
@property (weak, nonatomic) IBOutlet UIImageView *borderVer2;
@property (weak, nonatomic) IBOutlet UIImageView *borderHor2;
@property (weak, nonatomic) IBOutlet UIImageView *borderHor3;

@property (weak, nonatomic) IBOutlet UIImageView *ioLogo;

@property (weak, nonatomic) IBOutlet UIButton *b1;
- (IBAction)b1:(UIButton *)sender;
- (IBAction)b2:(UIButton *)sender;
- (IBAction)b3:(UIButton *)sender;
- (IBAction)b4:(UIButton *)sender;
- (IBAction)b5:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *count_lab;

@property (weak, nonatomic) IBOutlet UIImageView *mess_icon;
@end

