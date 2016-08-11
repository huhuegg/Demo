//
//  MeViewController.h
//  freepai
//
//  Created by jiangchao on 14-6-5.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Me_PersonalInfoView.h"

@interface MeViewController : UIViewController
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) Me_PersonalInfoView *personalInfoView;
@property (nonatomic,strong) UITableView *leavePartyTableView;
@property (nonatomic,strong) NSMutableArray *leavePartyList;
@property (nonatomic,strong) UITableView *joinPartyTableView;
@property (nonatomic,strong) NSMutableArray *joinPartyList;
@property (nonatomic,strong) UISearchBar *mysearchBar;
@property (nonatomic,strong) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic,strong) ScrollMsgView *scrollMsgView;
@end
