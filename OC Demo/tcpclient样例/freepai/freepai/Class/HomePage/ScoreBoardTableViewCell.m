//
//  ScoreBoardTableViewCell.m
//  freepai
//
//  Created by jiangchao on 14-6-5.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "ScoreBoardTableViewCell.h"

@implementation ScoreBoardTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    //labelWidth
    int leftSpace=20;
    int rightSpace=20;
    int mainLabelWidth=80;
    int secondLabelWidth=(SCREEN_WIDTH-mainLabelWidth-leftSpace-rightSpace)/2;
    int thirdLabelWidth = secondLabelWidth;
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bg_image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.bg_image.image = [UIImage imageNamed:@"paiBG"];
        [self addSubview:self.bg_image];
        
        self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace, 0, mainLabelWidth, self.frame.size.height)];
        [self.mainLabel  setBackgroundColor:[UIColor clearColor]];
        [self.mainLabel  setFont:[UIFont fontWithName:@"Arial" size:14]];
        self.mainLabel.textAlignment = NSTextAlignmentLeft;
        [self.mainLabel  setTextColor:[UIColor blackColor]];
        [self addSubview:self.mainLabel];
        
        self.secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace+mainLabelWidth, 0, secondLabelWidth, self.frame.size.height)];
        [self.secondLabel  setBackgroundColor:[UIColor clearColor]];
        [self.secondLabel  setFont:[UIFont fontWithName:@"Arial" size:14]];
        self.secondLabel.textAlignment = NSTextAlignmentCenter;
        [self.secondLabel  setTextColor:[UIColor blackColor]];
        [self addSubview:self.secondLabel];
        
        self.thirdLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftSpace+mainLabelWidth+secondLabelWidth, 0, thirdLabelWidth, self.frame.size.height)];
        [self.thirdLabel  setBackgroundColor:[UIColor clearColor]];
        [self.thirdLabel  setFont:[UIFont fontWithName:@"Arial" size:14]];
        self.thirdLabel.textAlignment = NSTextAlignmentRight;
        [self.thirdLabel  setTextColor:[UIColor blackColor]];
        [self addSubview:self.thirdLabel];
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
    self.bg_image=nil;
    self.mainLabel=nil;
    self.secondLabel=nil;
    self.thirdLabel=nil;
}

@end
