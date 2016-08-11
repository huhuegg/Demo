//
//  ActitvityPageViewController.m
//  freepai
//
//  Created by jiangchao on 14-6-24.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "ActitvityPageViewController.h"
#import "ActivityAllTableViewCell.h"
#import "MainViewController.h"
#import "YukeyScrollView.h"
#import "InviteFriendsViewController.h"
#import "KillPriceViewController.h"
#import "RedEnvelopeViewController.h"

@interface ActitvityPageViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ActitvityPageViewController

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
    [homePageTitle  setText:[NSString stringWithFormat:@"活动"]];
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
    
    YukeyScrollView *yukeyScrollView = [[YukeyScrollView alloc] initWithFrame:CGRectMake(0, 67, 320, 150) withImageArray:@[@"one",@"two",@"three",@"four"]];
    yukeyScrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:yukeyScrollView];
    
    self.actitvityPageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 217, 320, self.view.frame.size.height-217-TabViewHeight)];
    // self.myPropertyInformationTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.actitvityPageTableView.delegate = self;
    self.actitvityPageTableView.dataSource = self;
    self.actitvityPageTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.actitvityPageTableView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    self.actitvityPageTableView = nil;
    self.scrollMsgView = nil;
}

#pragma mark - ButtonAction
-(void)leftControl_touch
{
    MainViewController *viewController = (MainViewController *)self.navigationController.parentViewController;
    if (viewController) {
        UINavigationController *homePageNav = (viewController.childViewControllers.count >= 1)?[viewController.childViewControllers objectAtIndex:0]:nil;
        UIViewController *oldViewController=viewController.currentViewController;
        if (homePageNav && oldViewController) {
            [viewController transitionFromViewController:viewController.currentViewController toViewController:homePageNav duration:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
                [homePageNav popToRootViewControllerAnimated:YES];
            } completion:^(BOOL finished) {
                
                NSArray *items = viewController.tabView.tabItems;
                for (RKTabItem *item in items) {
                    if ( (int)item.tabState == 0) {
                        [item switchState];
                    }
                }
                viewController.tabView.tabItems = items;
                
                
                if (finished) {
                    viewController.currentViewController = homePageNav;
                }else{
                    viewController.currentViewController = oldViewController;
                }
            }];
        }
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [CacheDataManager sharedInstance].activityList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ActivityPageCell";
    ActivityAllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ActivityAllTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    id dict = [[CacheDataManager sharedInstance].activityList objectAtIndex:[indexPath row]];
    if ([dict isKindOfClass:[NSDictionary class]]) {
        cell.mainLabel.text = [dict objectForKey:@"title"];
        cell.secondLabel.text = [dict objectForKey:@"info"];
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
    if ([indexPath row] == 0) {
        InviteFriendsViewController *inviteFriends = [[InviteFriendsViewController alloc] init];
        [self.navigationController pushViewController:inviteFriends animated:YES];
    } else if ([indexPath row] == 1) { //杀价王
        KillPriceViewController *killPrice = [[KillPriceViewController alloc] init];
        [self.navigationController pushViewController:killPrice animated:YES];
    }else if ([indexPath row] == 2) { //杀价王
        RedEnvelopeViewController *redEnvelope = [[RedEnvelopeViewController alloc] init];
        [self.navigationController pushViewController:redEnvelope animated:YES];
    }else if ([indexPath row] == 3) {
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
