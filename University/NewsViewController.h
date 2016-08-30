//
//  NewsViewController.h
//  University
//
//  Created by Gotlib on 15.07.16.
//  Copyright © 2016 Yog.group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface NewsViewController : UIViewController<iCarouselDataSource, iCarouselDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *view_for_scroll;
@property (weak, nonatomic) IBOutlet UIView *viewBG;

@property (weak, nonatomic) IBOutlet UIWebView *web_view;
@property (weak, nonatomic) IBOutlet UITextView *textField;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet iCarousel *carousel_view;
@property (weak, nonatomic) IBOutlet UIButton *right_scroll;
@property (weak, nonatomic) IBOutlet UIButton *left_scroll;
- (IBAction)left_S:(UIButton *)sender;
- (IBAction)right_S:(UIButton *)sender;
@end
