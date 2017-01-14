//
//  LoginViewController.h
//  University
//
//  Created by Gotlib on 14.01.17.
//  Copyright © 2017 Yog.group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextViewDelegate>
{
    NSString* phone_str;
    NSString* pass_str;
}
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *pass;
- (IBAction)login_action:(UIButton *)sender;

@end
