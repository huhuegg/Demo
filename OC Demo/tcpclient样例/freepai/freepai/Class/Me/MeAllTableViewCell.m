//
//  MeAllTableViewCell.m
//  freepai
//
//  Created by jiangchao on 14-6-24.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "MeAllTableViewCell.h"
#import "AMBlurView.h"

@implementation MeAllTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if ([reuseIdentifier isEqualToString:@"MeInfoCell"]) {
            UIImageView *bg_image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
            bg_image.image = [UIImage imageNamed:@"headBG.jpg"];
            [self addSubview:bg_image];
            
            AMBlurView *ambView = [[AMBlurView alloc] initWithFrame:CGRectMake(0, 0, 320, 205)];
            [bg_image addSubview:ambView];
            
            self.headImage = [[PAImageView alloc]initWithFrame:CGRectMake(0,0, 100, 100) backgroundProgressColor:[UIColor whiteColor] progressColor:[UIColor lightGrayColor]];
            self.headImage.center = CGPointMake(320/2, 200/2-20);
            [self addSubview:self.headImage];
            
            self.topLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 10, 130, 20)];
            [self.topLabel  setBackgroundColor:[UIColor clearColor]];
            self.topLabel.center = CGPointMake(320/2, 200/2+50);
            [self.topLabel  setFont:[UIFont fontWithName:@"Arial" size:16]];
            self.topLabel.textAlignment = NSTextAlignmentCenter;
            [self.topLabel  setTextColor:[UIColor whiteColor]];
            self.topLabel.text = @"Yukey";
            [self addSubview:self.topLabel];
            
            self.bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 10, 130, 20)];
            [self.bottomLabel  setBackgroundColor:[UIColor clearColor]];
            self.bottomLabel.center = CGPointMake(320/2, 200/2+70);
            [self.bottomLabel  setFont:[UIFont fontWithName:@"Arial" size:10]];
            self.bottomLabel.textAlignment = NSTextAlignmentCenter;
            [self.bottomLabel  setTextColor:[UIColor whiteColor]];
            self.bottomLabel.text = @"自由号:zxc413";
            [self addSubview:self.bottomLabel];
        }else if ([reuseIdentifier isEqualToString:@"MeAppCell"]){
            self.meScrollView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,320, 150)];
            self.meScrollView.backgroundColor = [UIColor clearColor];
            [self addSubview: self.meScrollView];
        }else if ([reuseIdentifier isEqualToString:@"MyAccountListCell"]){
            self.LogoImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 50, 50)];
            self.LogoImage.image = [UIImage imageNamed:@"MyOne"];
            [self addSubview:self.LogoImage];
    
            self.topLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 5, 130, 20)];
            [self.topLabel  setBackgroundColor:[UIColor clearColor]];
            [self.topLabel  setFont:[UIFont fontWithName:@"Arial" size:16]];
            self.topLabel.textAlignment = NSTextAlignmentCenter;
            [self.topLabel  setTextColor:[UIColor blackColor]];
            self.topLabel.text = @"支付宝账户";
            [self addSubview:self.topLabel];
            
            self.bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 25, 130, 20)];
            [self.bottomLabel  setBackgroundColor:[UIColor clearColor]];
            [self.bottomLabel  setFont:[UIFont fontWithName:@"Arial" size:12]];
            self.bottomLabel.textAlignment = NSTextAlignmentCenter;
            [self.bottomLabel  setTextColor:[UIColor lightGrayColor]];
            self.bottomLabel.text = @"***ahsjd";
            [self addSubview:self.bottomLabel];
        }else if ([reuseIdentifier isEqualToString:@"MyAccountButtonCell"]){
            self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.addButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 300, 40)];
            [self.addButton setTitle:@"添加支付宝账户" forState:UIControlStateNormal];
            [self.addButton setTitleColor:RGB(238, 131, 97) forState:UIControlStateNormal];
            self.addButton.titleLabel.font = [UIFont systemFontOfSize: 18.0];
            self.addButton.layer.borderColor = RGB(198, 198, 198).CGColor;
            self.addButton.layer.borderWidth = 1.5;
            self.addButton.layer.cornerRadius =4;
            [self addSubview:self.addButton];
        }else if ([reuseIdentifier isEqualToString:@"MyCreatedQuanZiListCell"]){
            self.LogoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
            self.LogoImage.backgroundColor = [UIColor orangeColor];
            [self addSubview:self.LogoImage];
            
            self.topLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 130, 20)];
            [self.topLabel  setBackgroundColor:[UIColor clearColor]];
            [self.topLabel  setFont:[UIFont fontWithName:@"Arial" size:16]];
            self.topLabel.textAlignment = NSTextAlignmentCenter;
            [self.topLabel  setTextColor:[UIColor blackColor]];
            self.topLabel.text = @"收货地址";
            [self addSubview:self.topLabel];
            
            self.bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 25, 130, 20)];
            [self.bottomLabel  setBackgroundColor:[UIColor clearColor]];
            [self.bottomLabel  setFont:[UIFont fontWithName:@"Arial" size:12]];
            self.bottomLabel.textAlignment = NSTextAlignmentCenter;
            [self.bottomLabel  setTextColor:[UIColor lightGrayColor]];
            self.bottomLabel.text = @"***ahsjd";
            [self addSubview:self.bottomLabel];
        }else if ([reuseIdentifier isEqualToString:@"MyJoinedQuanZiListCell"]){
            self.LogoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
            self.LogoImage.backgroundColor = [UIColor orangeColor];
            [self addSubview:self.LogoImage];
            
            self.topLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 130, 20)];
            [self.topLabel  setBackgroundColor:[UIColor clearColor]];
            [self.topLabel  setFont:[UIFont fontWithName:@"Arial" size:16]];
            self.topLabel.textAlignment = NSTextAlignmentCenter;
            [self.topLabel  setTextColor:[UIColor blackColor]];
            self.topLabel.text = @"收货地址";
            [self addSubview:self.topLabel];
            
            self.bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 25, 130, 20)];
            [self.bottomLabel  setBackgroundColor:[UIColor clearColor]];
            [self.bottomLabel  setFont:[UIFont fontWithName:@"Arial" size:12]];
            self.bottomLabel.textAlignment = NSTextAlignmentCenter;
            [self.bottomLabel  setTextColor:[UIColor lightGrayColor]];
            self.bottomLabel.text = @"***ahsjd";
            [self addSubview:self.bottomLabel];
        }
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
