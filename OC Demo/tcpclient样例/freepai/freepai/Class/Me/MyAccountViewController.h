//
//  MyAccountViewController.h
//  freepai
//
//  Created by jiangchao on 14-6-25.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAccountViewController : UIViewController
@property (nonatomic,strong) UITableView *meAccountTableView;
@property (nonatomic,strong) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic,strong) NSMutableArray *accountList;
@end
