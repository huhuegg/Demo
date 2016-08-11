//
//  scrollTableViewCell.m
//  freepai
//
//  Created by huhuegg on 14-6-10.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "scrollTableViewCell.h"

@implementation scrollTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    [_infoLabel setTextColor:RGB(234,85,41)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
