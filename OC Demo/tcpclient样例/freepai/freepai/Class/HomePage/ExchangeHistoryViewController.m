//
//  ExchangeHistoryViewController.m
//  freepai
//
//  Created by jiangchao on 14-6-5.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "ExchangeHistoryViewController.h"
//#import "HMSegmentedControl.h"
#import "ExchangeHistoryTableViewCell.h"

@interface ExchangeHistoryViewController ()

@end

@implementation ExchangeHistoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * backButton =[UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(20, 20, 40, 30);
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:16];
    [backButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButton_touch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel *homePageTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
    [homePageTitle  setBackgroundColor:[UIColor clearColor]];
    homePageTitle.center = CGPointMake(self.view.center.x, 35);
    [homePageTitle  setFont:[UIFont fontWithName:@"Arial" size:16]];
    [homePageTitle  setText:[NSString stringWithFormat:@"自由派"]];
    homePageTitle.textAlignment = NSTextAlignmentCenter;
    [homePageTitle  setTextColor:[UIColor orangeColor]];
    [self.view addSubview:homePageTitle];
    
    /*
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"赚钱记录", @"兑换记录", @"推广记录"]];
    [segmentedControl setFrame:CGRectMake(60, 70, 200, 40)];
    [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [segmentedControl setTag:1];
    [self.view addSubview:segmentedControl];
     */
    
    
    self.exchangeHistoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, 320, self.view.frame.size.height-140-TabViewHeight)];
    self.exchangeHistoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.exchangeHistoryTableView.delegate = self;
    self.exchangeHistoryTableView.dataSource = self;
    self.exchangeHistoryTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.exchangeHistoryTableView];
    
    [self gotMakeMoneyHistoryList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)dealloc
{
    self.exchangeHistoryList = nil;
    self.exchangeHistoryTableView = nil;
}

#pragma mark - ButtonAction
-(void)backButton_touch
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - HMSegmentedControlBackFunction
/*
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
	NSLog(@"Selected index %li (via UIControlEventValueChanged)", (long)segmentedControl.selectedIndex);
    if (segmentedControl.selectedIndex == 0) {
        [self gotMakeMoneyHistoryList];
    }else if (segmentedControl.selectedIndex == 1) {
        [self gotExchangeHistoryList];
    }else if (segmentedControl.selectedIndex == 2) {
        [self gotExtensionHistoryList];
    }
}
 */


#pragma mark - GetList
-(void)gotMakeMoneyHistoryList
{
    self.exchangeHistoryList = [[NSMutableArray alloc] initWithArray:@[@"No.1 大转盘 1000000金币",@"No.2 开心答题 800000金币",@"No.3 看广告 600000金币",@"......"]];
    [self.exchangeHistoryTableView reloadData];
}

-(void)gotExchangeHistoryList
{
    self.exchangeHistoryList = [[NSMutableArray alloc] initWithArray:@[@"您当前排名第10名",@"No.1 XXX 1000000金币",@"No.2 XXXX 800000金币",@"No.3 XXXX 600000金币",@"No.4 XXXX 500000金币",@"No.5 XXXX 400000金币",@"No.6 XXXX 300000金币",@"No.7 XXXX 200000金币"]];
    [self.exchangeHistoryTableView reloadData];
}

-(void)gotExtensionHistoryList
{
    self.exchangeHistoryList = [[NSMutableArray alloc] initWithArray:@[@"您的帮派当前排名第9名",@"No.1 少林派 1000000金币",@"No.2 峨眉派 800000金币",@"No.3 武当派 600000金币",@"......"]];
    [self.exchangeHistoryTableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.exchangeHistoryList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    ExchangeHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ExchangeHistoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [self.exchangeHistoryList objectAtIndex:[indexPath row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
