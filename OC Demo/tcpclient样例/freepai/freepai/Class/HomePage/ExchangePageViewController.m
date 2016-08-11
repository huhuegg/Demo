//
//  ExchangePageViewController.m
//  freepai
//
//  Created by jiangchao on 14-6-5.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "ExchangePageViewController.h"
#import "ExchangePageTableViewCell.h"
#import "ExchangeHistoryViewController.h"
#import "YukeyScrollView.h"
#import "MyPropertyInformationViewController.h"
#import "AllWebViewController.h"

@interface ExchangePageViewController ()
{
    UILabel *cointLabel;
}

@end

@implementation ExchangePageViewController

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
    UIImageView *bg_ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 67, self.view.frame.size.width, self.view.frame.size.height - 67)];
    //bg_ImageView.image = [UIImage imageNamed:@"u3"];
    [bg_ImageView setBackgroundColor:[UIColor whiteColor]];
    bg_ImageView.userInteractionEnabled = YES;
    [self.view addSubview:bg_ImageView];
    
    UILabel *homePageTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    homePageTitle.center = CGPointMake(self.view.center.x, 37);
    [homePageTitle  setBackgroundColor:[UIColor whiteColor]];
    [homePageTitle  setFont:[UIFont fontWithName:@"Arial" size:16]];
    [homePageTitle  setText:[NSString stringWithFormat:@"快捷提现"]];
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
    [rightLabel  setText:[NSString stringWithFormat:@"记录"]];
    rightLabel.textAlignment = NSTextAlignmentCenter;
    [rightLabel  setTextColor:RGB(0, 89, 255)];
    [rightControl addSubview:rightLabel];
    
    
    //滚动世界消息
    self.scrollMsgView  = [[ScrollMsgView alloc]initWithFrame:CGRectMake(0, 52, self.view.frame.size.width, 15)];
    self.scrollMsgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollMsgView];
    
    /*
    YukeyScrollView *yukeyScrollView = [[YukeyScrollView alloc] initWithFrame:CGRectMake(0, 67, 320, 150) withImageArray:@[@"one",@"two",@"three",@"four"]];
    yukeyScrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:yukeyScrollView];
    */
     
    cointLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,70, 320, 40)];
    [cointLabel  setBackgroundColor:[UIColor clearColor]];
    [cointLabel  setFont:[UIFont fontWithName:@"Arial" size:16]];
    cointLabel.textAlignment = NSTextAlignmentCenter;
    [cointLabel  setTextColor:[UIColor orangeColor]];
    [self.view addSubview:cointLabel];
   
    /*
    UIButton * detailsButton =[UIButton buttonWithType:UIButtonTypeCustom];
    detailsButton.frame = CGRectMake(280, 222, 30, 30);
    [detailsButton setImage:[UIImage imageNamed:@"ExchangeCoinButton"] forState:UIControlStateNormal];
    [detailsButton addTarget:self action:@selector(detailsButton_touch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:detailsButton];
     */
     
    self.exchangeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, 320, self.view.frame.size.height-120-TabViewHeight)];
    //self.exchangeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.exchangeTableView.delegate = self;
    self.exchangeTableView.dataSource = self;
    self.exchangeTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.exchangeTableView];
    
   
    
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
    AllWebViewController *allweb = [[AllWebViewController alloc] init:@"http://222.73.60.153:8089/exchange_list.html" withType:WebType_Search details:nil];
    [self.navigationController pushViewController:allweb animated:YES];
}

/*
-(void)detailsButton_touch
{
    MyPropertyInformationViewController *myPropertyInfo = [[MyPropertyInformationViewController alloc] init];
    [self.navigationController pushViewController:myPropertyInfo animated:YES];
}

-(void)historyButton_touch
{
    ExchangeHistoryViewController *exchangeHistroy = [[ExchangeHistoryViewController alloc] init];
    [self.navigationController pushViewController:exchangeHistroy animated:YES];
}
 */


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [CacheDataManager sharedInstance].exchangeProjectsList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    ExchangePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ExchangePageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    NSDictionary *dict = [[CacheDataManager sharedInstance].exchangeProjectsList objectAtIndex:indexPath.row];
    cell.titleLabel.text = [dict objectForKey:@"title"];
    cell.detailsLabel.text = [dict objectForKey:@"info"];
    cell.priceLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"price"]];
    cell.countLabel.text = [dict objectForKey:@"exchanged_count"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dataDict = [[CacheDataManager sharedInstance].exchangeProjectsList objectAtIndex:indexPath.row];
    AllWebViewController *allweb = [[AllWebViewController alloc] init:@"http://222.73.60.153:8089/exchange.html" withType:WebType_Exchange details:dataDict];
    [self.navigationController pushViewController:allweb animated:YES];
}


-(void)getUserIntegral
{
    if ([CacheDataManager sharedInstance].uuid && ![[CacheDataManager sharedInstance].uuid isEqualToString:@"None"]) {
        [[ServerDataManager sharedInstance] requestUserPointOwnerSearch:[CacheDataManager sharedInstance].uuid  LoginResource:@"None" Request:@"None" completeBlock:^(id reqRes) {
            if (reqRes && [reqRes isKindOfClass:[AFHTTPRequestOperation class]]) {
                AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)reqRes;
                if (operation.response.statusCode == 200) {
                    if ([[CacheDataManager sharedInstance].userIntegral isEqualToString:@"None"]) {
                        [cointLabel  setText:[NSString stringWithFormat:@"可兑换金币: --"]];
                    }else{
                        [cointLabel  setText:[NSString stringWithFormat:@"可兑换金币: %@",[CacheDataManager sharedInstance].userIntegral ]];
                    }
                }
            }
            /*
            if (reqRes) {
                if ([reqRes isKindOfClass:[NSDictionary class]]) {
                    if ([[CacheDataManager sharedInstance].userIntegral isEqualToString:@"None"]) {
                        [cointLabel  setText:[NSString stringWithFormat:@"可兑换金币: --"]];
                    }else{
                        [cointLabel  setText:[NSString stringWithFormat:@"可兑换金币: %@",[CacheDataManager sharedInstance].userIntegral ]];
                    }
                }
            }
             */
            
        }];
    }
}

/*
-(void)minOrAddUserIntegral:(NSString *)gameid mode:(NSString *)mode cout:(NSString *)count
{
    [[ServerDataManager sharedInstance] requestPointsOperation:[CacheDataManager sharedInstance].uuid LoginResource:@"None" GameID:gameid Operation:mode Count:count completeBlock:^(id reqRes) {
        if (reqRes) {
            if ([reqRes isKindOfClass:[NSDictionary class]]) {
                id dict = [reqRes objectForKey:@"dataObject"];
                if ([dict isKindOfClass:[NSDictionary class]]) {
                    int attention = [[dict objectForKey:@"attention"] intValue];
                    if (attention == 0) {
                        [self showMsgTitleIs:@"恭喜" message:@"兑换成功" buttonText:@"好的"];
                    }else if (attention == 1){
                        [self showMsgTitleIs:@"对不起" message:@"您的积分不足" buttonText:@"好的"];
                    }else if (attention == 2){
                        [self showMsgTitleIs:@"对不起" message:@"服务器繁忙,请稍后尝试" buttonText:@"好的"];
                    }
                }
            }
        }
    }];
}
 */

@end
