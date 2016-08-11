//
//  UninstalledGameDetailsViewController.h
//  freepai
//
//  Created by jiangchao on 14-6-16.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UninstalledGameDetailsViewController : UIViewController
@property (nonatomic,strong)  ScrollMsgView *scrollMsgView;
@property (nonatomic,strong) UITableView *friendBoardTableView;
@property (nonatomic,strong) UIView *contentView;
-(id)init:(NSString *)gid;
@end
