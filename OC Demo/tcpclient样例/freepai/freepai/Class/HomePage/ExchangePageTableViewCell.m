//
//  ExchangePageTableViewCell.m
//  freepai
//
//  Created by jiangchao on 14-6-5.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "ExchangePageTableViewCell.h"

@implementation ExchangePageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bg_image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 50, 50)];
        self.bg_image.image = [BaseTools randomUIImage];
        [self addSubview:self.bg_image];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 0, 200, 30)];
        [self.titleLabel  setBackgroundColor:[UIColor clearColor]];
        [self.titleLabel  setFont:[UIFont fontWithName:@"Arial" size:16]];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.titleLabel  setTextColor:[UIColor blackColor]];
        [self addSubview:self.titleLabel];
        
        
        self.detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 30, 200, 10)];
        [self.detailsLabel  setBackgroundColor:[UIColor clearColor]];
        [self.detailsLabel  setFont:[UIFont fontWithName:@"Arial" size:10]];
        self.detailsLabel.textAlignment = NSTextAlignmentLeft;
        [self.detailsLabel  setTextColor:[UIColor lightGrayColor]];
        [self addSubview:self.detailsLabel];
        
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 40, 60, 20)];
        [self.priceLabel  setBackgroundColor:[UIColor clearColor]];
        [self.priceLabel  setFont:[UIFont fontWithName:@"Arial" size:14]];
        self.priceLabel.textAlignment = NSTextAlignmentLeft;
        [self.priceLabel  setTextColor:[UIColor redColor]];
        [self addSubview:self.priceLabel];
        
        UILabel *jifen =  [[UILabel alloc] initWithFrame:CGRectMake(125, 40, 80, 20)];
        [jifen setBackgroundColor:[UIColor clearColor]];
        [jifen setFont:[UIFont fontWithName:@"Arial" size:12]];
        jifen.textAlignment = NSTextAlignmentLeft;
        [jifen  setTextColor:[UIColor blackColor]];
        jifen.text = @"积分   已兑换";
        [self addSubview:jifen];
        
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(205, 40, 20, 20)];
        [self.countLabel  setBackgroundColor:[UIColor clearColor]];
        [self.countLabel  setFont:[UIFont fontWithName:@"Arial" size:14]];
        self.countLabel.textAlignment = NSTextAlignmentLeft;
        [self.countLabel  setTextColor:[UIColor orangeColor]];
        [self addSubview:self.countLabel];
        
        
        UILabel *jian =  [[UILabel alloc] initWithFrame:CGRectMake(225, 40, 20, 20)];
        [jian setBackgroundColor:[UIColor clearColor]];
        [jian setFont:[UIFont fontWithName:@"Arial" size:12]];
        jian.textAlignment = NSTextAlignmentLeft;
        [jian  setTextColor:[UIColor blackColor]];
        jian.text = @"件";
        [self addSubview:jian];
        
        self.tag_image = [[UIImageView alloc] initWithFrame:CGRectMake(280, 15, 30, 30)];
        self.tag_image.image = [BaseTools randomUIImage];
        [self addSubview:self.tag_image];
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
