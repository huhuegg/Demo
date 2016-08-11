//
//  UninstalledGameTableViewCell.m
//  freepai
//
//  Created by jiangchao on 14-6-16.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "UninstalledGameTableViewCell.h"

@implementation UninstalledGameTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bg_image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        self.bg_image.image = [BaseTools randomUIImage];
        [self addSubview:self.bg_image];
        
        self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 10, 130, 15)];
        [self.mainLabel  setBackgroundColor:[UIColor clearColor]];
        [self.mainLabel  setFont:[UIFont fontWithName:@"Arial" size:12]];
        self.mainLabel.textAlignment = NSTextAlignmentLeft;
        [self.mainLabel  setTextColor:[UIColor blackColor]];
        [self addSubview:self.mainLabel];
        
        
        self.secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 25, 130, 15)];
        [self.secondLabel  setBackgroundColor:[UIColor clearColor]];
        [self.secondLabel  setFont:[UIFont fontWithName:@"Arial" size:12]];
        self.secondLabel.textAlignment = NSTextAlignmentLeft;
        [self.secondLabel  setTextColor:[UIColor blackColor]];
        [self addSubview:self.secondLabel];
        
        UIImageView *goAheadimg = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 30, 15, 20, 20)];
        goAheadimg.image = [UIImage imageNamed:@"homePageRight"];
        [self addSubview:goAheadimg];
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
