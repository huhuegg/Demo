//
//  MyPropertyInformationViewController.h
//  freepai
//
//  Created by jiangchao on 14-6-5.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPropertyInformationViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *myPropertyInformationTableView;
@property (nonatomic,strong) NSMutableArray *myPropertyInformationList;
@property (nonatomic,strong) ScrollMsgView *scrollMsgView;
@end
