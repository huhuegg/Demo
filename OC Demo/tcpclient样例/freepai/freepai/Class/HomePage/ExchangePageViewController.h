//
//  ExchangePageViewController.h
//  freepai
//
//  Created by jiangchao on 14-6-5.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExchangePageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *exchangeTableView;
@property (nonatomic,strong) NSMutableArray *exchangeList;
@property (nonatomic,strong) ScrollMsgView *scrollMsgView;
@end
