//
//  MapViewController.m
//  University
//
//  Created by Gotlib on 14.07.16.
//  Copyright © 2016 Yog.group. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController
- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"Back"
//                                                             style:UIBarButtonItemStylePlain
//                                                            target:nil
//                                                            action:nil];
//    [[self navigationItem] setBackBarButtonItem:back];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"ogasaback.png"];
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 15, 20);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn] ;
    self.navigationItem.leftBarButtonItem = backButton;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationItem setHidesBackButton:NO];
    self.scrollView.minimumZoomScale=0.52;
    self.scrollView.maximumZoomScale=6.0;
    self.scrollView.zoomScale = 0.52f;
    self.scrollView.contentSize=CGSizeMake(1280, 960);
    self.scrollView.delegate=self;

    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = false;
}

-(UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.img;
}
//- (void)scrollViewDidZoom:(UIScrollView *)scrollView
//{
//    UIView *subView = [scrollView.subviews objectAtIndex:0];
//    
//    CGFloat offsetX = MAX((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0.0);
//    CGFloat offsetY = MAX((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0.0);
//    
//    subView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
//                                 scrollView.contentSize.height * 0.5 + offsetY);
//}
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
