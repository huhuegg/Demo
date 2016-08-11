//
//  haggleViewController.h
//  freepai
//
//  Created by admin on 14/6/16.
//  Copyright (c) 2014年 jiangchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZTimerLabel.h"

@interface haggleViewController : UIViewController <MZTimerLabelDelegate,UITextFieldDelegate>
@property (nonatomic,strong) ScrollMsgView *scrollMsgView;
@property (nonatomic,strong) UITextField *inputPriceTextField;
@property BOOL isActive;
-(id)init:(NSDictionary *)details;
@end
