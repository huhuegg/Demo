//
//  HomePageTableViewCell.m
//  freepai
//
//  Created by jiangchao on 14-6-5.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "HomePageTableViewCell.h"

@implementation HomePageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bg_image = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 310, self.frame.size.height-5)];
        self.bg_image.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        [self addSubview:self.bg_image];
        
        self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 30)];
        [self.mainLabel  setBackgroundColor:[UIColor clearColor]];
        self.mainLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        [self.mainLabel  setFont:[UIFont fontWithName:@"Arial" size:12]];
        self.mainLabel.textAlignment = NSTextAlignmentCenter;
        [self.mainLabel  setTextColor:[UIColor blackColor]];
        [self addSubview:self.mainLabel];
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

-(void)dealloc
{
    self.mainLabel = nil;
    self.bg_image = nil;
}

@end
