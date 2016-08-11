//
//  MainViewController.h
//  freepai
//
//  Created by jiangchao on 14-6-5.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RKTabView.h"

@interface MainViewController : UIViewController<RKTabViewDelegate>
@property (strong,nonatomic) RKTabView *tabView;
@property (strong,nonatomic) UIViewController *currentViewController;
@end
