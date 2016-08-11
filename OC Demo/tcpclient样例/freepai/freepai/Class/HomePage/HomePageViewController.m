//
//  HomePageViewController.m
//  freepai
//
//  Created by jiangchao on 14-6-5.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "HomePageViewController.h"
#import "ADTickerLabel.h"
#import "HomePageTableViewCell.h"
#import "ScoreBoardViewController.h"
#import "MessageViewController.h"
#import "ExchangePageViewController.h"
#import "CustomerServiceViewController.h"
#import "CacheDataManager.h"
#import "DAAutoTableView.h"


@interface HomePageViewController ()
{
    ADTickerLabel *cointCountLabel;
}

@end


@implementation HomePageViewController

-(void)viewWillAppear:(BOOL)animated
{
    if (self.scrollMsgView) {
        [self.scrollMsgView startRefreshData];
        [self.scrollMsgView startScrolling];
    }
    [self getUserIntegral];
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
    self.topRecommendedList = [[NSMutableArray alloc] initWithArray:@[@"热门推荐 一",@"热门推荐 二",@"热门推荐 三"]];
    UIImageView *bg_ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 22, SCREEN_WIDTH, SCREEN_HEIGHT - 22)];
    //bg_ImageView.image = [UIImage imageNamed:@"u3"];
    [bg_ImageView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bg_ImageView];
    
    UILabel *homePageTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    homePageTitle.center = CGPointMake(self.view.center.x, 37);
    [homePageTitle  setBackgroundColor:[UIColor whiteColor]];
    [homePageTitle  setFont:[UIFont fontWithName:@"Arial" size:16]];
    [homePageTitle  setText:[NSString stringWithFormat:@"自由派"]];
    homePageTitle.textAlignment = NSTextAlignmentCenter;
    [homePageTitle  setTextColor:RGB(229, 61, 22)];
    [self.view addSubview:homePageTitle];
    
    //滚动世界消息
    self.scrollMsgView = [[ScrollMsgView alloc]initWithFrame:CGRectMake(0, 52, self.view.frame.size.width, 30)];
    self.scrollMsgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollMsgView];

    
    
    UILabel *accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 82, 130, 15)];
    [accountLabel  setBackgroundColor:[UIColor clearColor]];
    [accountLabel  setFont:[UIFont fontWithName:@"Arial" size:12]];
      DLog(@"[CacheDataManager sharedInstance].userName:%@",[CacheDataManager sharedInstance].userName);
    if (![[CacheDataManager sharedInstance].userName isEqualToString:@"None"]) {
        accountLabel.text = [NSString stringWithFormat:@"账号:%@",[CacheDataManager sharedInstance].userName];
    }else{
        accountLabel.text = @"账号:--";
    }
    accountLabel.textAlignment = NSTextAlignmentLeft;
    [accountLabel  setTextColor:[UIColor blackColor]];
    [self.view addSubview:accountLabel];
    
    
    
    cointCountLabel = [[ADTickerLabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 150,82-2, 80, 15)];
    [cointCountLabel  setBackgroundColor:[UIColor clearColor]];
    [cointCountLabel  setFont:[UIFont fontWithName:@"Arial" size:18]];
    cointCountLabel.characterWidth = 12.0;
    [cointCountLabel  setTextColor:RGB(229, 61, 22)];
    [self.view addSubview:cointCountLabel];
    
    UILabel *cointLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 150+80,82, 50, 15)];
    [cointLabel  setBackgroundColor:[UIColor clearColor]];
    [cointLabel  setFont:[UIFont fontWithName:@"Arial" size:16]];
    [cointLabel  setText:[NSString stringWithFormat:@"积分"]];
    cointLabel.textAlignment = NSTextAlignmentLeft;
    [cointLabel  setTextColor:RGB(229, 61, 22)];
    [self.view addSubview:cointLabel];
   
    /*
    UIButton * scoreBoardButton =[UIButton buttonWithType:UIButtonTypeCustom];
    scoreBoardButton.frame = CGRectMake(5, 95, 150, 40);
    scoreBoardButton.backgroundColor = RGB(6, 163, 232);
    [scoreBoardButton setTitle:@"积分总榜" forState:UIControlStateNormal];
    scoreBoardButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:16];
    [scoreBoardButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [scoreBoardButton addTarget:self action:@selector(scoreBoardButton_touch:) forControlEvents:UIControlEventTouchUpInside];
    scoreBoardButton.layer.cornerRadius = 4;
    [self.view addSubview:scoreBoardButton];
     */
    
    UIButton * fastCashButton =[UIButton buttonWithType:UIButtonTypeCustom];
    fastCashButton.frame = CGRectMake(10,100, self.view.frame.size.width-20, 35);
    fastCashButton.backgroundColor = RGB(6, 163, 232);
    [fastCashButton setTitle:@"兑换提现" forState:UIControlStateNormal];
    fastCashButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:16];
    [fastCashButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [fastCashButton addTarget:self action:@selector(fastCashButton_touch) forControlEvents:UIControlEventTouchUpInside];
    fastCashButton.layer.cornerRadius = 4;
    [self.view addSubview:fastCashButton];
    
    
    self.topRecommendedTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 140, 320, self.view.frame.size.height-140-TabViewHeight)];
    self.topRecommendedTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.topRecommendedTableView.delegate = self;
    self.topRecommendedTableView.dataSource = self;
    self.topRecommendedTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.topRecommendedTableView];
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    cointCountLabel = nil;
    self.topRecommendedTableView = nil;
    self.topRecommendedList = nil;
    self.scrollMsgView = nil;
}


#pragma mark - ButtonAction
-(void)scoreBoardButton_touch:(UIButton *)sender
{
    ScoreBoardViewController *scoreBoard = [[ScoreBoardViewController alloc] init];
    [self.navigationController pushViewController:scoreBoard animated:YES];
}

-(void)fastCashButton_touch
{
    ExchangePageViewController *exchange = [[ExchangePageViewController alloc] init];
    [self.navigationController pushViewController:exchange animated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topRecommendedList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.frame.size.height/2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    HomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[HomePageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    CGRect frame = cell.bg_image.frame;
    frame.origin.x = 5;
    frame.size.width = 310;
    frame.size.height = tableView.frame.size.height/2-5;
    cell.bg_image.frame = frame;
    if ([indexPath row] == 0) {
        //cell.bg_image.image = [UIImage imageNamed:@"u80"];
        cell.bg_image.image = [UIImage imageNamed:@"hd1"];
    }else if ([indexPath row] == 1){
        //cell.bg_image.image = [UIImage imageNamed:@"u82"];
        cell.bg_image.image = [UIImage imageNamed:@"hd2"];
    }else if ([indexPath row] == 2){
        //cell.bg_image.image = [UIImage imageNamed:@"u84"];
        cell.bg_image.image = [UIImage imageNamed:@"hd3"];
    }
    //cell.textLabel.text = [self.topRecommendedList objectAtIndex:[indexPath row]];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] init];
        [dataDict setObject:@"1" forKey:@"taskid"];
        NSError *error = nil;
        NSData *jsondata = [NSJSONSerialization dataWithJSONObject:dataDict options:NSJSONWritingPrettyPrinted error:&error];
        if (error) {
            NSLog(@"%@",error);
        }
        NSString *data = [[NSString alloc] initWithData:jsondata encoding:NSUTF8StringEncoding];
        data = [BaseTools newgetURLStringFromString:data];
        NSURL *gameUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@://com.FreePai.Game?data=%@",@"FP32dd5akxiioq8a6x",data]];
        if ([self APCheckIfAppInstalled2:gameUrl]) {
            [[UIApplication sharedApplication] openURL:gameUrl];
        }else{
            ALERT(@"提示", @"您还未安装此游戏请前往下载安装", @"好的");
        }
    }
}


//获取玩家可用积分
-(void)getUserIntegral
{
    if ([CacheDataManager sharedInstance].uuid && ![[CacheDataManager sharedInstance].uuid isEqualToString:@"None"]) {
        [[ServerDataManager sharedInstance] requestUserPointOwnerSearch:[CacheDataManager sharedInstance].uuid  LoginResource:@"None" Request:@"None" completeBlock:^(id reqRes) {
            if (reqRes && [reqRes isKindOfClass:[AFHTTPRequestOperation class]]) {
                AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)reqRes;
                if (operation.response.statusCode == 200) {
                    cointCountLabel.text = [CacheDataManager sharedInstance].userIntegral;
                }else{
                    cointCountLabel.text = @"0";
                }
            }
        }];
    }
}


-(BOOL) APCheckIfAppInstalled2:(NSURL *)urlSchemes
{
    if ([[UIApplication sharedApplication] canOpenURL:urlSchemes])
    {
        NSLog(@"%@",urlSchemes);
        
        return YES;
    }
    else
    {
        return NO;
    }
}
@end
