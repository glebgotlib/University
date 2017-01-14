//
//  LoginViewController.m
//  University
//
//  Created by Gotlib on 14.01.17.
//  Copyright © 2017 Yog.group. All rights reserved.
//

#import "LoginViewController.h"
#import "DetailsViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0xfbfbdc);
    self.view.backgroundColor = UIColorFromRGB(0xfbfbdc);
    self.automaticallyAdjustsScrollViewInsets = NO;
    _pass.delegate = self;
    _phone.delegate = self;
    // Do any additional setup after loading the view.
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [_pass resignFirstResponder];
    [_phone resignFirstResponder];
    return YES;
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


- (IBAction)login_action:(UIButton *)sender {
    phone_str = _phone.text;
    pass_str = _pass.text;
    [self registration];
}

-(void)registration
{
    //    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSURL* myurl = [[NSURL alloc] init];
    NSString*str = [NSString stringWithFormat:@"%@/json/?object=Group&action=login&login=%@&password=%@&token=%@&tokentype=0",[[NSUserDefaults standardUserDefaults] stringForKey:@"mainUrl"],phone_str,pass_str,[[NSUserDefaults standardUserDefaults] objectForKey:@"pName"]];
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
                                                  NSString* url_str = [NSString stringWithFormat:@"%@/group/%@/curweek/",[[NSUserDefaults standardUserDefaults] stringForKey:@"mainUrl"],[[dict objectForKey:@"group"] objectForKey:@"url"]];
                                                  [[NSUserDefaults standardUserDefaults] setObject:url_str forKey:@"preferenceName"];
                                                  [[NSUserDefaults standardUserDefaults] setObject:[dict objectForKey:@"cookie"] forKey:@"cookie"]; 
                                                  UIStoryboard *storyBoard = [self storyboard];
                                                  DetailsViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"DetailsViewController"];

                                                  
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

@end
