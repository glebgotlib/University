//
//  DetailsTableViewCell.h
//  University
//
//  Created by Gotlib on 22.07.16.
//  Copyright © 2016 Yog.group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *subject;
@property (weak, nonatomic) IBOutlet UILabel *lector;
@property (weak, nonatomic) IBOutlet UILabel *where;
@property (weak, nonatomic) IBOutlet UILabel *tupeofsub;
@property (weak, nonatomic) IBOutlet UIImageView *im1;
@property (weak, nonatomic) IBOutlet UIImageView *im2;
@property (weak, nonatomic) IBOutlet UILabel *num;

@end
