//
//  GamePageViewController.m
//  freepai
//
//  Created by jiangchao on 14-6-24.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "GamePageViewController.h"
#import "YukeyScrollView.h"
#import "InstalledGameControl.h"
#import "InstalledGameTableViewCell.h"
#import "UninstalledGameTableViewCell.h"
#import "UninstalledGameDetailsViewController.h"
#import "MainViewController.h"
#import "ShareSDKOperation.h"

@interface GamePageViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation GamePageViewController

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
    
    self.installedGame = [[NSMutableArray alloc] init];
    self.uninstalledGame = [[NSMutableArray alloc] init];
    
    UIImageView *bg_ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 67, self.view.frame.size.width, self.view.frame.size.height - 67)];
    //bg_ImageView.image = [UIImage imageNamed:@"u3"];
    [bg_ImageView setBackgroundColor:[UIColor whiteColor]];
    bg_ImageView.userInteractionEnabled = YES;
    [self.view addSubview:bg_ImageView];
    
    UILabel *homePageTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    homePageTitle.center = CGPointMake(self.view.center.x, 37);
    [homePageTitle  setBackgroundColor:[UIColor whiteColor]];
    [homePageTitle  setFont:[UIFont fontWithName:@"Arial" size:16]];
    [homePageTitle  setText:[NSString stringWithFormat:@"任务派"]];
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
    self.scrollMsgView .backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollMsgView ];
    
    self.gameCenterTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 67,  self.view.frame.size.width, self.view.frame.size.height-67-TabViewHeight)];
    // self.myPropertyInformationTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.gameCenterTableView.delegate = self;
    self.gameCenterTableView.dataSource = self;
    self.gameCenterTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.gameCenterTableView];
    
    [self getGameList];
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

-(void)installedGameControl_touch:(id)sender
{
    InstalledGameControl *installedGameControl = (InstalledGameControl *)sender;
    NSLog(@"%@",installedGameControl.url);
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://",@"FP32dd5akxiioq8a6x"]]];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"欢迎来到"
                                                        message:[NSString stringWithFormat:@"%@",installedGameControl.url]
                                                       delegate:self
                                              cancelButtonTitle:@"分享"
                                              otherButtonTitles:@"进入",nil];
    [alertView showAlertViewWithCompleteBlock:^(NSInteger buttonIndex) {
        if (buttonIndex == 0) {
           // [[ShareSDKOperation sharedInstance] shareAllButtonClickHandler:self.view withContent:@"1111" withURL:@"www.baidu.com" withimage:nil withTitle:@"TESt"];
        }
    }];
}


-(void)getGameList
{
    [[ServerDataManager sharedInstance] requestUserSearchGameStatus:[CacheDataManager sharedInstance].uuid LoginResource:@"None" Request:@"None" completeBlock:^(id reqRes) {
        if (reqRes && [reqRes isKindOfClass:[AFHTTPRequestOperation class]]) {
            AFHTTPRequestOperation *operation = (AFHTTPRequestOperation *)reqRes;
            if (operation.response.statusCode == 200) {
                NSDictionary *dict = [BaseTools decodeJsonString:operation.responseData];
                id dataObject = [dict objectForKey:@"dataObject"];
                for (NSDictionary *dic in [dataObject objectForKey:@"details"]) {
                    if ([self APCheckIfAppInstalled2:[NSString stringWithFormat:@"%@://",[dic objectForKey:@"game_id"]]]) {
                        [self.installedGame addObject:dic];
                    }else{
                        [self.uninstalledGame addObject:dic];
                    }
                }
                DLog(@"%@,%@",self.installedGame,self.uninstalledGame);
                NSDictionary *tmpdict = @{@"game_id":@"FP32dd5akxiioq8a6x"};
                [self.installedGame addObject:tmpdict];
                [self.gameCenterTableView reloadData];
            }
        }
    }];
}


-(BOOL) APCheckIfAppInstalled2:(NSString *)urlSchemes
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlSchemes]])
    {
        NSLog(@"%@",urlSchemes);
        
        return YES;
    }
    else
    {
        return NO;
    }
}

#pragma mark - Table view data source


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 150;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    YukeyScrollView *yukeyScrollView = [[YukeyScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 150) withImageArray:@[@"one",@"two",@"three",@"four"]];
    yukeyScrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:yukeyScrollView];
    if (section == 0) {
        return yukeyScrollView;
    }
    return nil;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else if (section == 1){
        if (self.installedGame.count == 0) {
            return 0;
        }
        return 1;
    }else if (section == 2){
        return self.uninstalledGame.count;
    }
    return 0;
}

/*
 -(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
 {
 
 }
 */

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSLog(@"Number of Sections");
    if(section == 1)
        return @"已安装的游戏";
    if(section == 2)
        return @"未安装的游戏";
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 80;
    }else if (indexPath.section == 2){
        return 50;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        static NSString *cellIdentifier = @"GameCenterOnecell";
        InstalledGameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[InstalledGameTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        for (int i = 0 ; i < self.installedGame.count; i++) {
            NSDictionary *dict =[self.installedGame objectAtIndex:[indexPath row]];
            if (dict) {
                NSString *title;
                if ([[dict objectForKey:@"game_id"] isEqualToString:@"FP32dd5akxiioq8a6x"]) {
                    title = @"GAME_ONE";
                }else if ([[dict objectForKey:@"game_id"] isEqualToString:@"45ax890huurw21al"]){
                    title = @"GAME_TWO";
                }
                InstalledGameControl *installedGameControl = [[InstalledGameControl alloc] initWithFrame:CGRectMake(10+i*(40+10), 10, 40, 70) image:[BaseTools randomUIImage] titile:title URL:[dict objectForKey:@"game_id"]];
                installedGameControl.tag = i;
                [installedGameControl addTarget:self action:@selector(installedGameControl_touch:) forControlEvents:UIControlEventTouchUpInside];
                [cell.installedGameScrollView addSubview:installedGameControl];
                if (installedGameControl.frame.origin.x+installedGameControl.frame.size.width +10 >cell.installedGameScrollView.frame.size.width) {
                    cell.installedGameScrollView.contentSize = CGSizeMake(installedGameControl.frame.origin.x+installedGameControl.frame.size.width +10, cell.installedGameScrollView.frame.size.height);
                }
            }
        }
        return cell;
    }else if (indexPath.section == 2){
        static NSString *cellIdentifier = @"GameCenterTwocell";
        UninstalledGameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[UninstalledGameTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        NSDictionary *dict =[self.uninstalledGame objectAtIndex:[indexPath row]];
        if (dict) {
            if ([[dict objectForKey:@"game_id"] isEqualToString:@"FP32dd5akxiioq8a6x"]) {
                cell.mainLabel.text=@"GAME_ONE";
            }else if ([[dict objectForKey:@"game_id"] isEqualToString:@"45ax890huurw21al"]){
                cell.mainLabel.text=@"GAME_TWO";
            }
            cell.secondLabel.text =   [NSString stringWithFormat:@"有%@好友在玩",[dict objectForKey:@"friend"]];
        }
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        DLog(@"%@",[self.uninstalledGame objectAtIndex:indexPath.row]);
        NSString *gameid = [[self.uninstalledGame objectAtIndex:indexPath.row] objectForKey:@"game_id"];
        UninstalledGameDetailsViewController *uninstallGameDetails = [[UninstalledGameDetailsViewController alloc] init:gameid];
        [self.navigationController pushViewController:uninstallGameDetails animated:YES];
    }
}

@end

