//
//  ScaduleViewController.h
//  University
//
//  Created by Gotlib on 18.07.16.
//  Copyright © 2016 Yog.group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScaduleViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource,UITextViewDelegate>
{
    __weak IBOutlet UILabel *title_label;

    __weak IBOutlet UIPickerView *institute_picker;
    
    __weak IBOutlet UIPickerView *group_picker;
    __weak IBOutlet UIPickerView *fak_picker;
    
    __weak IBOutlet UIButton *but1;
    __weak IBOutlet UIButton *but2;
    __weak IBOutlet UIButton *but3;
    __weak IBOutlet UIButton *but4;
    __weak IBOutlet UIButton *but5;
    __weak IBOutlet UIButton *but6;
    
    __weak IBOutlet UITextField *FIO;
    __weak IBOutlet UITextField *PASS;
    __weak IBOutlet UITextField *PHONE;
    
    __weak IBOutlet UILabel *fukultet_lab;
    __weak IBOutlet UILabel *kurs_lab;
    __weak IBOutlet UILabel *group_lab;
    
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollV;
@property (weak, nonatomic) IBOutlet UIButton *readyButton;
- (IBAction)goButton:(UIButton *)sender;

- (IBAction)k1:(UIButton *)sender;
- (IBAction)k2:(UIButton *)sender;
- (IBAction)k3:(UIButton *)sender;
- (IBAction)k4:(UIButton *)sender;
- (IBAction)k5:(UIButton *)sender;
- (IBAction)k6:(UIButton *)sender;

- (IBAction)GOGOGO:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *gogogoggo;
@property (weak, nonatomic) IBOutlet UIButton *GoIns;
- (IBAction)GoIns:(id)sender;
@end
