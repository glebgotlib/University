//
//  MessageViewController.m
//  University
//
//  Created by Gotlib on 25.07.16.
//  Copyright © 2016 Yog.group. All rights reserved.
//

#import "MessageViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#import "MessageTableViewCell.h"
#import "MessDetailsViewController.h"
#import "MenuCollectionViewCell.h"
#import "MapViewController.h"
#import "T2ViewController.h"
#import "NewsViewController.h"
#import "ScaduleViewController.h"=)
#import "DetailsViewController.h"
#import "MessageViewController.h"
@interface MessageViewController ()
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
@end

@implementation MessageViewController
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
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0xfbfbdc);
    self.view.backgroundColor = UIColorFromRGB(0xfbfbdc);
    _mTable.backgroundColor = UIColorFromRGB(0xfbfbdc);
    [self feedLine];
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

- (IBAction)b4:(UIButton *)sender {
    UIStoryboard *storyBoard = [self storyboard];
    MessageViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"MessageViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [jsonResultsArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"MessageTableViewCell";
    MessageTableViewCell *cell = (MessageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MessageTableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.backgroundColor = UIColorFromRGB(0xfbfbdc);

    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:@"dd MMMM yyyy"];
    
    cell.mess_text.numberOfLines = 2;
    cell.mess_text.text = [[jsonResultsArray objectAtIndex:indexPath.row] objectForKey:@"caption"];
    cell.mess_forStud.text = [[jsonResultsArray objectAtIndex:indexPath.row] objectForKey:@"level"];
    cell.mess_date.text = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[[[jsonResultsArray objectAtIndex:indexPath.row] objectForKey:@"date"] intValue]]];

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *storyBoard = [self storyboard];
    MessDetailsViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"MessDetailsViewController"];
    controller.linkStr = [[jsonResultsArray objectAtIndex:indexPath.row] objectForKey:@"text"];
   controller.forStudents = [[jsonResultsArray objectAtIndex:indexPath.row] objectForKey:@"level"];
    controller.date_of = [[jsonResultsArray objectAtIndex:indexPath.row] objectForKey:@"date"];
    [self.navigationController pushViewController:controller animated:YES];

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
    
    
    feedUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://y.od.ua/messages//app/?idgroup=%@&action=messages",[[NSUserDefaults standardUserDefaults] stringForKey:@"preferenceIDGroup"]]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:feedUrl];
    NSLog(@"headUrl: %@", feedUrl);
    [request addValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"X-Csrf-Token"] forHTTPHeaderField:@"X-CSRF-Token"];
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
//                                                  NSLog(@"YES %@",[jsonResultsArray objectAtIndex:1]);
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

@end
