//
//  MyAddressViewController.h
//  freepai
//
//  Created by jiangchao on 14-6-25.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAddressViewController : UIViewController
@property (nonatomic,strong) UITableView *meAddressTableView;
@property (nonatomic,strong) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic,strong) NSMutableArray *addressList;
@end
