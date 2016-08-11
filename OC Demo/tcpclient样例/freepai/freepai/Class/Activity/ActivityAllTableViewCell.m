//
//  ActivityAllTableViewCell.m
//  freepai
//
//  Created by jiangchao on 14-6-24.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "ActivityAllTableViewCell.h"
#import "MZTimerLabel.h"

@implementation ActivityAllTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if ([reuseIdentifier isEqualToString:@"ActivityPageCell"]) {
            self.bg_image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
            self.bg_image.image = [BaseTools randomUIImage];
            [self addSubview:self.bg_image];
            
            self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 10, 230, 15)];
            [self.mainLabel  setBackgroundColor:[UIColor clearColor]];
            [self.mainLabel  setFont:[UIFont fontWithName:@"Arial" size:16]];
            self.mainLabel.textAlignment = NSTextAlignmentLeft;
            [self.mainLabel  setTextColor:[UIColor blackColor]];
            [self addSubview:self.mainLabel];
            
            
            self.secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 25, 230, 15)];
            [self.secondLabel  setBackgroundColor:[UIColor clearColor]];
            [self.secondLabel  setFont:[UIFont fontWithName:@"Arial" size:10]];
            self.secondLabel.textAlignment = NSTextAlignmentLeft;
            [self.secondLabel  setTextColor:[UIColor blackColor]];
            [self addSubview:self.secondLabel];
            
            self.hot_image = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 60, 15, 30, 20)];
            self.hot_image.image = [UIImage imageNamed:@"hot_img"];
            [self addSubview:self.hot_image];
            
            UIImageView *goAheadimg = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 30, 15, 20, 20)];
            goAheadimg.image = [UIImage imageNamed:@"homePageRight"];
            [self addSubview:goAheadimg];
        }else if ([reuseIdentifier isEqualToString:@"KillPriceCell"]){
            self.bg_image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 30, 30)];
            self.bg_image.image = [BaseTools randomUIImage];
            [self addSubview:self.bg_image];
            
            _timeCountDown = [[MZTimerLabel alloc] initWithFrame:CGRectMake(70, 0, 130, 20)];
            _timeCountDown.timerType = MZTimerLabelTypeTimer;
            [self addSubview:_timeCountDown];
            //do some styling
            _timeCountDown.timeLabel.backgroundColor = [UIColor clearColor];
            _timeCountDown.timeLabel.font = [UIFont systemFontOfSize:22.0f];
            _timeCountDown.timeLabel.textColor = [UIColor redColor];
            _timeCountDown.timeLabel.textAlignment = NSTextAlignmentCenter; //UITextAlignmentCenter is deprecated in iOS 7.0
            _timeCountDown.delegate = self;
            
            
            self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 20, 230, 20)];
            [self.mainLabel  setBackgroundColor:[UIColor clearColor]];
            [self.mainLabel  setFont:[UIFont fontWithName:@"Arial" size:16]];
            self.mainLabel.textAlignment = NSTextAlignmentLeft;
            [self.mainLabel  setTextColor:[UIColor blackColor]];
            [self addSubview:self.mainLabel];
            
            
            self.secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 40, 230, 20)];
            [self.secondLabel  setBackgroundColor:[UIColor clearColor]];
            [self.secondLabel  setFont:[UIFont fontWithName:@"Arial" size:10]];
            self.secondLabel.textAlignment = NSTextAlignmentLeft;
            [self.secondLabel  setTextColor:[UIColor blackColor]];
            [self addSubview:self.secondLabel];
            
            self.hot_image = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 60, 20, 30, 20)];
            self.hot_image.image = [UIImage imageNamed:@"hot_img"];
            [self addSubview:self.hot_image];
            
            UIImageView *goAheadimg = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 30, 20, 20, 20)];
            goAheadimg.image = [UIImage imageNamed:@"homePageRight"];
            [self addSubview:goAheadimg];
        }else if ([reuseIdentifier isEqualToString:@"MySendRedEnvelopeListCell"]){
            self.mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 140, 30)];
            [self.mainLabel  setBackgroundColor:[UIColor clearColor]];
            [self.mainLabel  setFont:[UIFont fontWithName:@"Arial" size:14]];
            self.mainLabel.textAlignment = NSTextAlignmentLeft;
            [self.mainLabel  setTextColor:[UIColor blackColor]];
            [self addSubview:self.mainLabel];
            
            
            self.secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 10, 150, 30)];
            [self.secondLabel  setBackgroundColor:[UIColor clearColor]];
            [self.secondLabel  setFont:[UIFont fontWithName:@"Arial" size:10]];
            self.secondLabel.textAlignment = NSTextAlignmentRight;
            [self.secondLabel  setTextColor:[UIColor blackColor]];
            [self addSubview:self.secondLabel];
            
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

- (void)timerLabel:(MZTimerLabel*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    NSLog(@"test timeCountDown delegate");
    self.secondLabel.text = @"活动已结束";
    self.timeCountDown.timeLabel.font = [UIFont systemFontOfSize:24.0f];
    self.timeCountDown.timeLabel.textColor = [UIColor redColor];
}


@end
