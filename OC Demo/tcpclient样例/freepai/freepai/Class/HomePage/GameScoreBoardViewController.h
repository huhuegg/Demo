//
//  GameScoreBoardViewController.h
//  freepai
//
//  Created by jiangchao on 14-6-18.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameScoreBoardViewController : UIViewController
@property (nonatomic,strong)  ScrollMsgView *scrollMsgView;
@property (nonatomic,strong) UITableView *friendBoardTableView;
-(id)init:(NSString *)gid name:(NSString *)name;
@end
