//
//  GamePageViewController.h
//  freepai
//
//  Created by jiangchao on 14-6-24.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GamePageViewController : UIViewController
@property (nonatomic,strong) UITableView *gameCenterTableView;
@property (nonatomic,strong) NSMutableArray *uninstalledGame;
@property (nonatomic,strong) NSMutableArray *installedGame;
@property (nonatomic,strong) ScrollMsgView *scrollMsgView;
@end
