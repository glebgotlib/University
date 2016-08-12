//
//  DetailsViewController.h
//  University
//
//  Created by Gotlib on 20.07.16.
//  Copyright © 2016 Yog.group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic) NSString *isUrlLink;
@property (weak, nonatomic) IBOutlet UILabel *lab;
@property (weak, nonatomic) IBOutlet UITableView *mTable;
- (IBAction)b1:(UIButton *)sender;
- (IBAction)b2:(UIButton *)sender;
- (IBAction)b3:(UIButton *)sender;
- (IBAction)b4:(UIButton *)sender;
- (IBAction)b5:(UIButton *)sender;
- (IBAction)b6:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *but1;
@property (weak, nonatomic) IBOutlet UIButton *but2;
@property (weak, nonatomic) IBOutlet UIButton *but3;
@property (weak, nonatomic) IBOutlet UIButton *but4;
@property (weak, nonatomic) IBOutlet UIButton *but5;
@property (weak, nonatomic) IBOutlet UIButton *but6;
@end
