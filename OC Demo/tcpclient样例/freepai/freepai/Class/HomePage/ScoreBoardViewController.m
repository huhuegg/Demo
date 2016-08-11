//
//  ScoreBoardViewController.m
//  freepai
//
//  Created by jiangchao on 14-6-5.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "ScoreBoardViewController.h"
#import "YukeySegmentedControl.h"
#import "ScoreBoardTableViewCell.h"

@interface ScoreBoardViewController ()<YukeySegmentedControlDelegate>
{
    NSString *ScoreBoardType;
}

@end

@implementation ScoreBoardViewController

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
    UIImageView *bg_ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 67, self.view.frame.size.width, self.view.frame.size.height - 67)];
    //bg_ImageView.image = [UIImage imageNamed:@"u3"];
    [bg_ImageView setBackgroundColor:[UIColor whiteColor]];
    bg_ImageView.userInteractionEnabled = YES;
    [self.view addSubview:bg_ImageView];
    
    UILabel *homePageTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    homePageTitle.center = CGPointMake(self.view.center.x, 37);
    [homePageTitle  setBackgroundColor:[UIColor whiteColor]];
    [homePageTitle  setFont:[UIFont fontWithName:@"Arial" size:16]];
    [homePageTitle  setText:[NSString stringWithFormat:@"积分总榜"]];
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
    
    
    self.scrollMsgView = [[ScrollMsgView alloc]initWithFrame:CGRectMake(0, 52, self.view.frame.size.width, 15)];
    self.scrollMsgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollMsgView];
    

    YukeySegmentedControl *yukeySegmentedControl = [[YukeySegmentedControl alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 30) leftTitle:@"昨日收入" centerTitle:@"上周个人" rightTitle: @"上月帮派"];
    yukeySegmentedControl.delegate = self;
    yukeySegmentedControl.leftButton.selected = YES;
    [self.view addSubview:yukeySegmentedControl];
   
    
    self.scoreBoardTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, 320, self.view.frame.size.height-140-TabViewHeight)];
    self.scoreBoardTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.scoreBoardTableView.delegate = self;
    self.scoreBoardTableView.dataSource = self;
    self.scoreBoardTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.scoreBoardTableView];
    
    [self getYesterdayIncomeList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    self.scoreBoardTableView = nil;
    self.scoreBoardList = nil;
    self.scrollMsgView = nil;
}

#pragma mark - GetList
-(void)getYesterdayIncomeList
{
    self.scoreBoardList = [[NSMutableArray alloc] initWithArray:[CacheDataManager sharedInstance].yesterdayActivityPointsList];
    ScoreBoardType = @"yesterdayActivityPoints";
    [self.scoreBoardTableView reloadData];
}

-(void)getLastWeekList
{
    self.scoreBoardList = [[NSMutableArray alloc] initWithArray:[CacheDataManager sharedInstance].lastweekPersonPointsList];
    ScoreBoardType = @"lastweekPersonPoints";
    [self.scoreBoardTableView reloadData];
}

-(void)getLastMonthList
{
    self.scoreBoardList = [[NSMutableArray alloc] initWithArray:[CacheDataManager sharedInstance].lastMonthTeamPointList];
    ScoreBoardType = @"lastMonthTeamPoint";
    [self.scoreBoardTableView reloadData];
}


#pragma mark - ButtonAction
-(void)leftControl_touch
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - YukeySegmentedControlDelegate
-(void)selectedButton:(UIButton *)btn
{
    if (btn.tag == 1) {
        [self getYesterdayIncomeList];
    }else if (btn.tag == 2){
        [self getLastWeekList];
    }else if (btn.tag == 3){
        [self getLastMonthList];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.scoreBoardList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    ScoreBoardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ScoreBoardTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    id dict = [self.scoreBoardList objectAtIndex:[indexPath row]];
    if ([dict isKindOfClass:[NSDictionary class]]) {
        NSString *level = [dict objectForKey:@"level"];
        NSString *gold = [dict objectForKey:@"gold"];
        if ([ScoreBoardType isEqualToString:@"yesterdayActivityPoints"]) {
            NSString *activityname = [dict objectForKey:@"activityname"];
            cell.mainLabel.text = [NSString stringWithFormat:@"NO.%@",level];
            cell.secondLabel.text = [NSString stringWithFormat:@"%@",activityname];
            cell.thirdLabel.text = [NSString stringWithFormat:@"%@积分",gold];
            //cell.mainLabel.text = [NSString stringWithFormat:@"NO.%@ %@  %@积分",level,activityname,gold];
            cell.bg_image.hidden = YES;
            cell.mainLabel.textColor = [UIColor blackColor];
            cell.secondLabel.textColor = [UIColor blackColor];
            cell.thirdLabel.textColor = [UIColor blackColor];
        }else if ([ScoreBoardType isEqualToString:@"lastweekPersonPoints"]){
            NSString *nickname = [dict objectForKey:@"nickname"];
            if ([indexPath row] == 0) {
                cell.bg_image.hidden = NO;
                //cell.mainLabel.text = [NSString stringWithFormat:@"您的个人排名是%@  %@积分",level,gold];
                cell.mainLabel.text = [NSString stringWithFormat:@"NO.%@",level];
                cell.secondLabel.text = [NSString stringWithFormat:@"我"];
                cell.thirdLabel.text = [NSString stringWithFormat:@"%@积分",gold];
                cell.mainLabel.textColor = RGB(229, 67, 22);
                cell.secondLabel.textColor = RGB(229, 67, 22);
                cell.thirdLabel.textColor = RGB(229, 67, 22);
            }else{
                //cell.mainLabel.text = [NSString stringWithFormat:@"NO.%@ %@  %@积分",level,nickname,gold];
                cell.mainLabel.text = [NSString stringWithFormat:@"NO.%@",level];
                cell.secondLabel.text = [NSString stringWithFormat:@"%@",nickname];
                cell.thirdLabel.text = [NSString stringWithFormat:@"%@积分",gold];
                cell.bg_image.hidden = YES;
                cell.mainLabel.textColor = [UIColor blackColor];
                cell.secondLabel.textColor = [UIColor blackColor];
                cell.thirdLabel.textColor = [UIColor blackColor];
            }
            
        }else if ([ScoreBoardType isEqualToString:@"lastMonthTeamPoint"]){
            NSString *teamname = [dict objectForKey:@"teamname"];
            if ([indexPath row] == 0) {
                cell.bg_image.hidden = NO;
                //cell.mainLabel.text = [NSString stringWithFormat:@"您的帮派排名是%@  %@积分",level,gold];
                cell.mainLabel.text = [NSString stringWithFormat:@"NO.%@",level];
                cell.secondLabel.text = [NSString stringWithFormat:@"我的自建帮派"];
                cell.thirdLabel.text = [NSString stringWithFormat:@"%@积分",gold];
                cell.mainLabel.textColor = RGB(229, 67, 22);
                cell.secondLabel.textColor = RGB(229, 67, 22);
                cell.thirdLabel.textColor = RGB(229, 67, 22);
            }else{
                //cell.mainLabel.text = [NSString stringWithFormat:@"NO.%@ %@  %@积分",level,teamname,gold];
                cell.mainLabel.text = [NSString stringWithFormat:@"NO.%@",level];
                cell.secondLabel.text = [NSString stringWithFormat:@"%@",teamname];
                cell.thirdLabel.text = [NSString stringWithFormat:@"%@积分",gold];
                cell.bg_image.hidden = YES;
                cell.mainLabel.textColor = [UIColor blackColor];
                cell.secondLabel.textColor = [UIColor blackColor];
                cell.thirdLabel.textColor = [UIColor blackColor];
            }
            
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
