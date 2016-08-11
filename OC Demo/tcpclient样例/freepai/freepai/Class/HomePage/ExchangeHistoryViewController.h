//
//  ExchangeHistoryViewController.h
//  freepai
//
//  Created by jiangchao on 14-6-5.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExchangeHistoryViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *exchangeHistoryTableView;
@property (nonatomic,strong) NSMutableArray *exchangeHistoryList;

@end
