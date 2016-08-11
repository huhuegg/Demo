//
//  Me_PersonalInfoView.m
//  freepai
//
//  Created by jiangchao on 14-6-5.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "Me_PersonalInfoView.h"

@implementation Me_PersonalInfoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIFont *newfont = [UIFont fontWithName:@"Arial" size:13];
        UIColor *newcolor = [UIColor blackColor];
        
    
        self.headImageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
        self.headImageView.center = CGPointMake(frame.size.width/2, 50);
        self.headImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headButton_touch)];
        tapRecognizer.numberOfTouchesRequired = 1;
        tapRecognizer.numberOfTapsRequired = 1;
        [self.headImageView addGestureRecognizer:tapRecognizer];
        [self addSubview:self.headImageView];
        
        /*
        self.headButton =[UIButton buttonWithType:UIButtonTypeCustom];
        self.headButton.frame = CGRectMake(0, 0, 30, 30);
        self.headButton.center = CGPointMake(300, 50);
        [self.headButton setImage:[UIImage imageNamed:@"MePicture"] forState:UIControlStateNormal];
        [self.headButton addTarget:self action:@selector(headButton_touch) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.headButton];
         */
        
        
        self.accountTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 260,30)];
        [self.accountTitle  setBackgroundColor:[UIColor clearColor]];
        [self.accountTitle  setFont:newfont];
        [self.accountTitle  setText:[NSString stringWithFormat:@"昵称:"]];
        self.accountTitle.textAlignment = NSTextAlignmentLeft;
        [self.accountTitle  setTextColor:newcolor];
        [self addSubview:self.accountTitle];
    
        
        self.accountButton =[UIButton buttonWithType:UIButtonTypeCustom];
        self.accountButton.frame = CGRectMake(280, 100, 30, 30);
        [self.accountButton setImage:[UIImage imageNamed:@"ExchangeCoinButton"] forState:UIControlStateNormal];
        [self.accountButton addTarget:self action:@selector(accountButton_touch) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.accountButton];
        
        
        self.partyTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, 260, 30)];
        [self.partyTitle  setBackgroundColor:[UIColor clearColor]];
        [self.partyTitle  setFont:newfont];
        [self.partyTitle  setText:[NSString stringWithFormat:@"自建帮派:"]];
        self.partyTitle.textAlignment = NSTextAlignmentLeft;
        [self.partyTitle  setTextColor:newcolor];
        [self addSubview:self.partyTitle];
        
        self.partyButton =[UIButton buttonWithType:UIButtonTypeCustom];
        self.partyButton.frame = CGRectMake(280, 140 , 30, 30);
        [self.partyButton setImage:[UIImage imageNamed:@"ExchangeCoinButton"] forState:UIControlStateNormal];
        [self.partyButton addTarget:self action:@selector(partyButton_touch) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.partyButton];
        
        
        
        UILabel *infoTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 115, frame.size.width, 30)];
        [infoTitle  setBackgroundColor:[UIColor lightGrayColor]];
        [infoTitle  setFont:newfont];
        [infoTitle  setText:[NSString stringWithFormat:@"密码找回验证信息"]];
        infoTitle.textAlignment = NSTextAlignmentCenter;
        [infoTitle  setTextColor:newcolor];
        [self addSubview:infoTitle];
        
        
        self.realNameTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, frame.size.height - 80, 260, 30)];
        [self.realNameTitle  setBackgroundColor:[UIColor clearColor]];
        [self.realNameTitle  setFont:newfont];
        [self.realNameTitle  setText:[NSString stringWithFormat:@"真实姓名:"]];
        self.realNameTitle.textAlignment = NSTextAlignmentLeft;
        [self.realNameTitle  setTextColor:newcolor];
        [self addSubview:self.realNameTitle];
        
        
        self.realNameButton =[UIButton buttonWithType:UIButtonTypeCustom];
        self.realNameButton.frame = CGRectMake(280, frame.size.height - 80, 30, 30);
        [self.realNameButton setImage:[UIImage imageNamed:@"ExchangeCoinButton"] forState:UIControlStateNormal];
        [self.realNameButton addTarget:self action:@selector(realNameButton_touch) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.realNameButton];
        
        
        self.idTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, frame.size.height - 40 , 260, 30)];
        [self.idTitle  setBackgroundColor:[UIColor clearColor]];
        [self.idTitle  setFont:newfont];
        [self.idTitle  setText:[NSString stringWithFormat:@"身份证号:310**********6789"]];
        self.idTitle.textAlignment = NSTextAlignmentLeft;
        [self.idTitle  setTextColor:newcolor];
        [self addSubview:self.idTitle];

        
        self.idButton =[UIButton buttonWithType:UIButtonTypeCustom];
        self.idButton.frame = CGRectMake(280, frame.size.height - 40, 30 , 30);
        [self.idButton setImage:[UIImage imageNamed:@"ExchangeCoinButton"] forState:UIControlStateNormal];
        [self.idButton addTarget:self action:@selector(idButton_touch) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.idButton];

        
        
    }
    return self;
}

#pragma mark - ButtonAction
-(void)headButton_touch
{
    [self.delegate personalInfoHeadButtonTouch];
}

-(void)accountButton_touch
{
    [self.delegate personalInfoAccountButtonTouch];
}

-(void)partyButton_touch
{
    [self.delegate personalInfoPartyButtonTouch];
}

-(void)realNameButton_touch
{
    [self.delegate personalInfoRealNameButtonTouch];
}

-(void)idButton_touch
{
    [self.delegate personalInfoIDButtonTouch];
}
    

@end
