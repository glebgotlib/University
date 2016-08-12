//
//  MessageTableViewCell.m
//  University
//
//  Created by Gotlib on 25.07.16.
//  Copyright © 2016 Yog.group. All rights reserved.
//

#import "MessageTableViewCell.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation MessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _web_view.backgroundColor = UIColorFromRGB(0xfbfbdc);
    [_mess_text setNumberOfLines:2];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
