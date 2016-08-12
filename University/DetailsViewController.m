//
//  DetailsViewController.m
//  University
//
//  Created by Gotlib on 20.07.16.
//  Copyright © 2016 Yog.group. All rights reserved.
//

#import "DetailsViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#import "DetailsTableViewCell.h"
#import "MenuCollectionViewCell.h"
#import "MapViewController.h"
#import "T2ViewController.h"
#import "NewsViewController.h"
#import "ScaduleViewController.h"
#import "DetailsViewController.h"
#import "MessageViewController.h"
@interface DetailsViewController ()
{
    NSArray* items;
    
    NSMutableArray *jsonResultsArray;
    NSURLSessionConfiguration *feedSessionConfigObject;
    NSURLSession *feedSession;
    NSURL *feedUrl;
    NSMutableURLRequest *feedRequest;
    NSURLSessionDataTask *feedTask;
    NSURL *recomendPersonalizedUrl;
    NSDictionary* json;
    
    NSMutableArray *dayResult;
}
@end

@implementation DetailsViewController
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
    
    
    _mTable.delegate = self;
    _mTable.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ogasa-top.png"]];//UIColorFromRGB(0xfbfbdc);
    self.view.backgroundColor = UIColorFromRGB(0xfbfbdc);
    _mTable.backgroundColor = UIColorFromRGB(0xfbfbdc);
    [self feedLine];
    _lab.backgroundColor = UIColorFromRGB(0xc4c4a0);
    _lab.text = [NSString stringWithFormat:@"Расписание группы %@",[[NSUserDefaults standardUserDefaults] stringForKey:@"preferenceNameGroup"]];
    
    _but1.selected = NO;
    _but2.selected = NO;
    _but3.selected = NO;
    _but4.selected = NO;
    _but5.selected = NO;
    _but6.selected = NO;
    
    
    UIButton*but1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    [but1 addTarget:self action:@selector(but1:) forControlEvents:UIControlEventTouchUpInside];
    [but1 setBackgroundImage:[UIImage imageNamed:@"ogasa-icon44.png"] forState:UIControlStateNormal];
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:but1];
    
    UIButton*butz = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 10, 22)];
    UIBarButtonItem *anotherButtonz = [[UIBarButtonItem alloc] initWithCustomView:butz];
    
    
    UIButton*but2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    [but2 addTarget:self action:@selector(but4:) forControlEvents:UIControlEventTouchUpInside];
    [but2 setBackgroundImage:[UIImage imageNamed:@"ogasa-msg44.png"] forState:UIControlStateNormal];
    UIBarButtonItem *anotherButton1 = [[UIBarButtonItem alloc] initWithCustomView:but2];
    
    UIButton*but3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    [but3 addTarget:self action:@selector(but2:) forControlEvents:UIControlEventTouchUpInside];
    [but3 setBackgroundImage:[UIImage imageNamed:@"ogasa-star44.png"] forState:UIControlStateNormal];
    UIBarButtonItem *anotherButton2 = [[UIBarButtonItem alloc] initWithCustomView:but3];
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:anotherButton,anotherButtonz,anotherButton1,anotherButtonz,anotherButton2, nil]] ;
//    _lab.text = _isUrlLink;
    // Do any additional setup after loading the view.
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



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return [dayResult count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {

    static NSString *CellIdentifier = @"DetailsTableViewCell";
    DetailsTableViewCell *cell = (DetailsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[DetailsTableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = UIColorFromRGB(0xfbfbdc);
    cell.where.text = [[dayResult objectAtIndex:indexPath.row] objectForKey:@"key"];
    cell.subject.text = [[dayResult objectAtIndex:indexPath.row] objectForKey:@"pred"];
    [cell.subject sizeToFit];
   // if ([[[dayResult objectAtIndex:indexPath.row] objectForKey:@"pred"] length] > 15) {
        [cell.subject setFont:[UIFont systemFontOfSize:17]];
//        cell.subject.numberOfLines = 2;
  //  }
  //  else {
 //       [cell.subject setFont:[UIFont systemFontOfSize:17]];
 //       cell.subject.numberOfLines = 1;
 //   }
    
    cell.subject.frame = CGRectMake(cell.subject.frame.origin.x, cell.subject.frame.origin.y, 50, cell.subject.frame.size.height);
    cell.lector.text = [[dayResult objectAtIndex:indexPath.row] objectForKey:@"prep"];
    cell.tupeofsub.text = [[dayResult objectAtIndex:indexPath.row] objectForKey:@"type"];
    cell.num.text = [[dayResult objectAtIndex:indexPath.row] objectForKey:@"num"];
    cell.im1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"point.png"]];
    cell.im2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"point.png"]];
    
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    
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
    
    
    feedUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] stringForKey:@"preferenceName"]]];
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
                                              dispatch_async(dispatch_get_main_queue(),^{
                                              UIAlertView* errorAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sorry", nil) message:NSLocalizedString(@"Bad connection", nil)  delegate: self cancelButtonTitle:@"ok" otherButtonTitles:nil];
                                              [errorAlert show];
                                              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                              });
                                          }
                                          else{
                                              dispatch_async(dispatch_get_main_queue(),^{
//                                                  NSLog(@"YES %@",[jsonResultsArray objectAtIndex:0]);
                                                  
                                                  NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                                                  NSDateComponents *comps = [gregorian components:NSCalendarUnitWeekday fromDate:[NSDate date]];
                                                  int weekday = [comps weekday]-2;
                                                  if (weekday >6 || weekday == -1) {
                                                      weekday = 0;
                                                  }
                                                  NSLog(@"%d",weekday);
                                                  UIButton *button21 = (UIButton *)[self.view viewWithTag:weekday+100];
                                                  button21.selected = YES;
                                                  
//                                                  [(UIButton*)[arr objectAtIndex:weekday]].selected = YES;
                                                  dayResult = [[jsonResultsArray objectAtIndex:weekday] objectForKey:@"data"];
//                                                  _but1.selected = YES;
                                                  [_mTable reloadData];

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

- (IBAction)b1:(UIButton *)sender {
//    [dayResult removeAllObjects];
    _but1.selected = YES;
    _but2.selected = NO;
    _but3.selected = NO;
    _but4.selected = NO;
    _but5.selected = NO;
    _but6.selected = NO;
    dayResult = [[jsonResultsArray objectAtIndex:0] objectForKey:@"data"];
    [_mTable reloadData];
}

- (IBAction)b2:(UIButton *)sender {
    _but2.selected = YES;
    _but1.selected = NO;
    _but3.selected = NO;
    _but4.selected = NO;
    _but5.selected = NO;
    _but6.selected = NO;
    dayResult = [[jsonResultsArray objectAtIndex:1] objectForKey:@"data"];
    [_mTable reloadData];
}

- (IBAction)b3:(UIButton *)sender {
    _but3.selected = YES;
    _but1.selected = NO;
    _but2.selected = NO;
    _but4.selected = NO;
    _but5.selected = NO;
    _but6.selected = NO;
    dayResult = [[jsonResultsArray objectAtIndex:2] objectForKey:@"data"];
    [_mTable reloadData];
}

- (IBAction)b4:(UIButton *)sender {
    _but4.selected = YES;
    _but1.selected = NO;
    _but2.selected = NO;
    _but3.selected = NO;
    _but5.selected = NO;
    _but6.selected = NO;
    dayResult = [[jsonResultsArray objectAtIndex:3] objectForKey:@"data"];
    [_mTable reloadData];
}

- (IBAction)b5:(UIButton *)sender {
    _but5.selected = YES;
    _but1.selected = NO;
    _but2.selected = NO;
    _but3.selected = NO;
    _but4.selected = NO;
    _but6.selected = NO;
    dayResult = [[jsonResultsArray objectAtIndex:4] objectForKey:@"data"];
    [_mTable reloadData];
}
- (IBAction)b6:(UIButton *)sender {
    _but6.selected = YES;
    _but1.selected = NO;
    _but2.selected = NO;
    _but3.selected = NO;
    _but4.selected = NO;
    _but5.selected = NO;
    dayResult = [[jsonResultsArray objectAtIndex:5] objectForKey:@"data"];
    [_mTable reloadData];
}
@end
