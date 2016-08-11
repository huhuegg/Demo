//
//  ScoreBoardViewController.h
//  freepai
//
//  Created by jiangchao on 14-6-5.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreBoardViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *scoreBoardTableView;
@property (nonatomic,strong) NSMutableArray *scoreBoardList;
@property (nonatomic,strong) ScrollMsgView *scrollMsgView;
@end
