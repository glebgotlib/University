//
//  MessageTableViewCell.h
//  University
//
//  Created by Gotlib on 25.07.16.
//  Copyright © 2016 Yog.group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mess_forStud;
@property (weak, nonatomic) IBOutlet UILabel *mess_date;
@property (weak, nonatomic) IBOutlet UIWebView *web_view;

@property (weak, nonatomic) IBOutlet UILabel *mess_text;
@end
