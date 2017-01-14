//
//  ScaduleViewController.m
//  University
//
//  Created by Gotlib on 18.07.16.
//  Copyright © 2016 Yog.group. All rights reserved.
//

#import "ScaduleViewController.h"
#import "DetailsViewController.h"
#import "MenuCollectionViewCell.h"
#import "MapViewController.h"
#import "T2ViewController.h"
#import "NewsViewController.h"
#import "ScaduleViewController.h"
#import "DetailsViewController.h"
#import "MessageViewController.h"
#import "LoginViewController.h"
#define kPickerOne 0
#define kPickerTwo 1
#define kPickerTree 2
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ScaduleViewController ()
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
    NSMutableArray* arr_fak;
    NSMutableArray* arr_group;
    NSMutableArray* arr_Id;
    NSMutableArray* arr_urls;
    NSString* selected_fak;
    NSString* selected_kurs;
    NSString* selected_group;
    
    NSString*id_str;
    NSString*name_str;
    NSString*url_str;
    int pickerWasSelected;
    NSString* phone;
    NSString* fio;
    NSString* pass;
}
@end

@implementation ScaduleViewController
- (void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0xfbfbdc);
    self.view.backgroundColor = UIColorFromRGB(0xfbfbdc);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"ogasaback.png"];
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 15, 20);
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn] ;
    self.navigationItem.leftBarButtonItem = backButton;
    
    
    
    [group_picker setHidden:YES];
    [institute_picker setHidden:YES];
    
    institute_picker.delegate = self;
    fak_picker.delegate = self;
    group_picker.delegate = self;
    _scrollV.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height-100);
    
    institute_picker.backgroundColor = [UIColor whiteColor];
    fak_picker.backgroundColor = [UIColor whiteColor];
    group_picker.backgroundColor = [UIColor whiteColor];
    
    pickerWasSelected = 0;
    
    [self feedLine];
    
    FIO.delegate = self;
    PASS.delegate = self;
    PHONE.delegate = self;
    
    items = [[NSArray alloc] init];
    arr_fak = [[NSMutableArray alloc] init];
    arr_group = [[NSMutableArray alloc] init];
    arr_Id = [[NSMutableArray alloc] init];
    selected_fak = [[NSString alloc] init];
    selected_kurs = [[NSString alloc] init];
    selected_group = [[NSString alloc] init];
    arr_urls = [[NSMutableArray alloc] init];
    
    UIButton*butt1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    [butt1 addTarget:self action:@selector(b1:) forControlEvents:UIControlEventTouchUpInside];
    [butt1 setBackgroundImage:[UIImage imageNamed:@"ogasa-icon44.png"] forState:UIControlStateNormal];
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithCustomView:butt1];
    
    UIButton*butz = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 10, 22)];
    UIBarButtonItem *anotherButtonz = [[UIBarButtonItem alloc] initWithCustomView:butz];
    
    
    UIButton*butt2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    [butt2 addTarget:self action:@selector(b4:) forControlEvents:UIControlEventTouchUpInside];
    [butt2 setBackgroundImage:[UIImage imageNamed:@"ogasa-msg44.png"] forState:UIControlStateNormal];
    UIBarButtonItem *anotherButton1 = [[UIBarButtonItem alloc] initWithCustomView:butt2];
    
    UIButton*butt3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
    [butt3 addTarget:self action:@selector(b2:) forControlEvents:UIControlEventTouchUpInside];
    [butt3 setBackgroundImage:[UIImage imageNamed:@"ogasa-star44.png"] forState:UIControlStateNormal];
    UIBarButtonItem *anotherButton2 = [[UIBarButtonItem alloc] initWithCustomView:butt3];
    
    UIButton*login = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 22)];
    [login addTarget:self action:@selector(loginto:) forControlEvents:UIControlEventTouchUpInside];
    [login setTitle:@"Login" forState:UIControlStateNormal];
    [login setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [login setBackgroundImage:[UIImage imageNamed:@"ogasa-sta÷r44.png"] forState:UIControlStateNormal];
    UIBarButtonItem *loginbut = [[UIBarButtonItem alloc] initWithCustomView:login];
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:anotherButton,anotherButtonz,anotherButton1,anotherButtonz,anotherButton2,loginbut, nil]] ;
//    items =[[NSArray alloc] initWithObjects:@"Green",@"Red",@"White",@"Pink", nil];
    // Do any additional setup after loading the view.
    
    
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [FIO resignFirstResponder];
    [PASS resignFirstResponder];
    [PHONE resignFirstResponder];
    return YES;
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
- (IBAction)loginto:(UIButton *)sender {
    UIStoryboard *storyBoard = [self storyboard];
    LoginViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    but1.selected = YES;
    but2.selected = NO;
    but3.selected = NO;
    but4.selected = NO;
    but5.selected = NO;
    but6.selected = NO;
    
    fukultet_lab.text = NSLocalizedString(@"fac", nil);
    kurs_lab.text = NSLocalizedString(@"kurs", nil);
    group_lab.text = NSLocalizedString(@"group", nil);
    [_readyButton setTitle:NSLocalizedString(@"done", nil) forState:UIControlStateNormal];
    self.navigationController.navigationBar.hidden = false;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView  {
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component  {
    if (pickerView == institute_picker) {
        return [jsonResultsArray count];
    }
    else if (pickerView == fak_picker) {
        return [arr_fak count];
    }
    else
        return [arr_group count];
    
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component   {
    if (pickerView == institute_picker) {
        return [[jsonResultsArray objectAtIndex:row] objectForKey:@"fakulty"];
    }
    else if (pickerView == fak_picker) {
        return [arr_fak objectAtIndex:row];
    }
    else
        return [arr_group objectAtIndex:row];
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView == institute_picker) {
        pickerWasSelected = 0;
        [arr_fak removeAllObjects];
        selected_fak = [[jsonResultsArray objectAtIndex:row] objectForKey:@"fakulty"];
        if (![selected_fak isEqualToString:@""]) {
            for (NSDictionary*dict in jsonResultsArray) {
                if ([[dict objectForKey:@"fakulty"] isEqualToString:selected_fak]) {
                    
                    for (NSDictionary* dic in [dict objectForKey:@"courses"]) {
                        [arr_fak addObject:[dic objectForKey:@"coursenum"]];
                    }
                    NSLog(@"yes %@",arr_fak);
                }
                
            }
        }
        [fak_picker reloadAllComponents];
        [self kurs_select:0];
        [_GoIns setTitle:[NSString stringWithFormat:@"%@",selected_fak] forState:UIControlStateNormal];

        [institute_picker setHidden:YES];
        
    }
    if (pickerView == fak_picker) {
        selected_kurs = [arr_fak objectAtIndex:row];
//        title_label.text = [arr_fak objectAtIndex:row];
        
        if (![selected_kurs isEqualToString:@""]) {
            for (NSDictionary*dict in jsonResultsArray) {
                if ([[dict objectForKey:@"fakulty"] isEqualToString:selected_fak]) {
                    if ([[dict objectForKey:@"fakulty"] isEqualToString:selected_fak]) {
                    NSLog(@"yes2");
                    for (NSDictionary* dic in [dict objectForKey:@"courses"]) {
                        if ([[dic objectForKey:@"coursenum"] isEqualToString:selected_kurs]) {
                            [arr_group removeAllObjects];
                            [arr_urls removeAllObjects];
                            [arr_Id removeAllObjects];
                            for (NSDictionary*d in [dic objectForKey:@"groups"]) {
                                if (d!=nil) {
                                    [arr_group addObject:[d objectForKey:@"name"]];
                                    [arr_Id addObject:[d objectForKey:@"id"]];
                                    [arr_urls addObject:[d objectForKey:@"url"]];
                                }
                            }
                            
                        }
                        
                    }
                    }
                }
                    
                
            }
        }
        [group_picker reloadAllComponents];
    }
    if (pickerView == group_picker) {
        pickerWasSelected = 0;
        url_str = [[NSString alloc] init];
        name_str = [[NSString alloc] init];
        name_str = [arr_group objectAtIndex:row];
        url_str = [arr_urls objectAtIndex:row];
        id_str = [arr_Id objectAtIndex:row];
         [_gogogoggo setTitle:[NSString stringWithFormat:@"%@",[arr_group objectAtIndex:row]] forState:UIControlStateNormal];
//        NSLog(@"%@", id_str);
        [group_picker setHidden:YES];
    }
}

#pragma mark -
#pragma mark Request

-(void)registration
{
    //    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURL* myurl = [[NSURL alloc] init];
    NSString*str = [NSString stringWithFormat:@"%@/json/?object=Group&action=register&groupId=%@&fio=%@&phone=%@&password=%@&token=%@&tokentype=0",[[NSUserDefaults standardUserDefaults] stringForKey:@"mainUrl"],id_str,fio,phone,pass,[[NSUserDefaults standardUserDefaults] objectForKey:@"pName"]];
    NSLog(@"str: %@", str);
    NSString* webStringURL = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    myurl = [NSURL URLWithString:webStringURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:myurl];
    NSLog(@"headUrl1111111: %@", myurl);
    [request addValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    //    [request setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"X-Csrf-Token"] forHTTPHeaderField:@"X-CSRF-Token" ];
    //    [request setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"Set-Cookie"] forHTTPHeaderField:@"Set-Cookie"];
    
    request.HTTPMethod = @"GET";
    // Create a download task.
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      if (!error) {
                                          
                                          NSLog(@"feedRequest - %@",response);
                                          NSError *JSONError = nil;
                                          //                                          [jsonResultsArray removeAllObjects];
                                          //                                          json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONError];
                                          //                                          jsonResultsArray = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &JSONError];
                                          NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
                                          dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONError];
                                          NSMutableArray* arr = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &JSONError];
                                          NSLog(@"arr  - - - %@",data);
                                          
                                          NSLog(@"feedLine  - - - %@",dict);
                                          
                                          if (JSONError) {
                                              UIAlertView* errorAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sorry", nil) message:NSLocalizedString(@"Bad connection!!!", nil)  delegate: self cancelButtonTitle:@"ok" otherButtonTitles:nil];
                                              [errorAlert show];
                                              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                          }
                                          else{
                                              dispatch_async(dispatch_get_main_queue(),^{
                                                  UIStoryboard *storyBoard = [self storyboard];
                                                  DetailsViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
//                                                  [self registration];
                                                  if (url_str ==  nil || pickerWasSelected    ==  0) {
                                                      url_str = [[NSString alloc] init];
                                                      name_str = [[NSString alloc] init];
                                                      name_str = [arr_group objectAtIndex:0];
                                                      url_str = [arr_urls objectAtIndex:0];
                                                      id_str = [arr_Id objectAtIndex:0];
                                                  }
                                                  
                                                  controller.isUrlLink = url_str;
                                                  [[NSUserDefaults standardUserDefaults] setObject:url_str forKey:@"preferenceName"];
                                                  [[NSUserDefaults standardUserDefaults] setObject:name_str forKey:@"preferenceNameGroup"];
                                                  [[NSUserDefaults standardUserDefaults] setObject:id_str forKey:@"preferenceIDGroup"];
                                                 [[NSUserDefaults standardUserDefaults] setObject:[dict objectForKey:@"cookie"] forKey:@"cookie"];

                                                      [[NSUserDefaults standardUserDefaults] setObject:[dict objectForKey:@"courseName"] forKey:@"courseName"];
                                                      [[NSUserDefaults standardUserDefaults] setObject:[dict objectForKey:@"cookie"] forKey:@"cookie"];
                                                      [[NSUserDefaults standardUserDefaults] setObject:id_str forKey:@"preferenceIDGroup"];
                                                   [self.navigationController pushViewController:controller animated:YES];
                                              });
                                              
                                              
                                          }
                                      }
                                      else
                                      {
                                          if (error.code !=-999){
                                              UIAlertView* errorAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sorry", nil) message:NSLocalizedString(@"Bad connection", nil)  delegate: self cancelButtonTitle:@"ok" otherButtonTitles:nil];
                                              [errorAlert show];
                                              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                                          }
                                      }
                                      
                                  }];
    // Start the task.
    [task resume];
}

-(void)feedLine
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [jsonResultsArray removeAllObjects];
    NSDate *dateInUTC = [NSDate date];
    NSTimeInterval timeZoneSeconds = [[NSTimeZone timeZoneWithName:@"UTC"]secondsFromGMT];
    NSDate *dateInLocalTimezone = [dateInUTC dateByAddingTimeInterval:timeZoneSeconds];
    int dateStamp = [dateInLocalTimezone timeIntervalSince1970];
    
    
    feedUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/root//groups/",[[NSUserDefaults standardUserDefaults] stringForKey:@"mainUrl"]]];
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
                                                  [arr_fak removeAllObjects];
                                                  selected_fak = [[jsonResultsArray objectAtIndex:0] objectForKey:@"fakulty"];
                                                  //        title_label.text = [[jsonResultsArray objectAtIndex:row] objectForKey:@"fakulty"];
                                                  if (![selected_fak isEqualToString:@""]) {
                                                      for (NSDictionary*dict in jsonResultsArray) {
                                                          //                [arr_fak removeAllObjects];
                                                          if ([[dict objectForKey:@"fakulty"] isEqualToString:selected_fak]) {
                                                              
                                                              for (NSDictionary* dic in [dict objectForKey:@"courses"]) {
                                                                  [arr_fak addObject:[dic objectForKey:@"coursenum"]];
                                                              }
//                                                              NSLog(@"yes %@",arr_fak);
                                                          }
                                                          
                                                      }
                                                          [self kurs_select:0];
                                                      }
                                                  
                                                  [institute_picker reloadAllComponents];
                                                  [_GoIns setTitle:[NSString stringWithFormat:@"%@",selected_fak] forState:UIControlStateNormal];
                                                  
                                                  
                                                  
                                              });
                                              
                                              
                                          }
                                      }
                                      else
                                      {
                                          if (error.code !=-999){
                                              UIAlertView* errorAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sorry", nil) message:NSLocalizedString(@"Bad connection", nil)  delegate: self cancelButtonTitle:@"ok" otherButtonTitles:nil];
                                              [errorAlert show];
                                              [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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

- (IBAction)goButton:(UIButton *)sender {
//    UIStoryboard *storyBoard = [self storyboard];
//    DetailsViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    phone = PHONE.text;
    pass = PASS.text;
    fio = FIO.text;
    if (url_str ==  nil || pickerWasSelected    ==  0 || id_str == nil) {
        url_str = [[NSString alloc] init];
        name_str = [[NSString alloc] init];
        name_str = [arr_group objectAtIndex:0];
        url_str = [arr_urls objectAtIndex:0];
        id_str = [arr_Id objectAtIndex:0];
    }

    [self registration];
//
//    controller.isUrlLink = url_str;
//    [[NSUserDefaults standardUserDefaults] setObject:url_str forKey:@"preferenceName"];
//    [[NSUserDefaults standardUserDefaults] setObject:name_str forKey:@"preferenceNameGroup"];
//    [[NSUserDefaults standardUserDefaults] setObject:id_str forKey:@"preferenceIDGroup"];
//    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)k1:(UIButton *)sender {
    but1.selected = YES;
    but2.selected = NO;
    but3.selected = NO;
    but4.selected = NO;
    but5.selected = NO;
    but6.selected = NO;
    [self kurs_select:0];
}

- (IBAction)k2:(UIButton *)sender {
    but1.selected = NO;
    but2.selected = YES;
    but3.selected = NO;
    but4.selected = NO;
    but5.selected = NO;
    but6.selected = NO;
    [self kurs_select:1];
}

- (IBAction)k3:(UIButton *)sender {
    but1.selected = NO;
    but2.selected = NO;
    but3.selected = YES;
    but4.selected = NO;
    but5.selected = NO;
    but6.selected = NO;
    [self kurs_select:2];
}

- (IBAction)k4:(UIButton *)sender {
    but1.selected = NO;
    but2.selected = NO;
    but3.selected = NO;
    but4.selected = YES;
    but5.selected = NO;
    but6.selected = NO;
    [self kurs_select:3];
}

- (IBAction)k5:(UIButton *)sender {
    
    but1.selected = NO;
    but2.selected = NO;
    but3.selected = NO;
    but4.selected = NO;
    but5.selected = YES;
    but6.selected = NO;
    [self kurs_select:4];
}

- (IBAction)k6:(UIButton *)sender {
    but1.selected = NO;
    but2.selected = NO;
    but3.selected = NO;
    but4.selected = NO;
    but5.selected = NO;
    but6.selected = YES;
//    [self kurs_select:5];
}

- (IBAction)GOGOGO:(id)sender {
    if (institute_picker.hidden==NO) {
        [institute_picker setHidden:YES];
    }
    [group_picker setHidden:NO];
}

-(void)kurs_select:(int)kuts
{
    if (arr_fak.count>=kuts) {
        selected_kurs = [arr_fak objectAtIndex:kuts];
    }
    
    if (![selected_kurs isEqualToString:@""]) {
        for (NSDictionary*dict in jsonResultsArray) {
            if ([[dict objectForKey:@"fakulty"] isEqualToString:selected_fak]) {
                if ([[dict objectForKey:@"fakulty"] isEqualToString:selected_fak]) {
                    NSLog(@"yes2");
                    for (NSDictionary* dic in [dict objectForKey:@"courses"]) {
                        if ([[dic objectForKey:@"coursenum"] isEqualToString:selected_kurs]) {
                            if ([[dic objectForKey:@"groups"] count] != 0) {
                            [arr_group removeAllObjects];
                            [arr_urls removeAllObjects];
                            [arr_Id removeAllObjects];
                                for (NSDictionary*d in [dic objectForKey:@"groups"]) {
                                if (d!=nil) {
                                        [arr_group addObject:[d objectForKey:@"name"]];
                                        [arr_Id addObject:[d objectForKey:@"id"]];
                                        [arr_urls addObject:[d objectForKey:@"url"]];
                                    }
                                }
                            }
                            
                        }
                        
                    }
                }
            }
            
            
        }
    }
    [_gogogoggo setTitle:[NSString stringWithFormat:@"%@",[arr_group objectAtIndex:0]] forState:UIControlStateNormal];
    if (arr_group.count!=0) {
        [group_picker reloadAllComponents];
    }
}
- (IBAction)GoIns:(id)sender {
    if (group_picker.hidden==NO) {
        [group_picker setHidden:YES];
    }
    [institute_picker setHidden:NO];
}
@end
