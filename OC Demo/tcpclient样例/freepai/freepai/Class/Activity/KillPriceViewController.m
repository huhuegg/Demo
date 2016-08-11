//
//  KillPriceViewController.m
//  freepai
//
//  Created by admin on 14/6/16.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "KillPriceViewController.h"
#import "YukeyScrollView.h"
#import "ActivityAllTableViewCell.h"
#import "KillPriceRuleDescViewController.h"
#import "haggleViewController.h"

@interface KillPriceViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation KillPriceViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    [self getKillPricePageData];
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
    // bg_ImageView.image = [UIImage imageNamed:@"u3"];
    [bg_ImageView setBackgroundColor:[UIColor whiteColor]];
    bg_ImageView.userInteractionEnabled = YES;
    [self.view addSubview:bg_ImageView];
    
    UILabel *homePageTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    homePageTitle.center = CGPointMake(self.view.center.x, 37);
    [homePageTitle  setBackgroundColor:[UIColor whiteColor]];
    [homePageTitle  setFont:[UIFont fontWithName:@"Arial" size:16]];
    [homePageTitle  setText:[NSString stringWithFormat:@"杀价王"]];
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
    [rightLabel  setText:[NSString stringWithFormat:@"说明"]];
    rightLabel.textAlignment = NSTextAlignmentCenter;
    [rightLabel  setTextColor:RGB(0, 89, 255)];
    [rightControl addSubview:rightLabel];
    
    
    //滚动世界消息
    self.scrollMsgView = [[ScrollMsgView alloc]initWithFrame:CGRectMake(0, 52, self.view.frame.size.width, 15)];
    self.scrollMsgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollMsgView];
    
    YukeyScrollView *yukeyScrollView = [[YukeyScrollView alloc] initWithFrame:CGRectMake(0, 67, 320, 150) withImageArray:@[@"one",@"two",@"three",@"four"]];
    yukeyScrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:yukeyScrollView];
    
    self.killPriceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 217, 320, self.view.frame.size.height-217-TabViewHeight)];
    // self.myPropertyInformationTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.killPriceTableView.delegate = self;
    self.killPriceTableView.dataSource = self;
    self.killPriceTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.killPriceTableView];
}

#pragma mark - ButtonAction
-(void)leftControl_touch
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightControl_touch
{
    KillPriceRuleDescViewController *ruleDesc = [[KillPriceRuleDescViewController alloc] init];
    [self.navigationController pushViewController:ruleDesc animated:YES];
}

-(void)dealloc
{
    self.killPriceTableView = nil;
    self.scrollMsgView = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [CacheDataManager sharedInstance].haggleList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"KillPriceCell";
    ActivityAllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ActivityAllTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    id dict = [[CacheDataManager sharedInstance].haggleList objectAtIndex:[indexPath row]];
    if ([dict isKindOfClass:[NSDictionary class]]) {
        double time = [[dict objectForKey:@"resizetime"] intValue];
        if (time == -1) {
            cell.secondLabel.text = @"活动未开始";
        }else if (time == 0){
            cell.mainLabel.text = [dict objectForKey:@"name"];
            cell.secondLabel.text = @"活动已结束";
        }else if (time >0){
            [cell.timeCountDown setCountDownTime:time];
            [cell.timeCountDown start];
            
            
            cell.mainLabel.text = [dict objectForKey:@"name"];
            cell.secondLabel.text = [[NSString alloc]initWithFormat:@"指导积分:%@",[dict objectForKey:@"recommand_price"]];
        }
        
        if ([[dict objectForKey:@"hot"] intValue] == 1) {
            cell.hot_image.hidden = NO;
        }else{
            cell.hot_image.hidden = YES;
        }
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    double time = [[[[CacheDataManager sharedInstance].haggleList objectAtIndex:[indexPath row]] objectForKey:@"resizetime"] intValue];
    if (time == -1) {
        ALERT(@"提示", @"活动未开始", @"好的");
    }else if (time == 0){
        ALERT(@"提示", @"活动已结束", @"好的");
    }else if (time >0){
        haggleViewController *haggleVC = [[haggleViewController alloc] init:[[CacheDataManager sharedInstance].haggleList objectAtIndex:[indexPath row]]];
        [self.navigationController pushViewController:haggleVC animated:YES];
    }
}

-(void)getKillPricePageData
{
    [[ServerDataManager sharedInstance] requestPPCFirstPageList:[CacheDataManager sharedInstance].uuid LoginResource:@"None" Request:@"None" completeBlock:^(id reqRes) {
        if (reqRes && [reqRes isKindOfClass:[AFHTTPRequestOperation class]]) {
            AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)reqRes;
            if (operation.response.statusCode == 200) {
                NSDictionary *dict = [BaseTools decodeJsonString:operation.responseData];
                id dataObject = [dict objectForKey:@"dataObject"];
                if ([dataObject isKindOfClass:[NSDictionary class]]) {
                    [CacheDataManager sharedInstance].haggleList = [[NSMutableArray alloc] initWithArray:[dataObject objectForKey:@"details"]];
                }else{
                    [CacheDataManager sharedInstance].haggleList = [[NSMutableArray alloc] init];
                }
                [self.killPriceTableView reloadData];
            }else{
                NSString *status = [NSString stringWithFormat:@"%i",operation.response.statusCode];
                NSString *dataString = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
                ALERT(status, dataString, @"好的");
            }
        }
    }];
}



@end
