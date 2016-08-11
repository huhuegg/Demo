//
//  MyAddressTableViewCell.m
//  freepai
//
//  Created by jiangchao on 14-6-27.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "MyAddressTableViewCell.h"

@implementation MyAddressTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 90)];
        bgImage.image = [UIImage imageNamed:@"bg_IM"];
        bgImage.layer.masksToBounds = YES;
        bgImage.layer.cornerRadius = 8;
        [self addSubview:bgImage];
        
        self.logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 43, 50)];
        self.logoImage.center = CGPointMake(35, bgImage.frame.size.height/2);
        self.logoImage.image = [UIImage imageNamed:@"AddAddressLogo"];
        [bgImage addSubview:self.logoImage];
        
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 70, 30)];
        [nameLabel  setBackgroundColor:[UIColor clearColor]];
        [nameLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:14]];
        nameLabel.textAlignment = NSTextAlignmentRight;
        [nameLabel  setTextColor:RGB(32, 139, 195)];
        nameLabel.text = @"联系人:";
        [bgImage addSubview:nameLabel];
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(135, 0, 150, 30)];
        [self.name  setBackgroundColor:[UIColor clearColor]];
        [self.name  setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:14]];
        self.name.textAlignment = NSTextAlignmentLeft;
        [self.name  setTextColor:RGB(32, 139, 195)];
        [bgImage addSubview:self.name];
        
        UILabel *telephoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, 70, 30)];
        [telephoneLabel  setBackgroundColor:[UIColor clearColor]];
        [telephoneLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:14]];
        telephoneLabel.textAlignment = NSTextAlignmentRight;
        [telephoneLabel  setTextColor:[UIColor whiteColor]];
        telephoneLabel.text = @"联系电话:";
        [bgImage addSubview:telephoneLabel];
        
        self.telephone = [[UILabel alloc] initWithFrame:CGRectMake(135, 30, 150, 30)];
        [self.telephone  setBackgroundColor:[UIColor clearColor]];
        [self.telephone  setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:14]];
        self.telephone.textAlignment = NSTextAlignmentLeft;
        [self.telephone  setTextColor:[UIColor whiteColor]];
        [bgImage addSubview:self.telephone];
        
        UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 60, 70, 30)];
        [addressLabel  setBackgroundColor:[UIColor clearColor]];
        [addressLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:14]];
        addressLabel.textAlignment = NSTextAlignmentRight;
        [addressLabel  setTextColor:RGB(32, 139, 195)];
        addressLabel.text = @"收货地址:";
        [bgImage addSubview:addressLabel];
        
        self.address = [[UILabel alloc] initWithFrame:CGRectMake(135, 60, 150, 30)];
        [self.address  setBackgroundColor:[UIColor clearColor]];
        [self.address  setFont:[UIFont fontWithName:@"ChalkboardSE-Bold" size:14]];
        self.address.textAlignment = NSTextAlignmentLeft;
        [self.address  setTextColor:[UIColor whiteColor]];
        [bgImage addSubview:self.address];
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

-(void)animationLogoImg
{
    CABasicAnimation *pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    pulse.duration = 0.8;
    pulse.repeatCount = 1;
    pulse.autoreverses = YES;
    pulse.fromValue = nil;
    pulse.toValue = [NSNumber numberWithFloat:0.6];
    [self.logoImage.layer addAnimation:pulse forKey:nil];
}

@end
