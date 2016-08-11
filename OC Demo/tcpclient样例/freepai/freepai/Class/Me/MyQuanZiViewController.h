//
//  MyQuanZiViewController.h
//  freepai
//
//  Created by jiangchao on 14-6-25.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyQuanZiViewController : UIViewController
@property (nonatomic,strong) UITableView *meQuanZiTableView;
@property (nonatomic,strong) NSMutableArray *addQuanZiList;
@property (nonatomic,strong) UITapGestureRecognizer *tapRecognizer;
@end
