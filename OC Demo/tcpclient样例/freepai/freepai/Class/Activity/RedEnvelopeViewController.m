//
//  RedEnvelopeViewController.m
//  freepai
//
//  Created by jiangchao on 14-6-24.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "RedEnvelopeViewController.h"
#import "YukeySegmentedControl.h"
#import "SendRedEnvelopeViewController.h"
#import "ReceivedRedEnvelopeViewController.h"
#import "MySendRedEnvelopeViewController.h"

@interface RedEnvelopeViewController ()<YukeySegmentedControlDelegate>

@end

@implementation RedEnvelopeViewController

-(void)viewWillAppear:(BOOL)animated
{
    if (self.scrollMsgView) {
        [self.scrollMsgView startRefreshData];
        [self.scrollMsgView startScrolling];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    if (self.scrollMsgView) {
        [self.scrollMsgView stopRefreshData];
        [self.scrollMsgView stopScrolling];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *bg_ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 67, self.view.frame.size.width, self.view.frame.size.height - 67)];
    //bg_ImageView.image = [UIImage imageNamed:@"u3"];
    [bg_ImageView setBackgroundColor:[UIColor whiteColor]];
    bg_ImageView.userInteractionEnabled = YES;
    [self.view addSubview:bg_ImageView];
    
    UILabel *homePageTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    homePageTitle.center = CGPointMake(self.view.center.x, 37);
    [homePageTitle  setBackgroundColor:[UIColor whiteColor]];
    [homePageTitle  setFont:[UIFont fontWithName:@"Arial" size:16]];
    [homePageTitle  setText:[NSString stringWithFormat:@"派红包"]];
    homePageTitle.textAlignment = NSTextAlignmentCenter;
    [homePageTitle  setTextColor:RGB(229, 61, 22)];
    [self.view addSubview:homePageTitle];
    
    UIControl *leftControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 22, 60, 30)];
    leftControl.backgroundColor = [UIColor whiteColor];
    [leftControl addTarget:self action:@selector(leftControl_touch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftControl];
    
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 20, 20)];
    leftImageView.image = [UIImage imageNamed:@"homePageLeft"];
    [leftControl addSubview:leftImageView];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 40, 30)];
    [leftLabel  setBackgroundColor:[UIColor whiteColor]];
    [leftLabel  setFont:[UIFont fontWithName:@"Arial" size:16]];
    [leftLabel  setText:[NSString stringWithFormat:@"返回"]];
    leftLabel.textAlignment = NSTextAlignmentLeft;
    [leftLabel  setTextColor:RGB(0, 89, 255)];
    [leftControl addSubview:leftLabel];
    
    
    //滚动世界消息
    self.scrollMsgView = [[ScrollMsgView alloc]initWithFrame:CGRectMake(0, 52, self.view.frame.size.width, 15)];
    self.scrollMsgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollMsgView];
    // Do any additional setup after loading the view.
    
    UIImageView *mainImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 67, SCREEN_WIDTH, 150)];
    mainImg.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:mainImg];
    mainImg.image = [UIImage imageNamed:@"hb_img"];
    
    UIButton *mainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    mainButton.frame = CGRectMake(10, 220, 300, 60);
    [mainButton setTitle:@"派送拼手气红包" forState:UIControlStateNormal];
    [mainButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    mainButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:20];
    [mainButton addTarget:self action:@selector(mainButton_touch) forControlEvents:UIControlEventTouchUpInside];
    mainButton.layer.cornerRadius = 4;
    mainButton.layer.borderColor = [UIColor grayColor].CGColor;
    mainButton.layer.borderWidth = 1;
    [self.view addSubview:mainButton];
    
    
    YukeySegmentedControl *yukeySegmentedControl = [[YukeySegmentedControl alloc] initWithFrame:CGRectMake(0, 290, self.view.frame.size.width, 30) leftTitle:@"收到的红包" centerTitle:@"我发的红包" rightTitle: @"常见问题"];
    yukeySegmentedControl.delegate = self;
    yukeySegmentedControl.leftButton.selected = YES;
    [self.view addSubview:yukeySegmentedControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ButtonAction
-(void)leftControl_touch
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)mainButton_touch
{
    SendRedEnvelopeViewController *sendRedEnvelop = [[SendRedEnvelopeViewController alloc] init];
    [self.navigationController pushViewController:sendRedEnvelop animated:YES];
}

#pragma mark - YukeySegmentedControlDelegate
-(void)selectedButton:(UIButton *)btn
{
    NSLog(@"btn.tag=%i",btn.tag);
    if (btn.tag == 1) {
        ReceivedRedEnvelopeViewController *rRedVC = [[ReceivedRedEnvelopeViewController alloc]init];
        [self.navigationController pushViewController:rRedVC animated:YES];
        
    }else if (btn.tag == 2){
        MySendRedEnvelopeViewController *mySendRedEnvelope = [[MySendRedEnvelopeViewController alloc] init];
        [self.navigationController pushViewController:mySendRedEnvelope animated:YES];
    }else if (btn.tag == 3){
       
    }
}

@end
