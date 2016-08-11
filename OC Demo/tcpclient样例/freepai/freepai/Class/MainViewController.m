//
//  MainViewController.m
//  freepai
//
//  Created by jiangchao on 14-6-5.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "MainViewController.h"
#import "HomePageViewController.h"
#import "MePageViewController.h"
#import "ActitvityPageViewController.h"
#import "GamePageViewController.h"
#import "DiscoveryPageViewController.h"

@interface MainViewController ()
{
    UIView *contentView;
}

@end

@implementation MainViewController

//初始化childViewControllers
-(void)initializeChildViewControllers
{
    HomePageViewController *homePage = [[HomePageViewController alloc] init];
    UINavigationController *homePageNav = [[UINavigationController alloc] initWithRootViewController:homePage];
    homePageNav.navigationBarHidden = YES;
    homePageNav.interactivePopGestureRecognizer.enabled = NO;
    [self addChildViewController:homePageNav];
    
    ActitvityPageViewController *actitvityPage = [[ActitvityPageViewController alloc] init];
    UINavigationController *actitvityPageNav = [[UINavigationController alloc] initWithRootViewController:actitvityPage];
    actitvityPageNav.navigationBarHidden = YES;
    actitvityPageNav.interactivePopGestureRecognizer.enabled = NO;
    [self addChildViewController:actitvityPageNav];
    
    /*
    TeamPaiViewController *teamPai = [[TeamPaiViewController alloc] init];
    UINavigationController *teamPaiNav = [[UINavigationController alloc] initWithRootViewController:teamPai];
    teamPaiNav.navigationBarHidden = YES;
    teamPaiNav.interactivePopGestureRecognizer.enabled = NO;
    [self addChildViewController:teamPaiNav];
    */
    GamePageViewController *gamePage = [[GamePageViewController alloc]init];
    UINavigationController *gamePageNav = [[UINavigationController alloc] initWithRootViewController:gamePage];
    gamePageNav.navigationBarHidden = YES;
    gamePageNav.interactivePopGestureRecognizer.enabled = NO;
    [self addChildViewController:gamePageNav];
    
    /*
    TaskPaiViewController *taskPai = [[TaskPaiViewController alloc] init];
    UINavigationController *taskPaiNav = [[UINavigationController alloc] initWithRootViewController:taskPai];
    taskPaiNav.navigationBarHidden = YES;
    taskPaiNav.interactivePopGestureRecognizer.enabled = NO;
    [self addChildViewController:taskPaiNav];
     */
    
    DiscoveryPageViewController *discoverPage = [[DiscoveryPageViewController alloc]init];
    UINavigationController *discoverPageNav = [[UINavigationController alloc]initWithRootViewController:discoverPage];
    discoverPageNav.navigationBarHidden = YES;
    discoverPageNav.interactivePopGestureRecognizer.enabled = NO;
    [self addChildViewController:discoverPageNav];
    
    
    MePageViewController *me = [[MePageViewController alloc] init];
    UINavigationController *meNav = [[UINavigationController alloc] initWithRootViewController:me];
    meNav.navigationBarHidden = YES;
    meNav.interactivePopGestureRecognizer.enabled = NO;
    [self addChildViewController:meNav];
    
    [contentView addSubview:homePageNav.view];
    self.currentViewController = homePageNav;
}

//初始化tabView
-(void)initializeTabView
{
    self.tabView = [[RKTabView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - TabViewHeight, SCREEN_WIDTH, TabViewHeight)];
    self.tabView.delegate = self;
    self.tabView.backgroundColor = [UIColor whiteColor];
    /*
    RKTabItem *personalPaiTabItem = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"TabBar1_off"] imageDisabled:[UIImage imageNamed:@"TabBar1_on"]];
    RKTabItem *teamPaiTabItem = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"TabBar2_off"] imageDisabled:[UIImage imageNamed:@"TabBar2_on"]];
    RKTabItem *taskPaiTabItem = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"TabBar3_off"] imageDisabled:[UIImage imageNamed:@"TabBar3_on"]];
    RKTabItem *meTabItem = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"TabBar4_off"] imageDisabled:[UIImage imageNamed:@"TabBar4_on"]];
     */
    RKTabItem *actitvityTabItem = [RKTabItem createUsualItemWithImageEnabled:nil imageDisabled:nil];
    actitvityTabItem.titleString =@"活动";
    RKTabItem *gameTabItem = [RKTabItem createUsualItemWithImageEnabled:nil imageDisabled:nil];
    gameTabItem.titleString = @"游戏";
    RKTabItem *discoverTabItem = [RKTabItem createUsualItemWithImageEnabled:nil imageDisabled:nil];
    discoverTabItem.titleString = @"发现";
    RKTabItem *meTabItem = [RKTabItem createUsualItemWithImageEnabled:nil imageDisabled:nil];
    meTabItem.titleString = @"我";
    self.tabView.horizontalInsets = HorizontalEdgeInsetsMake(0, 0);
    self.tabView.tabItems = @[actitvityTabItem, gameTabItem, discoverTabItem, meTabItem];
    [self.view addSubview:self.tabView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    contentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:contentView];
    
    [self initializeTabView];
    [self initializeChildViewControllers];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    self.tabView = nil;
    contentView = nil;
    self.currentViewController = nil;
}

#pragma mark - RKTabViewDelegate
- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem
{
    UINavigationController *actitvityNav = (self.childViewControllers.count >= 2)?[self.childViewControllers objectAtIndex:1]:nil;
    UINavigationController *gameNav = (self.childViewControllers.count >= 3)?[self.childViewControllers objectAtIndex:2]:nil;
    UINavigationController *discoverNav = (self.childViewControllers.count >= 4)?[self.childViewControllers objectAtIndex:3]:nil;
    UINavigationController *meNav = (self.childViewControllers.count >= 5)?[self.childViewControllers objectAtIndex:4]:nil;
    UIViewController *oldViewController=self.currentViewController;
    if (index == 0) {
        if (actitvityNav) {
            [self transitionFromViewController:self.currentViewController toViewController:actitvityNav duration:1.0 options:UIViewAnimationOptionTransitionNone animations:^{
                [actitvityNav popToRootViewControllerAnimated:YES];
            } completion:^(BOOL finished) {
                if (finished) {
                    self.currentViewController = actitvityNav;
                }else{
                    self.currentViewController = oldViewController;
                }
                
            }];
        }
    }else if (index == 1){
        if (gameNav) {
            [self transitionFromViewController:self.currentViewController toViewController:gameNav duration:1.0 options:UIViewAnimationOptionTransitionNone animations:^{
                [gameNav popToRootViewControllerAnimated:YES];
            } completion:^(BOOL finished) {
                if (finished) {
                    self.currentViewController = gameNav;
                }else{
                    self.currentViewController = oldViewController;
                }
            }];
        }
    }else if (index == 2){
        if (discoverNav) {
            [self transitionFromViewController:self.currentViewController toViewController:discoverNav duration:1.0 options:UIViewAnimationOptionTransitionNone animations:^{
                [discoverNav popToRootViewControllerAnimated:YES];
            } completion:^(BOOL finished) {
                if (finished) {
                    self.currentViewController = discoverNav;
                }else{
                    self.currentViewController = oldViewController;
                }
                
            }];
        }
    }else if (index == 3){
        if (meNav) {
            [self transitionFromViewController:self.currentViewController toViewController:meNav duration:1.0 options:UIViewAnimationOptionTransitionNone animations:^{
                [meNav popToRootViewControllerAnimated:YES];
            } completion:^(BOOL finished) {
                if (finished) {
                    self.currentViewController = meNav;
                }else{
                    self.currentViewController = oldViewController;
                }
                
            }];
        }
    }
}

- (void)tabView:(RKTabView *)tabView tabBecameDisabledAtIndex:(int)index tab:(RKTabItem *)tabItem
{
    
}

@end
