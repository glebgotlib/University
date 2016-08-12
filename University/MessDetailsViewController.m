//
//  MessDetailsViewController.m
//  University
//
//  Created by Gotlib on 26.07.16.
//  Copyright © 2016 Yog.group. All rights reserved.
//

#import "MessDetailsViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#import "MenuCollectionViewCell.h"
#import "MapViewController.h"
#import "T2ViewController.h"
#import "NewsViewController.h"
#import "ScaduleViewController.h"
#import "DetailsViewController.h"
#import "MessageViewController.h"
@interface MessDetailsViewController ()

@end

@implementation MessDetailsViewController
- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"ogasaback.png"];
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 15, 20);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn] ;
    self.navigationItem.leftBarButtonItem = backButton;
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:@"dd MMMM yyyy"];
//    NSString*str = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
    _forStud.text = _forStudents;
    _time.text = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[_date_of intValue]]];
    self.view.backgroundColor = UIColorFromRGB(0xfbfbdc);
    [_web_view setBackgroundColor: UIColorFromRGB(0xfbfbdc)];
    _web_view.backgroundColor = UIColorFromRGB(0xfbfbdc);
    [_web_view setBackgroundColor:UIColorFromRGB(0xfbfbdc)];
    [_web_view setOpaque:NO];
    [_web_view loadHTMLString:_linkStr baseURL:nil];
        self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.

    
    
    
    UIButton*but1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    [but1 addTarget:self action:@selector(b1:) forControlEvents:UIControlEventTouchUpInside];
    [but1 setBackgroundImage:[UIImage imageNamed:@"ogasa-icon44.png"] forState:UIControlStateNormal];
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:but1];
    
    UIButton*butz = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 10, 22)];
    UIBarButtonItem *anotherButtonz = [[UIBarButtonItem alloc] initWithCustomView:butz];
    
    
    UIButton*but2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    [but2 addTarget:self action:@selector(b4:) forControlEvents:UIControlEventTouchUpInside];
    [but2 setBackgroundImage:[UIImage imageNamed:@"ogasa-msg44.png"] forState:UIControlStateNormal];
    UIBarButtonItem *anotherButton1 = [[UIBarButtonItem alloc] initWithCustomView:but2];
    
    UIButton*but3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    [but3 addTarget:self action:@selector(b2:) forControlEvents:UIControlEventTouchUpInside];
    [but3 setBackgroundImage:[UIImage imageNamed:@"ogasa-star44.png"] forState:UIControlStateNormal];
    UIBarButtonItem *anotherButton2 = [[UIBarButtonItem alloc] initWithCustomView:but3];
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:anotherButton,anotherButtonz,anotherButton1,anotherButtonz,anotherButton2, nil]] ;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = false;
}
- (IBAction)but1:(UIButton *)sender {
    UIStoryboard *storyBoard = [self storyboard];
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"preferenceName"]!=nil) {
        DetailsViewController*controller = [storyBoard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else
    {
        ScaduleViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"ScaduleViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}

- (IBAction)but2:(UIButton *)sender {
    UIStoryboard *storyBoard = [self storyboard];
    NewsViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"NewsViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)but4:(UIButton *)sender {
    UIStoryboard *storyBoard = [self storyboard];
    MessageViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"MessageViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
