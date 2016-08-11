//
//  CustomerServiceTableViewCell.m
//  freepai
//
//  Created by jiangchao on 14-6-10.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "CustomerServiceTableViewCell.h"

@implementation CustomerServiceTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bg_image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
        self.bg_image.image = [BaseTools randomUIImage];
        [self addSubview:self.bg_image];
        
        self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 5, 130, 30)];
        [self.mainLabel  setBackgroundColor:[UIColor clearColor]];
        [self.mainLabel  setFont:[UIFont fontWithName:@"Arial" size:16]];
        self.mainLabel.textAlignment = NSTextAlignmentLeft;
        [self.mainLabel  setTextColor:[UIColor blackColor]];
        [self addSubview:self.mainLabel];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
