//
//  HomePageViewController.h
//  freepai
//
//  Created by jiangchao on 14-6-5.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAAutoTableView.h"


@interface HomePageViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *topRecommendedTableView;
@property (nonatomic,strong) NSMutableArray *topRecommendedList;
@property (nonatomic,strong) ScrollMsgView *scrollMsgView;
@end
