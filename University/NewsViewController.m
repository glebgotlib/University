//
//  NewsViewController.m
//  University
//
//  Created by Gotlib on 15.07.16.
//  Copyright © 2016 Yog.group. All rights reserved.
//

#import "NewsViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#import "MenuCollectionViewCell.h"
#import "MapViewController.h"
#import "T2ViewController.h"
#import "NewsViewController.h"
#import "ScaduleViewController.h"
#import "DetailsViewController.h"
#import "MessageViewController.h"

@interface NewsViewController ()

@property (nonatomic, strong) NSMutableArray *items;
@property (strong ,nonatomic) NSMutableDictionary *cachedFeedImages;
@end

@implementation NewsViewController
{
    NSMutableArray *jsonResultsArray;
    NSURLSessionConfiguration *feedSessionConfigObject;
    NSURLSession *feedSession;
    NSURL *feedUrl;
    NSMutableURLRequest *feedRequest;
    NSURLSessionDataTask *feedTask;
    NSURL *recomendPersonalizedUrl;
    NSDictionary* json;

}
- (void)dealloc
{
    //it's a good idea to set these to nil here to avoid
    //sending messages to a deallocated viewcontroller
    //this is true even if your project is using ARC, unless
    //you are targeting iOS 5 as a minimum deployment target
    _carousel_view.delegate = nil;
    _carousel_view.dataSource = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = false;
}
- (void)goback
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0xfbfbdc);
    self.view.backgroundColor = UIColorFromRGB(0xfbfbdc);
    _viewBG.backgroundColor = UIColorFromRGB(0xfbfbdc);
    _web_view.backgroundColor = UIColorFromRGB(0xfbfbdc);
    [_web_view setBackgroundColor:UIColorFromRGB(0xfbfbdc)];
    self.cachedFeedImages = [[NSMutableDictionary alloc] init];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"ogasaback.png"];
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 15, 20);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn] ;
    self.navigationItem.leftBarButtonItem = backButton;
    
    
    
    [_web_view setOpaque:NO];
    json = [[NSDictionary alloc] init];
    jsonResultsArray = [[NSMutableArray alloc] init];
    [self feedLine];
    _items = [[NSMutableArray alloc] init];
//    self.items = [NSMutableArray array];
//    for (int i = 0; i < 100; i++)
//    {
//        [_items addObject:@(i)];
//    }

    // Do any additional setup after loading the view.
    _carousel_view.scrollSpeed = 1.f;
    _carousel_view.decelerationRate=0.5f;
    _carousel_view.type = iCarouselTypeLinear;
    _carousel_view.bounceDistance = 0.01f;
    _carousel_view.frame = CGRectMake(0, 0, self.view.frame.size.width, 200.f);
    
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
- (IBAction)b1:(UIButton *)sender {
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

- (IBAction)b2:(UIButton *)sender {
    UIStoryboard *storyBoard = [self storyboard];
    NewsViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"NewsViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)b3:(UIButton *)sender {
    UIStoryboard *storyBoard = [self storyboard];
    MapViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"MapViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)b4:(UIButton *)sender {
    UIStoryboard *storyBoard = [self storyboard];
    MessageViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"MessageViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)b5:(UIButton *)sender {
    UIStoryboard *storyBoard = [self storyboard];
    ScaduleViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"ScaduleViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    //free up memory by releasing subviews
    _carousel_view = nil;
}

#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [_items count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
     _pageControl.numberOfPages = [_items count];
    //create new view if no view is available for recycling
//    if (view == nil)
//    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
    NSString *identifier = [NSString stringWithFormat:@"Celltd__%ld", (long)index];
    
    if (([self.cachedFeedImages objectForKey:identifier] == nil)) {
        
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200.f)];
//        [[jsonResultsArray objectAtIndex:1] objectForKey:@"picture"]
//        NSURL *url = [NSURL URLWithString:[[jsonResultsArray objectAtIndex:index] objectForKey:@"picture"]];
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        ((UIImageView *)view).image = [UIImage imageWithData:data];
//        
        [self clubLogoThumb:[[jsonResultsArray objectAtIndex:index] objectForKey:@"picture"] andImageView:((UIImageView *)view) index:index];
        }
    else
    {
        ((UIImageView *)view).image = [self.cachedFeedImages valueForKey:identifier];
    }
    
       //     ((UIImageView *)view).image = [UIImage imageNamed:@"4.png"];
        ((UIImageView *)view).frame = CGRectMake(10, 10, self.view.frame.size.width, 200);
//        [((UIImageView *)view) setContentMode:UIViewContentModeScaleAspectFill];
//        view.contentMode = UIViewContentModeCenter;
        label.numberOfLines = 1;
        label.backgroundColor = [UIColor blackColor];
        label = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, self.view.frame.size.width-60, 20)];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:18];
        label.tag = 1;
        [view addSubview:label];
//    }
//    else
//    {
//
//        NSURL *url = [NSURL URLWithString:[[jsonResultsArray objectAtIndex:index] objectForKey:@"picture"]];
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        
//        ((UIImageView *)view).image = [UIImage imageWithData:data];
//        ((UIImageView *)view).frame = CGRectMake(10, 10, self.view.frame.size.width, 200);
//        //get a reference to the label in the recycled view
//        label.numberOfLines = 1;
//        label = (UILabel *)[view viewWithTag:1];
//    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
//    label.numberOfLines = 1;
    
    if ([[[_items objectAtIndex:index] objectForKey:@"title"] length]<20) {
        label.frame = CGRectMake(30, 10, self.view.frame.size.width-60, 20);
        label.numberOfLines = 1;
    }
    if ([[[_items objectAtIndex:index] objectForKey:@"title"] length]>=30) {
        label.frame = CGRectMake(30, 0, self.view.frame.size.width-60, 50);
        label.numberOfLines = 3;
    }
    if ([[[_items objectAtIndex:index] objectForKey:@"title"] length]>43) {
        label.frame = CGRectMake(30, 0, self.view.frame.size.width-60, 70);
        label.numberOfLines = 4;
    }
    if ([[[_items objectAtIndex:index] objectForKey:@"title"] length]>60) {
        label.frame = CGRectMake(30, 0, self.view.frame.size.width-60, 130);
        label.numberOfLines = 5;
    }
    label.backgroundColor = [UIColor colorWithRed:0.0 green:0.2 blue:0.5 alpha:0.7];
    label.text = [[_items objectAtIndex:index] objectForKey:@"title"];
    
    return view;
}
- (void)carouselDidScroll:(iCarousel *)carousel{
    _pageControl.currentPage = carousel.currentItemIndex;
}
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    return value;
}

- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel{
//    NSLog(@"%ld",(long)_carousel_view.currentItemIndex);
    if (_items.count != 0) {
        [_web_view loadHTMLString:[[_items objectAtIndex:_carousel_view.currentItemIndex] objectForKey:@"fulltext"] baseURL:nil];
    }
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
//    _textField.text = [[_items objectAtIndex:index] objectForKey:@"fulltext"];
    [_web_view loadHTMLString:[[_items objectAtIndex:index] objectForKey:@"fulltext"] baseURL:nil];
}
#pragma mark -
#pragma mark Request
-(void)feedLine
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
   
    [jsonResultsArray removeAllObjects];
    NSDate *dateInUTC = [NSDate date];
    NSTimeInterval timeZoneSeconds = [[NSTimeZone timeZoneWithName:@"UTC"]secondsFromGMT];
    NSDate *dateInLocalTimezone = [dateInUTC dateByAddingTimeInterval:timeZoneSeconds];
    int dateStamp = [dateInLocalTimezone timeIntervalSince1970];
    
    
    feedUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/allnews//json/",[[NSUserDefaults standardUserDefaults] stringForKey:@"mainUrl"]]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:feedUrl];
    NSLog(@"headUrl: %@", feedUrl);
    [request addValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"X-Csrf-Token"] forHTTPHeaderField:@"X-CSRF-Token" ];
    [request setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"Set-Cookie"] forHTTPHeaderField:@"Set-Cookie"];
    
    request.HTTPMethod = @"GET";
    // Create a download task.
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      if (!error) {
                                          
                                          NSLog(@"feedRequest - %@",request);
                                          NSError *JSONError = nil;
                                          [jsonResultsArray removeAllObjects];
                                          json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONError];
                                          jsonResultsArray = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &JSONError];
                                          //NSLog(@"feedLine  - - - %@",json);
                                          if (JSONError) {
                                              UIAlertView* errorAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sorry", nil) message:NSLocalizedString(@"Bad connection", nil)  delegate: self cancelButtonTitle:@"ok" otherButtonTitles:nil];
                                              [errorAlert show];
                                              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                          }
                                          else{
                                              dispatch_async(dispatch_get_main_queue(),^{
                                                  NSLog(@"YES %@",jsonResultsArray);
                                                  
                                                  _items = jsonResultsArray;
                                                  [_web_view loadHTMLString:[[_items objectAtIndex:0] objectForKey:@"fulltext"] baseURL:nil];
                                                  [_carousel_view reloadData];

                                              });
                                              
                                              
                                          }
                                      }
                                      else
                                      {
                                          if (error.code !=-999){
                                              UIAlertView* errorAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sorry", nil) message:NSLocalizedString(@"Bad connection", nil)  delegate: self cancelButtonTitle:@"ok" otherButtonTitles:nil];
                                              [errorAlert show];
                                              //                                 [activityIndicator stopAnimating];
                                              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                          }
                                      }
                                      
                                  }];
    // Start the task.
    [task resume];
}


-(void)clubLogoThumb:(NSString*)avatarLink andImageView:(UIImageView*)imgName index:(long)ind
{
    NSURLRequest* avatarRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:avatarLink] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    NSCachedURLResponse* cachedImageResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:avatarRequest];
//    imgName.backgroundColor = [UIColor lightGrayColor];
    if (cachedImageResponse) {
        imgName.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithData:[NSMutableData dataWithData:[cachedImageResponse data]]]];
    } else {
        
        NSString *identifier = [NSString stringWithFormat:@"Celltd__%ld", ind];
        
        if (([self.cachedFeedImages objectForKey:identifier] != nil)) {
            imgName.hidden = NO;
            imgName.alpha = 1;
            imgName.image = [self.cachedFeedImages valueForKey:identifier];
        } else {

            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

            NSURLSession *imgLoadSession = [NSURLSession sharedSession];
            NSURLSessionDownloadTask *getImageTask = [imgLoadSession downloadTaskWithURL:[NSURL URLWithString:avatarLink] completionHandler:^(NSURL *location,NSURLResponse *response, NSError *error){
                
                UIImage *downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];

                dispatch_async(dispatch_get_main_queue(),^{
                    
                    [self.cachedFeedImages setValue:downloadedImage forKey:identifier];
                    
                    if ([[NSString stringWithFormat:@"Celltd__%ld", ind]isEqualToString:identifier]){
                        imgName.image = [self.cachedFeedImages valueForKey:identifier] ;
                        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    }
                });
            }];
//            [imgName setContentMode:UIViewContentModeScaleAspectFit];
            
            [getImageTask resume];
        }
        
    }
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)left_S:(UIButton *)sender {
//    carouselDidScroll
//    NSLog(@"%ld",(long)_carousel_view.currentItemIndex);
    [_carousel_view scrollToItemAtIndex:_carousel_view.currentItemIndex-1 animated:YES];
    
}

- (IBAction)right_S:(UIButton *)sender {
//     NSLog(@"%ld",(long)_carousel_view.currentItemIndex);
    [_carousel_view scrollToItemAtIndex:_carousel_view.currentItemIndex+1 animated:YES];
}
@end



