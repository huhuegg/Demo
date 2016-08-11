//
//  DiscoveryPageViewController.m
//  freepai
//
//  Created by jiangchao on 14-7-1.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "DiscoveryPageViewController.h"
#import "MainViewController.h"
#import "ChatViewController.h"

#import "YukeyFoundationCommon.h"

#import "UIView+YukeyBadgeView.h"
#import "XMPPDataManager.h"

@interface DiscoveryPageViewController ()

@end

@implementation DiscoveryPageViewController

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

#pragma mark - Action


- (void)enterMessageWithAccount:(NSString *)account {
    ChatViewController *demoWeChatMessageTableViewController = [[ChatViewController alloc] init:account];
    [self.navigationController pushViewController:demoWeChatMessageTableViewController animated:YES];
}
/*
- (void)enterNewsController {
    XHNewsTableViewController *newsTableViewController = [[XHNewsTableViewController alloc] init];
    [self pushNewViewController:newsTableViewController];
}
 */

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[XMPPDataManager instance] goOnline];
    
    
    NSMutableArray *dataSource = [NSMutableArray arrayWithArray:[CacheDataManager sharedInstance].sampleFrinendsList];
    for (NSDictionary *dict in [CacheDataManager sharedInstance].sampleFrinendsList) {
        if ([[dict objectForKey:@"account"] isEqualToString:[CacheDataManager sharedInstance].userName]) {
            [dataSource removeObject:dict];
        }
    }
    self.dataSource = dataSource;
    UIEdgeInsets insets = UIEdgeInsetsMake(67, 0, TabViewHeight, 0);
    self.tableView.contentInset = insets;
    self.tableView.scrollIndicatorInsets = insets;
    [self.view addSubview:self.tableView];
    
    
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 67)];
    bgview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgview];
    
    UILabel *homePageTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    homePageTitle.center = CGPointMake(self.view.center.x, 37);
    [homePageTitle  setBackgroundColor:[UIColor whiteColor]];
    [homePageTitle  setFont:[UIFont fontWithName:@"Arial" size:16]];
    [homePageTitle  setText:[NSString stringWithFormat:@"发现"]];
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
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        
    }
    if (indexPath.row < self.dataSource.count) {
        NSDictionary *details = [self.dataSource objectAtIndex:indexPath.row];
        DLog(@"%@",details);
        cell.textLabel.text = [details objectForKey:@"nickname"];
        cell.detailTextLabel.text = [details objectForKey:@"lastmsg"];
        cell.imageView.image = [UIImage imageNamed:@"avator"];
    }
    
    //    cell.imageView.badgeViewFrame = CGRectMake(40, 0, 10, 10);
    //    cell.imageView.badgeView.textColor = [UIColor whiteColor];
    //    cell.imageView.badgeView.badgeColor = [UIColor redColor];
    //    cell.imageView.badgeView.text = @" ";
    [cell.imageView setupCircleBadge];
    
    
    if (indexPath.row == 4) {
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0.097 green:0.633 blue:1.000 alpha:1.000];
    } else {
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MainViewController *mainView = (MainViewController *)self.navigationController.parentViewController;
    mainView.tabView.hidden = YES;
    mainView.tabView.userInteractionEnabled = NO;
    
    NSDictionary *details = [self.dataSource objectAtIndex:indexPath.row];
    NSString *account = [details objectForKey:@"account"];
    [self enterMessageWithAccount:account];
    /*
    if (!indexPath.row) {
        [self enterNewsController];
    } else {
        [self enterMessage];
    }
     */
}


@end
