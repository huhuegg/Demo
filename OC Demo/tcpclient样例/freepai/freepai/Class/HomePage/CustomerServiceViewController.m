//
//  CustomerServiceViewController.m
//  freepai
//
//  Created by jiangchao on 14-6-10.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "CustomerServiceViewController.h"
#import "CustomerServiceTableViewCell.h"
#import "eggsViewController.h"

@interface CustomerServiceViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CustomerServiceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *bg_ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 22, self.view.frame.size.width, self.view.frame.size.height - 22)];
    //bg_ImageView.image = [UIImage imageNamed:@"u3"];
    [bg_ImageView setBackgroundColor:[UIColor whiteColor]];
    bg_ImageView.userInteractionEnabled = YES;
    [self.view addSubview:bg_ImageView];
    
    UILabel *homePageTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    homePageTitle.center = CGPointMake(self.view.center.x, 37);
    [homePageTitle  setBackgroundColor:[UIColor whiteColor]];
    [homePageTitle  setFont:[UIFont fontWithName:@"Arial" size:16]];
    [homePageTitle  setText:[NSString stringWithFormat:@"客服"]];
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
    
    
    UIControl *rightControl = [[UIControl alloc] initWithFrame:CGRectMake(self.view.frame.size.width- 60, 22, 60, 30)];
    rightControl.backgroundColor = [UIColor whiteColor];
    [rightControl addTarget:self action:@selector(rightControl_touch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightControl];
    
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 5, 20, 20)];
    rightImageView.image = [UIImage imageNamed:@"homePageRight"];
    [rightControl addSubview:rightImageView];
    
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [rightLabel  setBackgroundColor:[UIColor whiteColor]];
    [rightLabel  setFont:[UIFont fontWithName:@"Arial" size:16]];
    [rightLabel  setText:[NSString stringWithFormat:@"Egg"]];
    rightLabel.textAlignment = NSTextAlignmentCenter;
    [rightLabel  setTextColor:RGB(0, 89, 255)];
    [rightControl addSubview:rightLabel];
    
    
    //滚动世界消息
    self.scrollMsgView = [[ScrollMsgView alloc]initWithFrame:CGRectMake(0, 52, self.view.frame.size.width, 15)];
    self.scrollMsgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollMsgView];
    
    
    UITableView *customerServerTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 67, 320, self.view.frame.size.height-67-TabViewHeight)];
    customerServerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    customerServerTableView.delegate = self;
    customerServerTableView.dataSource = self;
    customerServerTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:customerServerTableView];
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

-(void)rightControl_touch
{
    NSLog(@"width:%f height:%f",self.view.frame.size.width,self.view.frame.size.height);
    eggsViewController *eggsVC = [[eggsViewController alloc] init];

    [self.navigationController pushViewController:eggsVC animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    CustomerServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[CustomerServiceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if ([indexPath row] == 0) {
        cell.mainLabel.text = @"FAQ";
        cell.bg_image.image = [UIImage imageNamed:@"FAQ"];
    }else if ([indexPath row] == 1){
        cell.mainLabel.text = @"欢迎页";
        cell.bg_image.image = [UIImage imageNamed:@"Welcome"];
    }else if ([indexPath row] == 2){
        cell.mainLabel.text = @"意见反馈";
        cell.bg_image.image = [UIImage imageNamed:@"Feedback"];
    }else if ([indexPath row] == 3){
        cell.mainLabel.text = @"关于";
        cell.bg_image.image = [UIImage imageNamed:@"About"];
    }
    //cell.textLabel.text = [self.topRecommendedList objectAtIndex:[indexPath row]];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
