//
//  MessDetailsViewController.h
//  University
//
//  Created by Gotlib on 26.07.16.
//  Copyright © 2016 Yog.group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessDetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *forStud;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIWebView *web_view;
@property (weak, nonatomic) NSString *linkStr;
@property (weak, nonatomic) NSString *forStudents;
@property (weak, nonatomic) NSString *date_of;
@property (weak, nonatomic) NSString *myIdf;
@end
