//
//  UninstalledGameFriendBoardTableViewCell.m
//  freepai
//
//  Created by jiangchao on 14-6-16.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "UninstalledGameFriendBoardTableViewCell.h"

@implementation UninstalledGameFriendBoardTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        [self.orderLabel  setBackgroundColor:[UIColor clearColor]];
        [self.orderLabel  setFont:[UIFont fontWithName:@"Arial" size:10]];
        self.orderLabel.textAlignment = NSTextAlignmentLeft;
        [self.orderLabel  setTextColor:[UIColor blackColor]];
        [self addSubview:self.orderLabel];
        
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 0, 80, 30)];
        [self.nameLabel  setBackgroundColor:[UIColor clearColor]];
        [self.nameLabel  setFont:[UIFont fontWithName:@"Arial" size:10]];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        [self.nameLabel  setTextColor:[UIColor blackColor]];
        [self addSubview:self.nameLabel];
        
        self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 0, 80, 30)];
        [self.scoreLabel  setBackgroundColor:[UIColor clearColor]];
        [self.scoreLabel  setFont:[UIFont fontWithName:@"Arial" size:10]];
        self.scoreLabel.textAlignment = NSTextAlignmentCenter;
        [self.scoreLabel  setTextColor:[UIColor blackColor]];
        [self addSubview:self.scoreLabel];
        
        self.rightButton = [[UILabel alloc] initWithFrame:CGRectMake(240, 0, 80, 30)];
        [self.rightButton  setBackgroundColor:[UIColor clearColor]];
        [self.rightButton  setFont:[UIFont fontWithName:@"Arial" size:10]];
        self.rightButton.textAlignment = NSTextAlignmentRight;
        [self.rightButton  setTextColor:[UIColor blackColor]];
        [self addSubview:self.rightButton];
        
        
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
