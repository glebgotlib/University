//
//  ViewController.m
//  University
//
//  Created by Gotlib on 14.07.16.
//  Copyright © 2016 Yog.group. All rights reserved.
//

#import "ViewController.h"
#import "MenuCollectionViewCell.h"
#import "MapViewController.h"
#import "T2ViewController.h"  
#import "NewsViewController.h"
#import "ScaduleViewController.h"
#import "DetailsViewController.h"
#import "MessageViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController ()

@end

@implementation ViewController
{
    NSMutableArray *jsonResultsArray;
    NSURLSessionConfiguration *feedSessionConfigObject;
    NSURLSession *feedSession;
    NSURL *feedUrl;
    NSMutableURLRequest *feedRequest;
    NSURLSessionDataTask *feedTask;
    NSURL *recomendPersonalizedUrl;
    NSDictionary* json;
    int savedCount;
    
}
-(BOOL)shouldAutorotate
{
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    
    // Use this to allow upside down as well
    //return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation {
    // Return the orientation you'd prefer - this is what it launches to. The
    // user can still rotate. You don't have to implement this method, in which
    // case it launches in the current orientation
    return UIInterfaceOrientationPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _count_lab.hidden = YES;
//    [self feedLine];
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0xfbfbdc);
    self.view.backgroundColor = UIColorFromRGB(0xfbfbdc);
    [_ioLogo setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"grad.png"]]];
    _collection_view.backgroundColor = [UIColor whiteColor];
    _collection_view.delegate = self;
    _collection_view.dataSource= self;
    _collection_view.backgroundColor = UIColorFromRGB(0xfbfbdc);
    if (self.view.frame.size.width==320) {
        _logoHeight.constant = 200.f;
    }
    UIButton*but1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    [but1 addTarget:self action:@selector(b1:) forControlEvents:UIControlEventTouchUpInside];
    [but1 setBackgroundImage:[UIImage imageNamed:@"ogasa-icon44.png"] forState:UIControlStateNormal];
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:but1];
    
    UIButton*but2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    [but2 addTarget:self action:@selector(b4:) forControlEvents:UIControlEventTouchUpInside];
    [but2 setBackgroundImage:[UIImage imageNamed:@"ogasa-msg44.png"] forState:UIControlStateNormal];
    UIBarButtonItem *anotherButton1 = [[UIBarButtonItem alloc] initWithCustomView:but2];
    
    UIButton*but3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    [but3 addTarget:self action:@selector(b2:) forControlEvents:UIControlEventTouchUpInside];
    [but3 setBackgroundImage:[UIImage imageNamed:@"ogasa-star44.png"] forState:UIControlStateNormal];
    UIBarButtonItem *anotherButton2 = [[UIBarButtonItem alloc] initWithCustomView:but3];
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:anotherButton,anotherButton1,anotherButton2, nil]] ;
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldRotate"
                                                        object:@"NO"];
    self.navigationController.navigationBar.hidden = true;

     _lab1.text = NSLocalizedString(@"scadule", nil);
     _lab2.text = NSLocalizedString(@"news", nil);
     _lab3.text = NSLocalizedString(@"map", nil);
     _lab4.text = NSLocalizedString(@"mess", nil);
     _lab5.text = NSLocalizedString(@"settings", nil);
    
    _borderHor1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"point.png"]];
    _borderHor2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"point.png"]];
    _borderHor3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"point.png"]];
    
    _borderVer1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"point2.png"]];
    _borderVer2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"point2.png"]];
    
    savedCount = 0;
    for (int i  =  0; i   <   100; i++)
    {
        NSString*key = [NSString stringWithFormat:@"key_%d",i];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        
        NSObject * object = [prefs objectForKey:key];
        if(object != nil){
            savedCount++;
        }

    }
    [self feedLine];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"menuCell";
    
    MenuCollectionViewCell *menuCell = (MenuCollectionViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (indexPath.item == 0) {
        menuCell.menu_title_label.text = @"Расписание";
        menuCell.menu_img.image = [UIImage imageNamed:@"ico1.png"];
    }
    if (indexPath.item == 1) {
        menuCell.menu_title_label.text = @"Новости";
        menuCell.menu_img.image = [UIImage imageNamed:@"ico2.png"];
    }
    if (indexPath.item == 2) {
        menuCell.menu_title_label.text = @"Карта академии";
        menuCell.menu_img.image = [UIImage imageNamed:@"ico3.png"];
    }
    if (indexPath.item == 3) {
        menuCell.menu_title_label.text = @"Сообщение";
        menuCell.menu_img.image = [UIImage imageNamed:@"ico4.png"];
    }
    if (indexPath.item == 4) {
        menuCell.menu_title_label.text = @"Настройки";
        if (self.view.frame.size.width > 320) {
            menuCell.menu_img.frame = CGRectMake(63, 18, 80, 130);
        }
        menuCell.menu_img.image = [UIImage imageNamed:@"ico5.png"];
    }

    
    menuCell.backgroundColor = [UIColor clearColor];
    return menuCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyBoard = [self storyboard];
    if (indexPath.item == 0) {
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
    if (indexPath.item == 1) {
        NewsViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"NewsViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.item == 2) {
        MapViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"MapViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (indexPath.item == 3) {
        MessageViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"MessageViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    }

    if(indexPath.item == 4){
        ScaduleViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"ScaduleViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    

}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Adjust cell size for orientation
    if(indexPath.item==4)
    {
            if (self.view.frame.size.width==320) {
                return CGSizeMake(self.collection_view.frame.size.width, 100.f);
            }
            else
                return CGSizeMake(self.collection_view.frame.size.width, 130.f);
    }
    else{
        if (self.view.frame.size.width==320) {
            return CGSizeMake(self.collection_view.frame.size.width/2-5, 100.f);
        }
        else
            return CGSizeMake(self.collection_view.frame.size.width/2-5, 130.f);
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)test:(UIButton *)sender {
    [self performSegueWithIdentifier:@"goToTest" sender:self];
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

-(void)feedLine
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [jsonResultsArray removeAllObjects];
    NSDate *dateInUTC = [NSDate date];
    NSTimeInterval timeZoneSeconds = [[NSTimeZone timeZoneWithName:@"UTC"]secondsFromGMT];
    NSDate *dateInLocalTimezone = [dateInUTC dateByAddingTimeInterval:timeZoneSeconds];
    int dateStamp = [dateInLocalTimezone timeIntervalSince1970];
    
    
    feedUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/messages//app/?idgroup=1&action=count",[[NSUserDefaults standardUserDefaults] stringForKey:@"mainUrl"]]];
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
                                          NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                          NSLog(@"%@",newStr);
//                                          json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONError];
//                                          jsonResultsArray = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &JSONError];
                                          //NSLog(@"feedLine  - - - %@",json);
                                          if (JSONError) {
                                              dispatch_async(dispatch_get_main_queue(),^{
                                              UIAlertView* errorAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sorry", nil) message:NSLocalizedString(@"Bad connection", nil)  delegate: self cancelButtonTitle:@"ok" otherButtonTitles:nil];
                                              [errorAlert show];
                                              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                              });
                                          }
                                          else{
                                              dispatch_async(dispatch_get_main_queue(),^{
//                                                  NSLog(@"YES %@",);
//                                                  if ([[NSUserDefaults standardUserDefaults] stringForKey:@"countMess"]==nil || [[[NSUserDefaults standardUserDefaults] stringForKey:@"countMess"] intValue] > [newStr intValue]) {
//                                                      [[NSUserDefaults standardUserDefaults] setObject:newStr forKey:@"countMess"];
                                                      int n = newStr.intValue - savedCount;
                                                  if (n!=0) {
                                                      NSString*str = [NSString stringWithFormat:@"%d",n];
                                                      _mess_icon.image = [UIImage imageNamed:@"ico4n.png"];
                                                      _count_lab.text = str;
                                                      _count_lab.hidden = NO;
                                                      NSLog(@"++++++++++   %@",str);
                                                  }
//                                                  }
                                                 
                                                  
                                              });
                                              
                                              
                                          }
                                      }
                                      else
                                      {
                                          if (error.code !=-999){
                                              dispatch_async(dispatch_get_main_queue(),^{
                                              UIAlertView* errorAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sorry", nil) message:NSLocalizedString(@"Bad connection", nil)  delegate: self cancelButtonTitle:@"ok" otherButtonTitles:nil];
                                              [errorAlert show];
                                              //                                 [activityIndicator stopAnimating];
                                              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                              });
                                          }
                                      }
                                      
                                  }];
    // Start the task.
    [task resume];
}
@end
