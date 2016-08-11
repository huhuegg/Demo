//
//  MePageViewController.m
//  freepai
//
//  Created by jiangchao on 14-6-24.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import "MePageViewController.h"
#import "MainViewController.h"
#import "MeAllTableViewCell.h"
#import "MeItemsScrollView.h"
#import "MyAccountViewController.h"
#import "MyAddressViewController.h"
#import "MyQuanZiViewController.h"

@interface MePageViewController ()<UITableViewDataSource,UITableViewDelegate,MeItemsScrollViewDelegate>

@end

@implementation MePageViewController

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
    [homePageTitle  setText:[NSString stringWithFormat:@"我"]];
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
    
    
    self.mePageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT-55-TabViewHeight)];
    self.mePageTableView.tag = 0;
    self.mePageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mePageTableView.delegate = self;
    self.mePageTableView.dataSource = self;
    self.mePageTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mePageTableView];
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


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        return 20;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 150;
    }else{
        return 200;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellIdentifier = @"MeInfoCell";
        MeAllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[MeAllTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        [cell.headImage setImageURL:@"http://e.hiphotos.baidu.com/image/w%3D2048/sign=5454ab5e0bf79052ef1f403e38cbd5ca/c75c10385343fbf2c6e17e6eb27eca8064388faa.jpg"];
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellIdentifier = @"MeAppCell";
        MeAllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            cell = [[MeAllTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        NSArray *newarray = @[@"我的支付宝",@"我的收货地址",@"我的圈子"];
        for (UIView *view in cell.meScrollView.subviews) {
            [view removeFromSuperview];
        }
        MeItemsScrollView *meitems = [[MeItemsScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 150) itemsArray:newarray];
        meitems.delegate = self;
        [cell.meScrollView addSubview:meitems];
        return cell;
    }else{
        return nil;
    }
}

#pragma mark - MeItemsScrollViewDelegate
-(void)touchTheItemWithTitle:(NSString *)title
{
    if ([title isEqualToString:@"我的支付宝"]) {
        MyAccountViewController *myAccout= [[MyAccountViewController alloc] init];
        [self.navigationController pushViewController:myAccout animated:YES];
    }else if ([title isEqualToString:@"我的收货地址"]){
        MyAddressViewController *myAddress= [[MyAddressViewController alloc] init];
        [self.navigationController pushViewController:myAddress animated:YES];
    }else if ([title isEqualToString:@"我的圈子"]){
        MyQuanZiViewController *myQuanZi= [[MyQuanZiViewController alloc] init];
        [self.navigationController pushViewController:myQuanZi animated:YES];
    }
}



@end
